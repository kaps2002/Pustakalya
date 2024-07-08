import SwiftUI

struct SelectedGenreView: View {
    var genre: String
    @State private var homeViewModel = HomeViewModel()

    var body: some View {
        ZStack {
            Color.orange.opacity(0.15)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text(homeViewModel.genreBooks?.genre.capitalized ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                ScrollView {
                    ForEach(homeViewModel.genreBooks?.books ?? [], id: \.id) { books in
                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 25) {
                                AsyncImageView(bookImg: books.thumbnail)
                                    .frame(width: 140, height: 200)
                                VStack(alignment: .leading, spacing: 10) {
                                    Spacer()
                                    Text(books.title)
                                        .font(.headline)
                                    Text("by \(books.author)")
                                        .font(.subheadline)
                                    VStack(alignment: .leading, spacing: 10) {
                                        if !books.subtitle.isEmpty {
                                            Text(books.subtitle)
                                        }
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
        .task {
            homeViewModel.getGenre(genre: genre)
        }
    }
}

#Preview {
    SelectedGenreView(genre: "Fiction")
}
