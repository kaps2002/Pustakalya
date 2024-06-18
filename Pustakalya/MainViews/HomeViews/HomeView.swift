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
                
                CategoryView(subTitle: "Explore All Genres")
                
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
        .navigationBarBackButtonHidden(true)
        .fontDesign(.rounded)
        .task {
            commonViewModel.checkInternet() { res in
                if res {
                    //ommonViewModel.fetchBooks()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
