//
//  CateogoryView.swift
//  Pustakalya
//
//  Created by Roro on 18/06/24.
//

import SwiftUI

struct CategoryView: View {
    var subTitle: String
    
    @State private var commonViewModel = CommonViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(subTitle)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {}, label: {
                    HStack {
                        Text("See All")
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                    }
                })
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<commonViewModel.booksGenreList.count) { index in
                        Button(action: {}, label: {
                            ZStack {
                                Image(commonViewModel.booksGenreList[index])
                                    .resizable()
                                    .opacity(0.9)
                                    .frame(width: 160, height: 80)
                                    .cornerRadius(10.0)
                                Text(commonViewModel.booksGenreList[index])
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
    CategoryView(subTitle: "Explore")
}
