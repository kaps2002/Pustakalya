import SwiftUI

struct AllBooksView: View {
    
    @State private var homeViewModel = HomeViewModel()
    var booksData: BooksData
    @Binding var btnGenreList: [Btn]
    @State private var filters: Set<String> = []
    @State private var isClick: Bool = true
//    @State private var btngenre: Btn?
//
    var filteredBooks: [Genre] {
        guard !filters.isEmpty else {
            return booksData.data
        }
        return homeViewModel.filteredBooks(filters: filters, booksData: booksData)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("All Books 📚")
                .font(.system(size: 36))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    Button(action: {
                        isClick = true
                        removeFilters(btnGenreList)
                        filters = []
                    }, label: {
                        HStack {
                            Image(systemName: "square.grid.2x2")
                            Text("All Categories")
                        }
                        .padding([.top, .bottom], 10)
                        .padding(.horizontal, 20)
                        .foregroundStyle(isClick ? .white : .blue)
                        .fontWeight(.medium)
                        .background(isClick ? .blue : .white)
                        .clipShape(Capsule())
                    })
                    ForEach($btnGenreList, id: \.btnTitle) { $btnGenre in
                        Button(action: {
                            isClick = false
                            btnGenre.isClicked = true
                            filters.insert(btnGenre.btnTitle)
                        }, label: {
                            HStack {
                                Text(btnGenre.btnTitle)
                                if btnGenre.isClicked {
                                    Button(action: {
                                        btnGenre.isClicked = false
                                        filters.remove(btnGenre.btnTitle)
                                        if filters.isEmpty {
                                            isClick = true
                                        }
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .imageScale(.small)
                                            .accentColor(.blue)
                                    })
                                    
                                }
                            }
                            .padding([.top, .bottom], 10)
                            .padding(.horizontal, 15)
                            .foregroundStyle(btnGenre.isClicked ? .white : .blue)
                            .fontWeight(.medium)
                            .background(btnGenre.isClicked ? .blue : .white)
                            .clipShape(Capsule())
                        })
                    }
                }
            }
            .padding(.bottom, 12)
            
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)], spacing: 5) {
                ForEach(filteredBooks, id: \.genre) { genres in
                    ForEach(genres.books, id: \.id) { books in
                        NavigationLink {
                            
                        } label: {
                            VStack(alignment: .center, spacing: 10) {
                                AsyncImageView(bookImg: books.thumbnail)
                                Text(books.title)
                                    .foregroundStyle(.black)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                            }
                            .frame(height: 225)
                            .padding(.bottom, 15)
                        }
                    }
                }
            }
        }
        .fontDesign(.rounded)
        .padding(.top, 20)
    }
    
    func removeFilters(_ btnGenreList: [Btn]) {
        for index in btnGenreList.indices {
            self.btnGenreList[index].isClicked = false
        }
    }
}

#Preview {
    AllBooksView(booksData: BooksData.sample, btnGenreList: .constant([Btn(btnTitle: "Fiction", isClicked: false)]))
}
