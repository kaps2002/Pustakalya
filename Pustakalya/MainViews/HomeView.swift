//
//  HomeView.swift
//  Pustakalya
//
//  Created by Roro on 17/06/24.
//

import SwiftUI

struct HomeView: View {
    var signInModelData: SignInModelData?
    @State private var commonViewModel = CommonViewModel()
    @State private var search = ""
    var body: some View {
        ZStack {
            Color.orange.opacity(0.15)
                .ignoresSafeArea()
            ScrollView {
                HStack {
                    Text("Welcome \(signInModelData?.data.name ?? "Karan") 👋")
                        .font(.system(.title))
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                    Spacer()
                }
                
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black.opacity(0.8))
                        TextField("Search Books", text: $search)
                    }
                    .padding(8)
                    .background(.gray.opacity(0.2))
                    .clipShape(Capsule())
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Search")
                            .foregroundStyle(.blue)
                            .fontWeight(.semibold)
                    })
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Explore All Genres")
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
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
        .fontDesign(.rounded)
        .task {
            commonViewModel.checkInternet() { res in
                if res {
//                    commonViewModel.fetchBooks()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
