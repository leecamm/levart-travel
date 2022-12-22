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
                case .signedIn:
                TabView {
                    Home()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    PackingListView()
                        .tabItem {
                            Label("Packing List", systemImage: "checklist")
                        }
                    ItineraryView()
                        .tabItem {
                            Label("Itinerary", systemImage: "mappin")
                        }
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.square")
                        }
                }.accentColor(.black)
                    .onAppear() {
                                UITabBar.appearance().unselectedItemTintColor = .gray
                            }

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
