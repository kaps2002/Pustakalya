//
//  SelectedBookView.swift
//  Pustakalya
//
//  Created by Roro on 02/07/24.
//

import SwiftUI

struct SelectedBookView: View {
    var books: Book
    var body: some View {
        Text(books.title)
    }
}

#Preview {
    SelectedBookView(books: BooksData.sample.data[0].books[0])
}
