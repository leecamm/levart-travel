//
//  LevartTravelApp.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 11/11/2022.
//

import SwiftUI
import Firebase
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      if(FirebaseApp.app() == nil){
          FirebaseApp.configure()
      }
    return true
  }
}

extension LevartTravelApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}


@main
struct LevartTravelApp: App {
    
    @StateObject var viewModel = AuthenticationViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
       setupAuthentication()
     }
    
    var body: some Scene {
        WindowGroup {
//            SplashScreenView()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
