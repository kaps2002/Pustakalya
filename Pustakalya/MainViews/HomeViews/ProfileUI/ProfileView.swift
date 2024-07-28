import SwiftUI

struct ProfileView: View {
    @State private var homeViewModel = HomeViewModel()
    @State private var commonViewModel = CommonViewModel()
    @State private var isEditSheet = false
    @State private var isAlert = false
    @State private var isLogout = false
    var color: Color
    var body: some View {
        ZStack {
            Color.orange.opacity(0.15)
                .ignoresSafeArea()
            VStack {
                if let name = homeViewModel.userData?.data.name, let email = homeViewModel.userData?.data.email {
                    VStack(spacing: 25) {
                        ProfileImgView(name: name, width: 100, height: 100, fontSize: 36, color: color)
                        VStack {
                            HStack {
                                Text(name)
                                    .font(.title2)
                                .fontWeight(.bold)
                            }
                            Text(email)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 15)
                        Button(action: {
                            isEditSheet = true
                        }, label: {
                            Text("Edit Profile")
                                .font(.system(size: 18))
                                .bold()
                                .padding(20)
                                .foregroundColor(.black)
                                .background(.orange)
                                .cornerRadius(10.0)
                        })
                    }
                }
                
                List {
                    Label("Settings", systemImage: "gearshape.fill")
                    Label("Address", systemImage: "map.fill")
                    Label("My Orders", systemImage: "menucard.fill")
                    Label("Change Password", systemImage: "lock.fill")
                    Button(action: {
                        homeViewModel.logout()
                        isLogout = true
                    }, label: {
                        Label("LogOut", systemImage: "rectangle.portrait.and.arrow.forward.fill")
                    })
                    
                    Button(action: {
                        isAlert = true
                    }, label: {
                        Label("Delete Account", systemImage: "xmark.bin.fill")
                            .foregroundColor(.red)
                    })
                }
                .fontWeight(.regular)
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                Text("Made by Karan & Shlok 🚀")
                    .foregroundStyle(.gray)
            }
            .padding(.top, 50)
        }
        .fullScreenCover(isPresented: $isLogout, content: {
            SignInView()
        })
        .alert(isPresented: $isAlert, content: {
            Alert(title: Text("Are you sure ?"), message: Text("This action can't be reversed"), primaryButton: .cancel(Text("Cancel"), action: {
                isAlert = false
            }), secondaryButton: .destructive(Text("Delete"), action: {
                isAlert = false
                homeViewModel.deleteUser { res in
                    if res {
                        isLogout = true
                    }
                }
            }))
        })
//        .redacted(reason: homeViewModel.userData == nil ? .placeholder : [])
        .sheet(isPresented: $isEditSheet, content: {
            EditProfileView()
        })
        .task {
            commonViewModel.checkInternet() { res in
                if res {
                    homeViewModel.getUser()
                }
            }
        }
        .fontDesign(.rounded)
    }
    
}

#Preview {
    ProfileView(color: .blue)
}
