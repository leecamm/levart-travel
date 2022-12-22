//
//  ItineraryView.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 21/12/2022.
//

import SwiftUI

struct ItineraryView: View {
    @StateObject var itineraryModel: ItineraryViewModel = ItineraryViewModel()
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("BG").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                //MARK: Lazy Stack With Pinned Header
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                    Section {
                        
                        //MARK: Current Week View
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(itineraryModel.currentWeek, id: \.self) { day in
                                    
                                    VStack(spacing: 10) {
                                        Text(itineraryModel.extractDate(date: day, format: "dd"))
                                            .font(.custom("Poppins-SemiBold", size: 14))
                                        
                                        //EEE will return day as MON, TUE....
                                        Text(itineraryModel.extractDate(date: day, format: "EEE"))
                                            .font(.custom("Poppins-SemiBold", size: 14))
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 8, height: 8)
                                            .opacity(itineraryModel.isToday(date: day) ? 1 : 0)
                                    }
                                    .foregroundStyle(itineraryModel.isToday(date: day) ? .primary : .tertiary)
                                    .foregroundColor(itineraryModel.isToday(date: day) ? .white : .black)
                                    //MARK: Capsule Shape
                                    .frame(width: 50, height: 90)
                                    .background(
                                        ZStack{
                                            //MARK: Matched Geometry Effect
                                            if itineraryModel.isToday(date: day) {
                                                Capsule()
                                                    .fill(.black)
                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                        }
                                    )
                                    .contentShape(Capsule())
                                    .onTapGesture {
                                        //Updating Current day
                                        withAnimation {
                                            itineraryModel.currentDay = day
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        ItineraryPlansView()
                        
                    } header: {
                        HeaderView()
                    }
                }
            }
            .ignoresSafeArea(.container, edges: .top)
        }
        
    }
    
    //MARK: Itinerary Task View
    func ItineraryPlansView() -> some View {
        LazyVStack(spacing: 18) {
            if let plans = itineraryModel.filteredPlans {
                if plans.isEmpty{
                    Text("No plans today")
                        .font(.custom("Poppins-Regular", size: 16))
                        .offset(y:100)
                }
                else {
                    ForEach(plans) {plan in
                        PlanCardView(plan: plan)
                    }
                }
            }
            else {
                //MARK: Progress View
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        //MARK: Updating plan
        .onChange(of: itineraryModel.currentDay) { newValue in
            itineraryModel.filterTodayPlans()
        }
        
    }
    //MARK: Plan Card View
    func PlanCardView(plan: Itinerary)-> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack(spacing: 10) {
                Circle()
                    .fill(.orange)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.orange, lineWidth: 1)
                            .padding(-3)
                    )
                Rectangle()
                    .fill(.orange)
                    .frame(width: 3)
            }
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(plan.itineraryTitle)
                            .font(.custom("Poppins-SemiBold", size: 18))
                        Text(plan.itineraryDescription)
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundStyle(.secondary)
                    }
                    .hLeading()
                    
                    Text(plan.itineraryDate.formatted(date: .omitted, time: .shortened))
                        .font(.custom("Poppins-Regular", size: 14))
                }
            }
            .foregroundColor(.black)
            .padding()
            .hLeading()
            .background(
                Color(.white)
                    .cornerRadius(25)
                    .shadow(radius: 5, x: 5, y: 5)
            )
            
        }
        .hLeading()
    }
    
    //MARK: Header
    func HeaderView()-> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Itinerary")
                    .font(.custom("Poppins-Bold", size: 30))
            }
            .hLeading()
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(Color("BG"))
    }
}

struct ItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        ItineraryView()
    }
}

//MARK: UI Design Helper functions
extension View {
    func hLeading()-> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    func hTrailing()-> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCenter()-> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    //MARK: Safe Area
    func getSafeArea()-> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}
