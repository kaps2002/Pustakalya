import SwiftUI

struct PasswordFieldView: View {
    @Binding var password: String
        @Binding var isPasswordValid: Bool
        @Binding var isSecured: Bool
        var placeholder: String

        var body: some View {
            VStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Group {
                        if isSecured {
                            SecureField(placeholder, text: $password)
                            
                        } else {
                            TextField(placeholder, text: $password)
                        }
                    }
                    
                    Button(action: {
                        isSecured.toggle()
                    }) {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                            .accentColor(.orange)
                    }
                }
                .padding(.horizontal, 15)
                .frame(height: 45)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.lightGray)),
                    alignment: .bottom
                )
                .onChange(of: password) {
                    isPasswordValid = true
                }
                
                Text(isPasswordValid ? "" : "Please enter the valid Password")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            .padding(.horizontal, 15)
        }
}

#Preview {
    PasswordFieldView(password: .constant(""), isPasswordValid: .constant(true), isSecured: .constant(true), placeholder: "Password")
}
