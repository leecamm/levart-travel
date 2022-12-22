//
//  Itinerary.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 21/12/2022.
//

import Foundation
import SwiftUI

struct Itinerary: Identifiable {
    var id = UUID().uuidString
    var itineraryTitle: String
    var itineraryDescription: String
    var itineraryDate: Date
}
