//
//  VerifyTokenView.swift
//  Pustakalya
//
//  Created by Roro on 18/06/24.
//

import SwiftUI

struct VerifyTokenView: View {
    @State private var codeString = ""
    @State private var authViewModel = AuthViewModel()
    @Binding var isSignUpSheet: Bool

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(.horizontal, 15)
            
            Text("Enter Verification Code")
                .padding(.horizontal, 15)
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .foregroundColor(.orange)
            
            VerifyCodeInputView(numOfFields: 4, codeString: $codeString)
                .padding(.bottom, 30)
            
            VStack(spacing: 15) {
                Button(action: {
                    authViewModel.isLoading = true
                    authViewModel.verifyCode(code: codeString, authToken: authViewModel.signUpModelData?.token ?? "") { result in
                        authViewModel.isLoading = false
                        if result {
                            isSignUpSheet = false
                        } else {
                            authViewModel.isAlert = true
                        }
                    }
                }, label: {
                    Text("Verify and SignUp")
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(width: 350, height: 60)
                        .background(.orange)
                        .clipShape(Capsule())
                })
            }
            .padding(.top, 30)
            .alert(isPresented: $authViewModel.isAlert, content: {
                Alert(title: Text("Verification Unsuccessful"), message: Text("Otp is invalid"), dismissButton: .default(Text("Ok")))
            })
            
            if authViewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding(.top, 20)
            }
            
        }
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    VerifyTokenView(isSignUpSheet: .constant(false))
}
