import SwiftUI

struct AllBooksView: View {
    
    var booksData: BooksData
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text("All Books 📚")
                .font(.system(size: 36))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 5) {
                ForEach(booksData.data, id: \.genre) { genres in
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
                            .frame(width: 150, height: 225)
                            .padding(.top, 10)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AllBooksView(booksData: BooksData.sample)
}
