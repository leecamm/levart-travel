//
//  TaskRepository.swift
//  Levart Travel
//
//  Created by Duc Hieu Le on 08/12/2022.
//

import Foundation
import Resolver
import Combine
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class BasePackingItemRepository {
    @Published var packingItems = [PackingItem]()
}

protocol PackingItemRepository: BasePackingItemRepository {
    func addPackingItem(_ packingItem: PackingItem)
    func removePackingItem(_ packingItem: PackingItem)
    func updatePackingItem(_ packingItem: PackingItem)
}

//MARK: Firebase task
class FirestorePackingItemRepository: BasePackingItemRepository, PackingItemRepository, ObservableObject {
  var db = Firestore.firestore()
  
  @Injected var authenticationService: AuthenticationViewModel // (1)
  var packingListsPath: String = "tasks" // (2)
  var userId: String = "unknown"
  
  private var cancellables = Set<AnyCancellable>()
  
  override init() {
    super.init()
    
    authenticationService.$user
      .compactMap { user in
        user?.uid 
      }
      .assign(to: \.userId, on: self)
      .store(in: &cancellables)
    
    // (re)load data if user changes
    authenticationService.$user
      .receive(on: DispatchQueue.main)
      .sink { user in
        self.loadData()
      }
      .store(in: &cancellables)
  }
  
  func loadData() {
      guard let userID = Auth.auth().currentUser?.uid else { return }
      print(userID)
      
      let packingListRef = db.collection("users").document(userID).collection("packingList")
      
    packingListRef
//          .whereField("category", isEqualTo: "Clothes")
      .addSnapshotListener { (querySnapshot, error) in
        if let querySnapshot = querySnapshot {
          self.packingItems = querySnapshot.documents.compactMap { document -> PackingItem? in
            try? document.data(as: PackingItem.self)
          }
        }
      }
  }
    
//    func fetchData() {
//        guard let userID = Auth.auth().currentUser?.uid else { return }
//        print(userID)
//
//        let packingListRef = db.collection("users").document(userID).collection("packingList")
//
//        packingListRef.addSnapshotListener() {(querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//
//            packingListRef.addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else {
//                    print("No documents")
//                    return
//                }
//
//                self.packingItems = documents.map { queryDocumentSnapshot -> PackingItem in
//                    let data = queryDocumentSnapshot.data()
//                    print(data)
//                  let id = data["documentId"] as String ?? ""
//                    let name = data["name"] as? String ?? ""
//                    let category = data["category"] as? String ?? ""
//                    let isPacked = data["isPacked"] as? Bool ?? true
//
//                    print(PackingItem(id: .init(), name: name, category: category, isPacked: isPacked))
//                    return PackingItem(id: .init(), name: name, category: category, isPacked: isPacked)
//                }
//            }
//        }
//    }
  
  func addPackingItem(_ packingItem: PackingItem) {
      guard let userID = Auth.auth().currentUser?.uid else { return }
      print(userID)
      let packingListRef = db.collection("users").document(userID).collection("packingList")
    do {
      var userPackingItem = packingItem
        userPackingItem.userId = self.userId // (10)
        let _ = try packingListRef.addDocument(from: userPackingItem)
        print("Added item")
    }
    catch {
      fatalError("Unable to encode task: \(error.localizedDescription).")
    }
  }
  
  func removePackingItem(_ packingItem: PackingItem) {
      guard let userID = Auth.auth().currentUser?.uid else { return }
      print(userID)
      let packingListRef = db.collection("users").document(userID).collection("packingList")
      
    if let packingItemID = packingItem.id {
        print("packingItemID: \(packingItemID)")
        packingListRef.document(packingItemID).delete { (error) in
        if let error = error {
          print("Unable to remove document: \(error.localizedDescription)")
        }
      }
    }
  }
  
  func updatePackingItem(_ packingItem: PackingItem) {
      guard let userID = Auth.auth().currentUser?.uid else { return }
      print(userID)
      let packingListRef = db.collection("users").document(userID).collection("packingList")
      
    if let packingItemID = packingItem.id {
      do {
          try packingListRef.document(packingItemID).setData(from: packingItem, merge: true)
          print("Updated task")
      }
      catch {
        fatalError("Unable to encode task: \(error.localizedDescription).")
      }
    }
  }
}
