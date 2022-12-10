//
//  AuthenticationViewModel.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 30/11/2022.
//

import Foundation
import Firebase
import GoogleSignIn
import FirebaseFirestore

class AuthenticationViewModel: ObservableObject {

  @Published var user: User?
  // 1
  enum SignInState {
    case signedIn
    case signedOut
  }

  // 2
  @Published var state: SignInState = .signedOut
    
    func signIn() {
        // 1
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
          GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
            authenticateUser(for: user, with: error)
          }
        } else {
          // 2
          guard let clientID = FirebaseApp.app()?.options.clientID else { return }
          
          // 3
          let configuration = GIDConfiguration(clientID: clientID)
          
          // 4
          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
          guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
          
          // 5
          GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
            authenticateUser(for: user, with: error)
              
          }
        }
      }
      
      private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        // 1
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        // 2
        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        // 3
        Auth.auth().signIn(with: credential) { [unowned self] (result, error) in
          if let error = error {
            print(error.localizedDescription)
          } else {
            state = .signedIn
              
            let db = Firestore.firestore()
//              var ref: DocumentReference? = nil
           
              db.collection("users").document((result!.user.uid)).setData([
                "email": result!.user.email ?? "",
                "name": result!.user.displayName ?? "",
                "uid":result!.user.uid
              ]) { err in
                  if let err = err {
                      print("Error adding document: \(err)")
                  } else {
                      print("Document added with ID: \(result!.user.uid)")
                  }
              }
          }
        }
      }
      
      func signOut() {
        // 1
        GIDSignIn.sharedInstance.signOut()
        
        do {
          // 2
          try Auth.auth().signOut()
          
          state = .signedOut
        } catch {
          print(error.localizedDescription)
        }
      }
}


