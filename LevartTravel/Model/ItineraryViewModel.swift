//
//  ItineraryViewModel.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 21/12/2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class ItineraryViewModel: ObservableObject {
    @Published var itineraryPlans = [Itinerary]()
    
    // Sample Itinerary
    @Published var storedItineraries: [Itinerary] = [
        Itinerary(itineraryTitle: "Flight3", itineraryDescription: "AMS to HAN", itineraryDate: .init(timeIntervalSince1970: 1671703850)),
        Itinerary(itineraryTitle: "Flight", itineraryDescription: "AMS to HAN", itineraryDate: .init(timeIntervalSince1970: 1671718528)),
        Itinerary(itineraryTitle: "Flight2", itineraryDescription: "AMS to HAN", itineraryDate: .init(timeIntervalSince1970: 1671728121)),
        Itinerary(itineraryTitle: "Hotel", itineraryDescription: "Sheraton Hanoi", itineraryDate: .init(timeIntervalSince1970: 1671752968)),
        Itinerary(itineraryTitle: "Visit Hoan Kiem Lake", itineraryDescription: "Also known as Sword Lake or Tả Vọng Lake", itineraryDate: .init(timeIntervalSince1970: 1671786019)),
        Itinerary(itineraryTitle: "Visit Hanoi Old quarter", itineraryDescription: "Hoan Kiem District", itineraryDate: .init(timeIntervalSince1970: 1671784219)),
    ]
    
    var db = Firestore.firestore()
    
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
                .sorted { plan1, plan2 in
                    return plan1.itineraryDate < plan2.itineraryDate
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
    
    //MARK: Load Data
//    func fetchData() {
//            guard let userID = Auth.auth().currentUser?.uid else { return }
//            print(userID)
//
//            let itineraryPlanRef = db.collection("users").document(userID).collection("itinerary")
//
//        itineraryPlanRef.addSnapshotListener() {(querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                    }
//                }
//
//            itineraryPlanRef.addSnapshotListener { (querySnapshot, error) in
//                    guard let documents = querySnapshot?.documents else {
//                        print("No documents")
//                        return
//                    }
//
//                    self.itineraryPlans = documents.map { queryDocumentSnapshot -> Itinerary in
//                        let data = queryDocumentSnapshot.data()
//                        print(data)
//    //                  let id = data["documentId"] as String ?? ""
//                        let itineraryTitle = data["itineraryTitle"] as? String ?? ""
//                        let itineraryDescription = data["itineraryDescription"] as? String ?? ""
//                        let itineraryDate = data["itineraryDate"]
//
//                        print(Itinerary(id: .init(), itineraryTitle: itineraryTitle, itineraryDescription: itineraryDescription, itineraryDate: itineraryDate!))
//                        return Itinerary(id: .init(), itineraryTitle: itineraryTitle, itineraryDescription: itineraryDescription, itineraryDate: itineraryDate!)
//                    }
//                }
//            }
//        }
    
//    func loadData() {
//        guard let userID = Auth.auth().currentUser?.uid else { return }
//        print(userID)
//
//        let itineraryPlanRef = db.collection("users").document(userID).collection("packingList")
//
//        itineraryPlanRef.addSnapshotListener { (querySnapshot, error) in
//          if let querySnapshot = querySnapshot {
//            self.itineraryPlans = querySnapshot.documents.compactMap { document -> Itinerary? in
//              try? document.data(as: Itinerary.self)
//            }
//          }
//        }
//    }
    
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
    
    // MARK: Checking if the currenthour is task Hour
    func isCurrentHour (date: Date)->Bool{
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
}
