import SwiftUI

struct EmailFieldView: View {
    @Binding var email: String
    @Binding var isEmailValid: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Your Email", text: $email)
                .padding(.horizontal, 15)
                .frame(height: 45)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(isEmailValid ? Color(.lightGray) : .red),
                    alignment: .bottom
                )
                .onChange(of: email) {
                    isEmailValid = true
                }
            
            Text(isEmailValid ? "" : "Please Enter the valid Email Address")
                .font(.caption)
                .foregroundStyle(.red)
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    EmailFieldView(email: .constant(""), isEmailValid: .constant(true))
}
