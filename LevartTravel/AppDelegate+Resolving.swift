//
//  AppDelegate+Resolving.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 08/12/2022.
//


import Foundation
import Resolver

extension Resolver: ResolverRegistering {

  public static func registerAllServices() {
      register { AuthenticationViewModel() }.scope(.application)
      register { FirestorePackingItemRepository() as PackingItemRepository }.scope(.application)
  }
}
