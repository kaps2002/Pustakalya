//
//  CateogoryView.swift
//  Pustakalya
//
//  Created by Roro on 18/06/24.
//

import SwiftUI

struct GenreView: View {
    var subTitle: String
    var booksGenreList: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(subTitle)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                NavigationLink {
                    AllGenreView(booksGenreList: booksGenreList)
                } label: {
                    HStack {
                        Text("See All")
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                    }
                    .foregroundColor(.blue)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(booksGenreList.dropLast(5), id: \.self) { bookgenre in
                        Button(action: {}, label: {
                            ZStack {
                                Image(bookgenre)
                                    .resizable()
                                    .opacity(0.9)
                                    .frame(width: 160, height: 80)
                                    .cornerRadius(10.0)
                                Text(bookgenre)
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                        })
                    }
                }
                .padding(.top, 10)
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            
        }
        .padding(.top, 10)
    }
}

#Preview {
    GenreView(subTitle: "Explore", booksGenreList: ["Science"])
}
