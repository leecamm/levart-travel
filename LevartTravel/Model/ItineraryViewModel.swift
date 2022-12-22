//
//  ItineraryViewModel.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 21/12/2022.
//

import Foundation
import SwiftUI

class ItineraryViewModel: ObservableObject {
    // Sample Itinerary
    @Published var storedItineraries: [Itinerary] = [
        Itinerary(itineraryTitle: "Flight", itineraryDescription: "AMS to HAN", itineraryDate: .init(timeIntervalSince1970: 1671708628)),
        Itinerary(itineraryTitle: "Flight2", itineraryDescription: "AMS to HAN", itineraryDate: .init(timeIntervalSince1970: 1671730228)),
        Itinerary(itineraryTitle: "Hotel", itineraryDescription: "Sheraton Hanoi", itineraryDate: .init(timeIntervalSince1970: 1671752968)),
        Itinerary(itineraryTitle: "Park", itineraryDescription: "West Lake", itineraryDate: .init(timeIntervalSince1970: 1671580168)),
    ]
    
    //MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    
    //MARK: Current day
    @Published var currentDay: Date = Date()
    
    //MARK: Filtering Today ItineraryPlan
    @Published var filteredPlans: [Itinerary]?
    
    init() {
        fetchCurrentWeek()
        filterTodayPlans()
    }
    
    //MARK: Filter today plans
    func filterTodayPlans() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            let filtered = self.storedItineraries.filter {
                return calendar.isDate($0.itineraryDate, inSameDayAs: self.currentDay)
            }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredPlans = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    //MARK: Extracting Date
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    //MARK: Checking if current Date is today
    func isToday(date: Date)->Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
