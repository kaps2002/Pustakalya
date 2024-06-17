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
                    Label("Wishlist", systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.orange)
    }
}

#Preview {
    RootView()
}
