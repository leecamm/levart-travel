//
//  IntroView.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 16/11/2022.
//

import SwiftUI


struct IntroView: View {
    @AppStorage("welcomeScreenShown") // User Defaults
    var welcomeScreenShown: Bool = false
    
    //MARK: Animation Properties
    @State var showWalkThroughScreen: Bool = false
    @State var currentIndex: Int = 0
    @State var showHomeView: Bool = false
    
    var body: some View {
        ZStack {
            if showHomeView {
//                Home()
                LoginView()
                    .transition(.move(edge: .trailing))
            } else {
                ZStack {
                    Color("BG")
                        .ignoresSafeArea()
                    
                    IntroScreen()
                    WalkThroughScreens()
                    NavBar()
                }
                .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreen)
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.35), value: showHomeView)
        .onAppear(perform: {
            UserDefaults.standard.welcomeScreenShown = true
        })
    }
    
    //MARK: WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens() -> some View {
        let isLast = currentIndex == intros.count
        
        GeometryReader {
            let size = $0.size
            ZStack {
                //MARK: Walk Throught Screens
                ForEach(intros.indices, id: \.self) {index in
                    ScreenView(size: size, index: index)
                }
                WelcomeView(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //MARK: Next Button
            .overlay(alignment: .bottom) {
                //MARK: Covert Next button to sign up
                ZStack {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    HStack {
                        Text("Let's Get Started")
                            .font(.custom("Poppins-Bold", size: 15))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
                            .fill(Color(.black))
                    }
                    .onTapGesture {
                        if currentIndex == intros.count {
                            // signup action
                            showHomeView = true
                        } else {
                            // MARK: Updating index
                            currentIndex += 1
                        }
                    }
                    .offset(y: isLast ? -40 : -90)
                //Animation
                    .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            }
            .overlay(alignment: .bottom, content: {
                //MARK: Bottom, Sign In button
                
            })
            .offset(y: showWalkThroughScreen ? 0 : size.height)
        }
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize, index: Int) -> some View {
        let intro = intros[index]
        
        VStack(spacing: 10) {
            Text(intro.title)
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
                //MARK: Applying offset for each screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
            // MARK: Adding animation
            //MARK: Adding Delay to Elements based on index
            
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(dummyText)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .padding(.bottom, 60)
                .offset(x: -size.width * CGFloat(currentIndex - index))
            // MARK: Adding animation
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
        }
    }
    
    //MARK: Welcome Screen
    @ViewBuilder
    func WelcomeView(size: CGSize, index: Int) -> some View {
        VStack(spacing: 10) {
            Image("welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .padding(.bottom, 60)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            Text("Welcome")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
                //MARK: Applying offset for each screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text("Let's plan your future trip!")
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
        }
        .offset(y: -30)
    }
    
    //MARK: Nav Bar
    @ViewBuilder
    func NavBar() -> some View {
        let isLast = currentIndex == intros.count
        HStack {
            Button {
                // If Greater than zero then eliminating index
                if currentIndex > 0 {
                    currentIndex -= 1
                } else {
                    showWalkThroughScreen.toggle()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.black))
            }
            Spacer()
            
            Button("Skip") {
                currentIndex = intros.count
            }
            .font(.custom("Poppins-Regular", size: 14))
            .foregroundColor(Color(.black))
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
        }
        .padding(.horizontal, 25)
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: showWalkThroughScreen ? 0 : -120)
    }
    
    @ViewBuilder
    func IntroScreen() -> some View {
        GeometryReader{
            let size = $0.size
            
            VStack(spacing: 10) {
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height / 2)
                
                Text("Discover Vietnam")
                    .font(Font.custom("Poppins-ExtraBold", size: 28))
                    .foregroundColor(Color(.black))
                    .padding(.top, 50)
                
                Text(dummyText)
                    .font(.custom("Poppins-Medium", size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.black))
                    .padding(.horizontal, 30)
                
                Text("Let's Begin")
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 14)
                    .foregroundColor(.white)
                    .background {
                        Capsule()
                            .foregroundColor(Color(.black))
                    }
                    .onTapGesture {
                        showWalkThroughScreen.toggle()
                    }
                    .padding(.top, 90)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            //MARK: Moving Up when clicked
            .offset(y: showWalkThroughScreen ? -size.height : 0)
        }
        .ignoresSafeArea()
        .padding(2)
    }
    
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

