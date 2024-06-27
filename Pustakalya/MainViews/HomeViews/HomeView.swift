//
//  HomeView.swift
//  Pustakalya
//
//  Created by Roro on 17/06/24.
//

import SwiftUI

struct HomeView: View {
    @State private var homeViewModel = HomeViewModel()
    @State private var commonViewModel = CommonViewModel()
    
    @State private var search = ""
    var body: some View {
        NavigationView {
            ZStack {
                Color.orange.opacity(0.15)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    HStack {
                        Text("Welcome \(homeViewModel.userData?.data.name.capitalized ?? "-o-") 👋")
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
                                .keyboardType(.default)
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
                    
                    GenreView(subTitle: "Explore All Genres", booksGenreList: homeViewModel.booksGenreList)
                    GenreView(subTitle: "Science 🚀", booksGenreList: homeViewModel.booksGenreList)
                    GenreView(subTitle: "Psychology 🧠", booksGenreList: homeViewModel.booksGenreList)
                }
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
//            .searchable(text: $homeViewModel.searchTerm, prompt: "Search")
            .navigationBarBackButtonHidden(true)
            .fontDesign(.rounded)
            .task {
                commonViewModel.checkInternet() { res in
                    if res {
                        homeViewModel.getUser()
                        homeViewModel.fetchBooks()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
