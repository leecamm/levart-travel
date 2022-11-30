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
    
    @State private var searchText = ""
    
    private let user = GIDSignIn.sharedInstance.currentUser
    @State private var goToProfile = false
    @State private var goToSearch = false
    
    var body: some View {
        
        
            NavigationStack {
                ZStack (alignment: .top) {
                    // Some more codes
                    Color("BG")
                        .ignoresSafeArea()
                    
                    //MARK: Title
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Discover")
                                .font(.custom("Poppins-Bold", size: 22))
                                .foregroundColor(.black)
                            Text("Vietnam")
                                .font(.custom("Poppins-ExtraBold", size: 36))
                                .foregroundColor(.black)
                        }
                        VStack (alignment: .leading){
                            Text("Popular")
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundColor(.black)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(0..<10) {
                                        Label("Item \($0)", systemImage: "star")
                                            .foregroundColor(.white)
                                            .font(.custom("Poppins-Semibold", size: 20))
                                            .frame(width: 200, height: 100)
                                            .background(.red)
                                            .cornerRadius(20)
                                        
                                    }
                                }
                            }
                        }
                        .padding(.top, 50)
                        VStack (alignment: .leading){
                            Text("Most Visited")
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundColor(.black)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(0..<10) {
                                        Label("Item \($0)", systemImage: "star")
                                            .foregroundColor(.white)
                                            .font(.custom("Poppins-Semibold", size: 20))
                                            .frame(width: 200, height: 100)
                                            .background(.red)
                                            .cornerRadius(20)
                                        
                                    }
                                }
                            }
                        }
                        .padding(.top, 50)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.top, 20)
                    .padding(.leading, 30)
                    .padding(.trailing, 10)
                    
                }
                .toolbar {
                    HStack{
                        Button(role: .destructive, action: { goToProfile = true })
                        {
                            NetworkImage(url: user?.profile?.imageURL(withDimension: 200))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40, alignment: .trailing)
                                .cornerRadius(100)
                        }
                        Button(role: .destructive, action: {
                            goToSearch = true
                        }) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Rectangle())
                                .cornerRadius(10)
                                .shadow(radius: 5, x: 2, y: 4)
                        }
                    }
                    .padding(.trailing, 10)
                    .frame(height: 40)
                }
                
                .navigationDestination(isPresented: $goToProfile, destination: {
                    ProfileView()
                })
                .navigationDestination(isPresented: $goToSearch, destination: {
                    SearchView()
                })
            }
        
    }
}




struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(AuthenticationViewModel())
    }
}
