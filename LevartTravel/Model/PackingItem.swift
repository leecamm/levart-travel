//
//  PackingList.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 09/12/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct PackingItem: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var category: String
    var isPacked: Bool
    var userId: String?
}

