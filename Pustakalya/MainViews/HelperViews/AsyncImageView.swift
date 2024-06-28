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
        if !bookImg.isEmpty {
            let bookImg = url(bookImg: bookImg)
            if let url = URL(string: bookImg) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .frame(width: 140, height: 200)
                        .cornerRadius(10.0)
                } placeholder: {
                    EmptyView()
                }
            }
        } else {
            Image("na")
                .resizable()
                .frame(width: 140, height: 200)
                .cornerRadius(10.0)
        }
        
    }
    
    func url(bookImg: String) -> String {
        var comps = URLComponents(string: bookImg)!
        comps.scheme = "https"
        let https = comps.string!
        return https
    }
}

#Preview {
    AsyncImageView(bookImg: "")
}
