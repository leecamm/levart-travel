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
}

var intros: [Intro] = [
    .init(imageName: "Image 1", title: "Packing"),
    .init(imageName: "Image 2", title: "Planning"),
    .init(imageName: "Image 3", title: "Tracking"),
    .init(imageName: "Image 4", title: "Finding")
]

// MARK: Font String's

// MARK: Dummy Text
let dummyText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
