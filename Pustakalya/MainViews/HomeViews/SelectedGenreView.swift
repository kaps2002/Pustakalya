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
                    .fontWeight(.bold)
                    
                ScrollView {
                    ForEach(selectedGenre.books, id: \.id) { books in
                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 25) {
                                AsyncImageView(bookImg: books.thumbnail)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Spacer()
                                    Text(books.title)
                                        .font(.headline)
                                    Text("by \(books.author)")
                                        .font(.subheadline)
                                    VStack(alignment: .leading, spacing: 10) {
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
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                Spacer()
                            }
                            .padding(.top, 10)
                            .foregroundColor(.black)
                        }
                    }
                }
                .padding(.top, -20)
            }
            .padding(.horizontal, 20)
        }
        .fontDesign(.rounded)
    }
}

#Preview {
    SelectedGenreView(selectedGenre: BooksData.sample.data[0])
}
