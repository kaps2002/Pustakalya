import SwiftUI

struct SignInView: View {
    @State private var authViewModel = AuthViewModel()
    @State private var isSignUpSheet = false

    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 15) {
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                Text("SignIn")
                    .padding(.horizontal, 15)
                    .font(.title)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundColor(.orange)
                
                EmailFieldView(email: $authViewModel.email, isEmailValid: $authViewModel.isEmailValid)
                PasswordFieldView(password: $authViewModel.password, isPasswordValid: $authViewModel.isPasswordValid, isSecured: $authViewModel.isSecured, placeholder: "Your Password")
            }
            
            VStack(spacing: 15) {
                Button(action: {
                    submitAction()
                }, label: {
                    Text("SignIn")
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(width: 350, height: 60)
                        .background(.orange)
                        .clipShape(Capsule())
                })
                HStack(spacing: 4) {
                    Text("Don't have an account yet?")
                    Button(action: {
                        isSignUpSheet = true
                    }, label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    })
                }
                .font(.subheadline)
                
                if authViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        }
        .sheet(isPresented: $isSignUpSheet, content: {
            SignUpView(isSignUpSheet: $isSignUpSheet)
                .presentationDragIndicator(.visible)
                .presentationDetents([.height(700)])
                .presentationCornerRadius(20.0)
        })
        .alert(isPresented: $authViewModel.isAlert, content: {
            Alert(title: Text("Login Unsuccessful"), message: Text("User dont Exists"), dismissButton: .default(Text("Ok")))
        })
        .alert(isPresented: $authViewModel.commonViewModel.isAlert) {
            Alert(title: Text("No Internet"), message: Text("Please check the internet connection"), dismissButton: .default(Text("Go to Settings ⚙️")){
                authViewModel.commonViewModel.settingsOpener()
            })
        }
    }
    func submitAction() {
        let ans = authViewModel.validation(email: authViewModel.email, password: authViewModel.password)
        if ans == 1 {
            authViewModel.isEmailValid = false
        } else if ans == 2 {
            authViewModel.isPasswordValid = false
        } else {
            authViewModel.commonViewModel.checkInternet() { res in
                if res {
                    authViewModel.isLoading = true
                    authViewModel.signin(email: authViewModel.email, password: authViewModel.password) { res in
                        authViewModel.isLoading = false
                        if res {
                            authViewModel.email = ""
                            authViewModel.password = ""
                        } else {
                            authViewModel.email = ""
                            authViewModel.password = ""
                            authViewModel.isAlert = true
                        }
                    }
                } else {
                    authViewModel.commonViewModel.isAlert = true
                }
            }
            
        }
    }
}

#Preview {
    SignInView()
}
