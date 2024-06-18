//
//  VerifyTokenView.swift
//  Pustakalya
//
//  Created by Roro on 18/06/24.
//

import SwiftUI

struct VerifyTokenView: View {
    @State private var codeString = ""
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
        }
        
    }
}

#Preview {
    VerifyTokenView()
}
