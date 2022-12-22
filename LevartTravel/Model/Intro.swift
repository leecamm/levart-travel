//
//  Intro.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 11/11/2022.
//

import SwiftUI

// MARK: Intro Model and Sample Intro's
struct Intro: Identifiable {
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
    var description: String
}

var intros: [Intro] = [
    .init(imageName: "Image 1", title: "Packing", description: "Never forget your stuff with a pre-made packing list"),
    .init(imageName: "Image 2", title: "Planning", description: "Easily plan your future trip in a smart way"),
    .init(imageName: "Image 3", title: "Tracking", description: "Always know where you are in the itinerary"),
    .init(imageName: "Image 4", title: "Finding", description: "Easily locate your tour guide when in range")
]

// MARK: Font String's

// MARK: Dummy Text
let dummyText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
