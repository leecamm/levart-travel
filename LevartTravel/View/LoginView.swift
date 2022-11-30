//
//  LoginView.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 30/11/2022.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Image("Levart Travel")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .padding(.top, 100)
                    .aspectRatio(contentMode: .fit)
                
                Text("Welcome to the new solution for traveling")
                    .fontWeight(.black)
                    .foregroundColor(Color(.darkGray))
                    .font(.custom("Poppins-Bold", size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 50)
                
                Spacer()
                
                GoogleSignInButton()
                    .padding(.horizontal, 50)
                    .padding(.vertical, 50)
                    .onTapGesture {
                        viewModel.signIn()
                    }
                
                
            }
           
         
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationViewModel())
    }
}
