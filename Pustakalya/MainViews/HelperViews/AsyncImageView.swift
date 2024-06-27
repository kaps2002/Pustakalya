//
//  AsyncImageView.swift
//  Pustakalya
//
//  Created by Roro on 27/06/24.
//

import SwiftUI

struct AsyncImageView: View {
    var bookImg: String
    var body: some View {
        if let url = URL(string: bookImg) {
            AsyncImage(url: url) { image in
                image
            } placeholder: {
                ProgressView()
            }
        }
    }
}

#Preview {
    AsyncImageView(bookImg: "")
}
