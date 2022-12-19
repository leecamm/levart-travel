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
            
                packingItemRepository.removePackingItem(packingItemCellViewModel.packingItem)
           
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
