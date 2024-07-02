import SwiftUI

struct SelectedBookView: View {
    var book: Book
    @Binding var isSheetOpen: Bool
    @State private var items = 1

    var body: some View {
        ZStack {
            Color.orange.opacity(0.15)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack(alignment: .topLeading) {
                        AsyncImageView(bookImg: book.thumbnail)
                            .frame(height: 400)
                        
                        HStack {
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "heart")
                                    .imageScale(.large)
                                    .foregroundColor(.red)
                            })
                            Spacer()
                            Button(action: {
                                isSheetOpen = false
                            }, label: {
                                Image(systemName: "xmark")
                                    .imageScale(.medium)
                                    .foregroundColor(.black)
                                    .background(Circle().fill(.white.opacity(0.75)).frame(width: 30, height: 30))
                            })
                        }
                        .padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(book.genreType.capitalized)
                            .foregroundStyle(.blue)
                            .fontWeight(.semibold)
                        
                        Text("\(book.title): \(book.subtitle) by \(book.author)")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(4)
                        Text(book.description)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(4)
                        
                        HStack {
                            Text("₹\(book.price)")
                        }
                        Text("\(book.rating) ⭐️")
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                    
                    HStack {
                        Stepper(onIncrement: {
                            items += 1
                        }, onDecrement: {
                            items -= 1
                        }, label: {
                            Text("Add to Cart")
                                .font(.title3)
                                .fontWeight(.semibold)
                        })
                    }
                    .padding(.horizontal, 20)
                }
                .fontDesign(.rounded)
            }
        }
    }
}

#Preview {
    SelectedBookView(book: BooksData.sample.data[0].books[0], isSheetOpen: .constant(false))
}
