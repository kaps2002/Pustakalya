import SwiftUI

struct AllBooksView: View {
    
    @State private var homeViewModel = HomeViewModel()
    var booksData: BooksData
    var btnGenre: [Btn]
    @State private var filters: Set<String> = []
    
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
                        filters = []
                    }, label: {
                        Text("All Categories")
                            .padding([.top, .bottom], 10)
                            .padding(.horizontal, 20)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                            .background(.blue)
                            .clipShape(Capsule())
                    })
                    ForEach(btnGenre, id: \.btnTitle) { btnGenre in
                        Button(action: {
                            filters.insert(btnGenre.btnTitle)
                        }, label: {
                            Text(btnGenre.btnTitle)
                                .padding([.top, .bottom], 10)
                                .padding(.horizontal, 20)
                                .foregroundStyle(.white)
                                .fontWeight(.medium)
                                .background(.blue)
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
}

#Preview {
    AllBooksView(booksData: BooksData.sample, btnGenre: [Btn(btnTitle: "fiction", isClicked: false)])
}
