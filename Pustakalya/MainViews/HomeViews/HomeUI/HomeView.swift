import SwiftUI

struct HomeView: View {
    @State private var homeViewModel = HomeViewModel()
    @State private var commonViewModel = CommonViewModel()
    @State private var search = ""
    @FocusState private var isSearching: Bool
    @State private var color: Color?
    var body: some View {
        NavigationView {
            ZStack {
                Color.orange.opacity(0.15)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        if search.isEmpty {
                            GenreView(subTitle: "Explore All Genres", booksGenreList: homeViewModel.booksGenreList)
                            
                            VStack {
                                ForEach(homeViewModel.booksData?.data.dropFirst(7) ?? [], id: \.genre) { genre in
                                    CategoryView(genre: genre)
                                }
                            }
                            
                            Divider()
                                .padding(.top, 10)
                            
                            AllBooksView(booksData: homeViewModel.booksData ?? BooksData.sample, btnGenreList: $homeViewModel.btnGenreList)
                        }
                    }
                    .padding(.horizontal, 15)
                    .safeAreaInset(edge: .top, content: {
                        GeometryReader { proxy in
                            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
                            let progress = isSearching ? 1 : max(min(-minY / 70, 1), 0)
                            VStack(spacing: 25) {
                                HStack {
                                    Text("Welcome \(homeViewModel.userData?.data.name.capitalized ?? "-o-") 👋")
                                        .font(.system(.title))
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                    Spacer()
                                    NavigationLink {
                                        ProfileView(color: color ?? .blue)
                                    } label: {
                                        ProfileImgView(name: homeViewModel.userData?.data.name.capitalized ?? "hello", width: 40, height: 40, fontSize: 24, color: color ?? .blue)
                                    }
                                    .padding(.horizontal)
                                }
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.black.opacity(0.8))
                                    TextField("Search Books", text: $search)
                                        .keyboardType(.default)
                                        .focused($isSearching)
                                    
                                    if isSearching {
                                        Button {
                                            isSearching = false
                                        } label: {
                                            Text("Cancel")
                                                .foregroundStyle(.blue)
                                        }
                                        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))

                                    }
                                }
                                .foregroundColor(.black)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15 - ( progress * 15))
                                .frame(height: 40)
                                .clipShape(.capsule)
                                .background {
                                    RoundedRectangle(cornerRadius: 25 - (progress * 25))
                                        .fill(.background)
                                        .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 5)
                                        .padding(.top, -progress * 250)
                                        .padding(.bottom, -progress * 20)
                                        .padding(.horizontal, -progress * 15)
                                }
                            }
                            .safeAreaPadding(.horizontal, 15)
                            .offset(y: minY < 0 || isSearching ? -minY: 0)
                            .offset(y: -progress * 50)
                        }
                        .frame(height: 100)
                        .padding(.bottom, isSearching ? -65 : 0)
                    })
                    .animation(.easeOut(duration: 0.3), value: isSearching)
                }
                .contentMargins(.top, 190, for: .scrollIndicators)
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
            }
            
        }
        .redacted(reason: homeViewModel.booksData == nil ? .placeholder : [])
        .navigationBarBackButtonHidden(true)
        .fontDesign(.rounded)
        .task {
            commonViewModel.checkInternet() { res in
                if res {
                    homeViewModel.getUser()
                    homeViewModel.fetchBooks()
                    self.color = Color.random()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
