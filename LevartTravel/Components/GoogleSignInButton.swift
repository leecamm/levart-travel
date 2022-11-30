//
//  GoogleSignInButton.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 30/11/2022.
//

import Foundation
import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: UIViewRepresentable {
  @Environment(\.colorScheme) var colorScheme
  
  private var button = GIDSignInButton()

  func makeUIView(context: Context) -> GIDSignInButton {
    button.colorScheme = .light
    return button
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
      button.colorScheme = .light
  }
}
