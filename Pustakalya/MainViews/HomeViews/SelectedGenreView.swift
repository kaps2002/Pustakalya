import SwiftUI

struct SelectedGenreView: View {
    var selectedGenre: Genre
    
    var body: some View {
        ZStack {
            Color.orange.opacity(0.15)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text(selectedGenre.genre)
                    .font(.largeTitle)
                    
                ScrollView {
                    ForEach(selectedGenre.books, id: \.id) { books in
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                AsyncImageView(bookImg: books.thumbnail)
                                Spacer()
                                VStack(alignment: .leading, spacing: 15) {
                                    Spacer()
                                    Text(books.title + " by " + books.author)
                                        .font(.headline)
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text(books.subtitle)
                                        Text("Genre: \(books.genreType)")
                                        Text("Price: ₹\(books.price)")
                                            .foregroundStyle(.secondary)
                                        Text("Rating: \(books.rating) ⭐️")
                                            .foregroundStyle(.secondary)
                                    }
                                    .font(.subheadline)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .fontDesign(.rounded)
    }
}

#Preview {
    SelectedGenreView(selectedGenre: BooksData.sample.data[0])
}
