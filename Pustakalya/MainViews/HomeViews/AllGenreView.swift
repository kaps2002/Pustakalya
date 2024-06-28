import SwiftUI

struct AllGenreView: View {
    var booksGenreList: [String]
    
    var body: some View {
        ZStack {
            Color.orange.opacity(0.5)
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                Text("Select your Genre")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                ScrollView(showsIndicators: false) {
                    ForEach(booksGenreList, id: \.self) { bookgenre in
                        NavigationLink {
                            
                        } label: {
                            ZStack {
                                Image(bookgenre)
                                    .resizable()
                                    .opacity(0.9)
                                    .frame(height: 175)
                                    .cornerRadius(10.0)
                                Text(bookgenre)
                                    .foregroundStyle(.white)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    AllGenreView(booksGenreList: ["Science", "History"])
}
