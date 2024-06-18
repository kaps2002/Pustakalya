import SwiftUI

struct SignUpView: View {
    @State private var authViewModel = AuthViewModel()
    @Binding var isSignUpSheet: Bool
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Spacer()
                Button(action: {
                    isSignUpSheet = false
                }, label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .accentColor(.secondary)
                })
                .padding(.horizontal, 15)
            }
            .padding(.top, 30)
                
            VStack(spacing: 15) {
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding(.horizontal, 15)

                Text("SignUp")
                    .padding(.horizontal, 15)
                    .font(.title)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundColor(.orange)
                
                VStack(alignment: .leading) {
                    TextField("Your Name", text: $authViewModel.name)
                        .padding(.horizontal, 15)
                        .frame(height: 45)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(authViewModel.isNameValid ? Color(.lightGray) : .red),
                            alignment: .bottom
                        )
                        .onChange(of: authViewModel.name) {
                            authViewModel.isNameValid = true
                        }
                    Text(authViewModel.isNameValid ? "" : "Please Enter your name")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
                .padding(.horizontal, 15)
                
                EmailFieldView(email: $authViewModel.email, isEmailValid: $authViewModel.isEmailValid)
                PasswordFieldView(password: $authViewModel.password, isPasswordValid: $authViewModel.isPasswordValid, isSecured: $authViewModel.isSecured, placeholder: "Your Password")
            }
            
            Spacer()
            
            if authViewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            VStack(spacing: 15) {
                Button(action: {
                    submitAction()
                }, label: {
                    Text("Sign Up")
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(width: 350, height: 60)
                        .background(.orange)
                        .clipShape(Capsule())
                })
                HStack(spacing: 4) {
                    Text("Already have an account?")
                    Button(action: {
                        isSignUpSheet = false
                    }, label: {
                        Text("LogIn")
                            .fontWeight(.semibold)
                    })
                }
                .font(.subheadline)
            }
        }
        .alert(isPresented: $authViewModel.isAlert, content: {
            Alert(title: Text("SignUp Unsuccessful"), message: Text("User Already Exists"), dismissButton: .default(Text("Ok")))
        })
        .alert(isPresented: $authViewModel.commonViewModel.isAlert) {
            Alert(title: Text("No Internet"), message: Text("Please check the internet connection"), dismissButton: .default(Text("Go to Settings ⚙️")){
                authViewModel.commonViewModel.settingsOpener()
            })
        }
    }
    
    func submitAction() {
        let ans = authViewModel.validation(email: authViewModel.email, password: authViewModel.password)
        if authViewModel.name.isEmpty {
            authViewModel.isNameValid = false
        } else if ans == 1 {
            authViewModel.isEmailValid = false
        } else if ans == 2 {
            authViewModel.isPasswordValid = false
        } else {
            authViewModel.commonViewModel.checkInternet() { res in
                if res {
                    authViewModel.isLoading = true
                    authViewModel.signUp(email: authViewModel.email, password: authViewModel.password, name: authViewModel.name) { res in
                        authViewModel.isLoading = false
                        if res {
                            authViewModel.email = ""
                            authViewModel.password = ""
                            authViewModel.name = ""
                        } else {
                            authViewModel.email = ""
                            authViewModel.password = ""
                            authViewModel.name = ""
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
    SignUpView(isSignUpSheet: .constant(true))
}
