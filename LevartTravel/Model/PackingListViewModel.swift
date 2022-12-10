//
//  PackingListViewModel.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 07/12/2022.
//

import Foundation
import Combine
import Resolver
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

//struct PackingList: Codable, Identifiable {
//  var id: UUID
//  var name: String
//  var category: String
//  var isPacked: Bool
//}

class PackingListViewModel: ObservableObject {
    
    @Published var packingItemRepository: PackingItemRepository = Resolver.resolve()
    @Published var packingItemCellViewModels = [PackingItemCellViewModel]()
    
    
    private var cancellables = Set<AnyCancellable>()

//    var db = Firestore.firestore()
//    
//    func fetchData() {
//        guard let userID = Auth.auth().currentUser?.uid else { return }
//        print(userID)
//
//        let packingListRef = db.collection("users").document(userID).collection("packingList")
//
//        packingListRef.getDocuments() {(querySnapshot, err) in
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
//                self.packingItemRepository = documents.map { queryDocumentSnapshot -> PackingItem in
//                    let data = queryDocumentSnapshot.data()
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
//
//    func updatePackingItem(packingListItemID: String, isPacked: Bool) {
//            guard let userID = Auth.auth().currentUser?.uid else { return }
//
//            let packingListRef = db.collection("users").document(userID).collection("packingList")
//
//            let docRef = packingListRef.document(packingListItemID)
//
//                    // Don't forget the **merge: true** before closing the parentheses!
//                    docRef.setData(["isPacked": isPacked], merge: true) { error in
//                        if let error = error {
//                            print("Error writing document: \(error)")
//                        } else {
//                            print("Document successfully merged!")
//                        }
//                    }
//    }
    
//MARK: NEW Iteration
    init() {
        packingItemRepository.$packingItems.map { packingItems in
            packingItems.map { packingItem in
                PackingItemCellViewModel(packingItem: packingItem) // (2)
            }
        }
        .assign(to: \.packingItemCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func removePackingItems(atOffsets indexSet: IndexSet) {
        // remove from repo
        let viewModels = indexSet.lazy.map { self.packingItemCellViewModels[$0] }
        viewModels.forEach { packingItemCellViewModel in
            packingItemRepository.removePackingItem(packingItemCellViewModel.packingItem) // (1)
        }
    }
    
    func updatePackingItem(_ packingItem: PackingItem) {
        if let index = packingItemRepository.packingItems.firstIndex(where: { $0.id == packingItem.id} ) {
        packingItemRepository.packingItems[index] = packingItem
        packingItemRepository.updatePackingItem(packingItem)
      }
    }
    
    func addPackingItem(packingItem: PackingItem) {
        packingItemRepository.addPackingItem(packingItem)
    }
    
}
