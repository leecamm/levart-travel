//
//  ContentView.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 11/11/2022.
//

import SwiftUI

extension UserDefaults {
    var welcomeScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShown")
        }
    }
}

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
//        IntroView()
    
        if UserDefaults.standard.welcomeScreenShown {
//            Home()
            switch viewModel.state {
                case .signedIn: Home()
                case .signedOut: LoginView()
            }
        } else {
            IntroView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthenticationViewModel())
    }
}
