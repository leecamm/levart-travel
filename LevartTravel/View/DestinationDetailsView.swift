//
//  DestinationDetailsView.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 15/12/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct DestinationDetailsView: View {
    @ObservedObject var viewModel = DestinationViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DestinationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationDetailsView()
    }
}
