//
//  Book.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 01/12/2022.
//

import Foundation

struct Book: Identifiable {
  var id: UUID
  var title: String
  var author: String
  var numberOfPages: Int
}
