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

let Item = [
    [
        "name": "Passport",
        "category": "Documents",
        "isPacked": false
    ],
    [
        "name": "Valid Visa",
        "category": "Documents",
        "isPacked": false
    ],
    [
        "name": "Travel Insurance",
        "category": "Documents",
        "isPacked": false
    ],
    [
        "name": "Debit-Credit Card",
        "category": "Carries on",
        "isPacked": false
    ],
    [
        "name": "Bugs Protection",
        "category": "Toiletries",
        "isPacked": false
    ],
    [
        "name": "Sun cream",
        "category": "Toiletries",
        "isPacked": false
    ],
    [
        "name": "First-aid Kit",
        "category": "Toiletries",
        "isPacked": false
    ],
    [
        "name": "Sun cream",
        "category": "Toiletries",
        "isPacked": false
    ],
    [
        "name": "Toothbrush-Toothpaste",
        "category": "Toiletries",
        "isPacked": false
    ],
    [
        "name": "Shampoo-Conditioner",
        "category": "Toiletries",
        "isPacked": false
    ],
    [
        "name": "Razor",
        "category": "Toiletries",
        "isPacked": false
    ],
    [
        "name": "Cotton buds",
        "category": "Toiletries",
        "isPacked": false
    ],
    [
        "name": "T-shirt",
        "category": "Clothes",
        "isPacked": false
    ],
    [
        "name": "Dresses",
        "category": "Clothes",
        "isPacked": false
    ],
    [
        "name": "Trainers",
        "category": "Clothes",
        "isPacked": false
    ],
    [
        "name": "Flip flops",
        "category": "Clothes",
        "isPacked": false
    ],
    [
        "name": "Headwear",
        "category": "Clothes",
        "isPacked": false
    ],
    [
        "name": "Swimming stuffs",
        "category": "Clothes",
        "isPacked": false
    ],
    [
        "name": "Light rain coat",
        "category": "Clothes",
        "isPacked": false
    ],
    [
        "name": "Trousers",
        "category": "Clothes",
        "isPacked": false
    ],
    [
        "name": "Underwear",
        "category": "Clothes",
        "isPacked": false
    ],
    [
        "name": "Socks",
        "category": "Clothes",
        "isPacked": false
    ],
    [
        "name": "Camera-Charger",
        "category": "Electronics",
        "isPacked": false
    ],
    [
        "name": "Phone-Phone Charger",
        "category": "Electronics",
        "isPacked": false
    ],
    [
        "name": "Power bank",
        "category": "Electronics",
        "isPacked": false
    ],
    [
        "name": "Ebook",
        "category": "Electronics",
        "isPacked": false
    ],
    [
        "name": "Sun-glasses",
        "category": "Carry-on",
        "isPacked": false
    ],
]
