//
//  PackingItemCellViewModel.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 09/12/2022.
//

import Foundation
import Combine
import Resolver

class PackingItemCellViewModel: ObservableObject, Identifiable  {
    
  @Published var packingItemRepository: PackingItemRepository = Resolver.resolve()
  @Published var packingItem: PackingItem
  
  var id: String = ""
  @Published var completionStateIconName = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  static func newPackingItem() -> PackingItemCellViewModel {
      PackingItemCellViewModel(packingItem: PackingItem(name: "", category: "", isPacked: false))
  }
  
  init(packingItem: PackingItem) {
    self.packingItem = packingItem

    $packingItem // (8)
      .map { $0.isPacked ? "checkmark.circle.fill" : "circle" }
      .assign(to: \.completionStateIconName, on: self)
      .store(in: &cancellables)

    $packingItem // (7)
      .map { $0.id ?? "" }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)

    $packingItem
          .dropFirst()
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .sink { packingItem in
              self.packingItemRepository.updatePackingItem(packingItem)
          }
          .store(in: &cancellables)
  }
  
}

