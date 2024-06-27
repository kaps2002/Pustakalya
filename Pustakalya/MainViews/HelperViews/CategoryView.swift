import SwiftUI

struct CategoryView: View {
    var genre: Genre
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(genre.genre)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                NavigationLink {
                    
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
                    ForEach(genre.books, id: \.id) { bookgenre in
                        NavigationLink {
                            
                        } label: {
                            VStack {
                                AsyncImageView(bookImg: bookgenre.thumbnail)
                                    .cornerRadius(10.0)
                                Text(bookgenre.title)
                                    .foregroundStyle(.black)
                                    .font(.caption)
                            }
                        }
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
    CategoryView(genre: Genre(genre: "Fiction", books: [Book(id: "1", eTag: "abcd", title: "hello", subtitle: "world", genreType: "Fiction", author: "karan", description: "", thumbnail: "https://books.google.com/books/content?id=dFw6DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", rating: "4.5", price: 10)]))
}
