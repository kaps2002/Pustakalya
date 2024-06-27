//
//  AllGenreView.swift
//  Pustakalya
//
//  Created by Roro on 27/06/24.
//

import SwiftUI

struct AllGenreView: View {
    var booksGenreList: [String]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.orange.opacity(0.5)
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select your Genre")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                    ScrollView(showsIndicators: false) {
                        ForEach(booksGenreList, id: \.self) { bookgenre in
                            NavigationLink {
                                
                            } label: {
                                ZStack {
                                    Image(bookgenre)
                                        .resizable()
                                        .opacity(0.9)
                                        .frame(height: 175)
                                        .cornerRadius(10.0)
                                    Text(bookgenre)
                                        .foregroundStyle(.white)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    AllGenreView(booksGenreList: ["Science", "History"])
}