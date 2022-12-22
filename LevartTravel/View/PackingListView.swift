//
//  PackingListView.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 07/12/2022.
//

import SwiftUI
import WrappingHStack

struct PackingListView: View {
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 34)!]
        
    }
    
    @ObservedObject var packingListVM = PackingListViewModel() // (7)
    @State var presentAddNewItem = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color("BG").ignoresSafeArea()
                ScrollView{
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 10) {
                            
                            LazyVGrid(columns: columns, spacing: 18) {
                                
                                ForEach(packingListVM.packingItemCellViewModels) { packingItemCellVM in
                                    PackingItemCell(packingItemCellVM: packingItemCellVM)
                                }
                                .onDelete { indexSet in
                                    self.packingListVM.removePackingItems(atOffsets: indexSet)
                                }
                                
                                if presentAddNewItem {
                                    PackingItemCell(packingItemCellVM: PackingItemCellViewModel.newPackingItem()) { result in
                                        if case .success(let packingItem) = result {
                                            self.packingListVM.addPackingItem(packingItem: packingItem)
                                        }
                                        self.presentAddNewItem.toggle()
                                        
                                    }
                                }
                                
                            }.padding(.horizontal)
                                .font(.custom("Poppins-Regular", size: 14))
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, 20)
                        .padding(.leading, 20)
                        .padding(.trailing, 10)
                        Spacer()
                        Button(action: { self.presentAddNewItem.toggle() }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("New Item")
                                    .font(.custom("Poppins-Regular", size: 18))
                            }
                        }
                        .padding()
                        .accentColor(Color(UIColor.systemRed))
                    }
                    .onAppear() {
                        
                    }
                    .navigationBarTitle("Packing List")
                    .foregroundColor(.black)
                }
            }
        }
    }
    
    struct PackingListView_Previews: PreviewProvider {
        static var previews: some View {
            PackingListView()
        }
    }
    
    struct PackingItemCell: View {
        @ObservedObject var packingItemCellVM: PackingItemCellViewModel
        var onCommit: (Result<PackingItem, InputError>) -> Void = { _ in }
        
        var body: some View {
            HStack {
                Image(systemName: packingItemCellVM.completionStateIconName) // (2)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        self.packingItemCellVM.packingItem.isPacked.toggle()
                    }
                    .foregroundColor(.black)
                TextField("Enter item title", text: $packingItemCellVM.packingItem.name, // (3)
                          onCommit: { //(4)
                    if !self.packingItemCellVM.packingItem.name.isEmpty {
                        self.onCommit(.success(self.packingItemCellVM.packingItem))
                    }
                    else {
                        self.onCommit(.failure(.empty))
                    }
                }).id(packingItemCellVM.id)
            }
        }
    }
    enum InputError: Error {
        case empty
    }
}

