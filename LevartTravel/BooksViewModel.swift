//
//  BookViewModel.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 01/12/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class BooksViewModel: ObservableObject {
    @Published var books = [Book]()
    
    private var db = Firestore.firestore()
    
    
    func fetchData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        print(userID)
        
        let bookRef = db.collection("users").document(userID).collection("books")
        
        bookRef.getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
            
            
            bookRef.addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.books = documents.map { queryDocumentSnapshot -> Book in
                    let data = queryDocumentSnapshot.data()
                    let title = data["title"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let numberOfPages = data["pages"] as? Int ?? 0
                    
                    print(Book(id: .init(), title: title, author: author, numberOfPages: numberOfPages))
                    return Book(id: .init(), title: title, author: author, numberOfPages: numberOfPages)
                }
            }
        }
    }
}
