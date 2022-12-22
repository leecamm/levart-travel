//
//  Home.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 18/11/2022.
//

import SwiftUI
import GoogleSignIn

struct Home: View {
    var body: some View {
        Homepage()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(AuthenticationViewModel())
    }
}

struct Homepage: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State private var searchText = ""
    
    private let user = GIDSignIn.sharedInstance.currentUser
    @State private var goToProfile = false
    @State private var goToSearch = false
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .top) {
                Color("BG")
                    .ignoresSafeArea()
                
                //MARK: Title
                ScrollView{
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Discover")
                                .font(.custom("Poppins-Bold", size: 22))
                                .foregroundColor(.black)
                            Text("Vietnam")
                                .font(.custom("Poppins-ExtraBold", size: 36))
                                .foregroundColor(.black)
                        }
                        PopularDestination()
                        MostVisited()
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.top, 20)
                    .padding(.leading, 30)
                    .padding(.trailing, 10)
                }
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
                .frame(height: 45)
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

struct PopularDestination: View {
    private let cardAndImageWidth: CGFloat = 170
    private let cardHeight: CGFloat = 174
    private let imageHeight: CGFloat = 116
    private let cornerRadius: CGFloat = 5
    
    @State private var goToDestination = false
    @ObservedObject var viewModel = DestinationViewModel()
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Popular")
                .font(.custom("Poppins-Bold", size: 18))
                .foregroundColor(.black)
            ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 20) {
                        ForEach(viewModel.destinations) {destination in
                            HStack{
                                AsyncImage(url: URL(string: destination.imgUrl)){ image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(20)
                                    .frame(width: 100, height: 60)
                                    .padding(.all, 10)
                            } placeholder: {
                                Text("Test")
                            }
                            VStack(alignment: .leading) {
                                Text(destination.name)
                                    .font(.custom("Poppins-Bold", size: 14))
                            }.padding(.trailing,15)
                        }
                            .background(.white)
                            .cornerRadius(20)
                    }
                }
                    .padding(.trailing, 10)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .onAppear() {
              self.viewModel.fetchData()
            }
        }
        .padding(.top, 30)
        .onTapGesture {
            print("Tabbed")
        }
    }
      
}

struct MostVisited: View {
    private let cardAndImageWidth: CGFloat = 170
    private let cardHeight: CGFloat = 174
    private let imageHeight: CGFloat = 116
    private let cornerRadius: CGFloat = 5
    var body: some View {
        VStack (alignment: .leading){
            Text("Most Visited")
                .font(.custom("Poppins-Bold", size: 18))
                .foregroundColor(.black)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<10) {index in
                                VStack(alignment: .leading, spacing: 10) {
                                    AsyncImage(url: URL(string: "https://touristjourney.com/wp-content/uploads/2020/11/Ho-Chi-Minh-City.jpg")){ image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: cardAndImageWidth, height: imageHeight)
                                            .clipped()
                                    } placeholder: {
                                        //put your placeholder here
                                        Text("Test")
                                    }
                                    //
                                    LazyVStack(alignment: .leading, spacing: 2) {
                                        Text("Item \(index)")
                                            .font(.custom("Avenir", size: 14))
                                            .fontWeight(.bold)
                                        Text("No Address")
                                            .font(.custom("Avenir", size: 12))
                                            .foregroundColor(SwiftUI.Color.gray)
                                    }
                                    .padding(.horizontal,12)
                                    .padding(.bottom,11)
                                    
                                }
                                .background(.white)
                                .cornerRadius(20)
                            }
                            .frame(width: cardAndImageWidth, height: cardHeight)
                            .cornerRadius(cornerRadius)
                        }
                    }
                    .onTapGesture {
                        print("Tabbed")
                    }
                }
            }
        }
        .padding(.top, 50)
    }
}

