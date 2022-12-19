//
//  DestinationViewModel.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 14/12/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Destination: Identifiable {
    var id: UUID
    var name: String
    var description: String
    var imgUrl: String
}

class DestinationViewModel: ObservableObject {
    @Published var destinations = [Destination]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        
        let destinationRef = db.collection("destination").order(by: "name", descending: false)
        
        destinationRef.getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
            
            
            destinationRef.addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.destinations = documents.map { queryDocumentSnapshot -> Destination in
                    let data = queryDocumentSnapshot.data()
                    let name = data["name"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let imgUrl = data["imgUrl"] as? String ?? ""
                    
                    print(Destination(id: .init(), name: name, description: description, imgUrl: imgUrl))
                    return Destination(id: .init(), name: name, description: description, imgUrl: imgUrl)
                }
            }
        }
    }
}
