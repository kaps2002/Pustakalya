import SwiftUI

struct RootView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Books", systemImage: "books.vertical")
                }
            FavoriteView()
                .tabItem {
                    Label("My  Wishlist", systemImage: "heart")
                }
            AddtoCartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
        }
        .accentColor(.orange)
    }
}

#Preview {
    RootView()
}
