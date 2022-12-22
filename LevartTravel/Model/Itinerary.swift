//
//  Itinerary.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 21/12/2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Itinerary: Codable, Identifiable {
    var id = UUID().uuidString
//    @DocumentID var id: String?
    var itineraryTitle: String
    var itineraryDescription: String
    var itineraryDate: Date
}
