//
//  BookView.swift
//  LevartTravel
//
//  Created by Duc Hieu Le on 01/12/2022.
//

import SwiftUI

struct BooksListView: View {
  @ObservedObject var viewModel = BooksViewModel()
  @State private var showSecondView = false
    
    
    
    var writerForSecondView = Book(
        id: .init(),
            title: "",
            author: "Monaco",
            numberOfPages: 100
        )
    
  var body: some View {
    NavigationView {
        VStack(spacing: 20) {
            ForEach(viewModel.books) { book in
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                        Text("\(book.numberOfPages) pages")
                            .font(.subheadline)
                        Divider()
                    }
                    .onTapGesture {
                    self.showSecondView.toggle()
                }
            }
        }
      .navigationBarTitle("Books")
      .onAppear() {
        self.viewModel.fetchData()
      }
    }
  }
}

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView()
    }
}

