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
                        Text("More")
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                    }
                    .foregroundColor(.blue)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(genre.books.dropLast(5), id: \.id) { bookgenre in
                        NavigationLink {
                            
                        } label: {
                            VStack(alignment: .center, spacing: 10) {
                                AsyncImageView(bookImg: bookgenre.thumbnail)
                                Text(bookgenre.title)
                                    .foregroundStyle(.black)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                            }
                            .frame(width: 150, height: 225)
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
    CategoryView(genre: Genre(genre: "Fiction", books: [Book(id: "1", eTag: "abcd", title: "hello", subtitle: "world", genreType: "Fiction", author: "karan", description: "", thumbnail: "http://books.google.com/books/content?id=dFw6DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", rating: "4.5", price: 10), Book(id: "1", eTag: "abcd", title: "hello", subtitle: "world", genreType: "Fiction", author: "karan", description: "", thumbnail: "http://books.google.com/books/content?id=dFw6DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", rating: "4.5", price: 10)]))
}
