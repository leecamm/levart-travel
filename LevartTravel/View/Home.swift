//
//  Home.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 18/11/2022.
//

import SwiftUI
import GoogleSignIn

struct Home: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    private let user = GIDSignIn.sharedInstance.currentUser
    
    var body: some View {
        NavigationStack {
            Text("")
                .navigationTitle("Home")
            VStack{
                HStack{
                    NavigationLink(destination: ProfileView()) {
                        Text("My Profile")
                    }
                }
            }
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(AuthenticationViewModel())
    }
}
