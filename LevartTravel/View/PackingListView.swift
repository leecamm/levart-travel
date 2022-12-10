//
//  PackingListView.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 07/12/2022.
//

import SwiftUI

struct PackingListView: View {
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        }
    
    @ObservedObject var packingListVM = PackingListViewModel() // (7)
    @State var presentAddNewItem = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color("BG").ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Clothes")
                            .font(.custom("Poppins-Semibold", size: 18))
                        HStack(spacing: 20){
                            ForEach (packingListVM.packingItemCellViewModels) { packingItemCellVM in // (8)
                                PackingItemCell(packingItemCellVM: packingItemCellVM) // (1)
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
                        }
                        
                    }
                    
                    
                    .navigationTitle("Packing List")
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
        //    var body: some View {
        //        NavigationStack {
        //            ZStack(alignment: .top){
        //                Color("BG")
        //                    .ignoresSafeArea()
        //                VStack(alignment: .leading, spacing: 0) {
        //                    VStack(alignment: .leading, spacing: 10) {
        //                        ForEach(viewModel.packingLists) { item in
        //                            HStack(alignment: .top) {
        //                                Image(systemName: item.isPacked ? "checkmark.circle.fill": "circle")
        //                                    .onTapGesture {
        //
        //                                    }
        //                                Text(item.name)
        //                                    .font(.headline)
        //                                Text(item.category)
        //                                    .font(.subheadline)
        //                            }
        //                        }
        //                    }
        //                    .navigationTitle("Packing List")
        //                    .frame(maxWidth: .infinity, alignment: .topLeading)
        //                    .padding(.top, 20)
        //                    .padding(.leading, 20)
        //                    .padding(.trailing, 10)
        //                }
        //
        //
        //                .onAppear() {
        //                    self.viewModel.fetchData()
        //                }
        //            }
        //        }
        //    }
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
