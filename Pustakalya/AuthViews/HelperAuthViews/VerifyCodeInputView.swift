//
//  VerifyCodeInputView.swift
//  Pustakalya
//
//  Created by Roro on 18/06/24.
//

import SwiftUI

struct VerifyCodeInputView: View {
    
    @State private var code: [String]
    let numOfFields: Int
    @FocusState private var fieldFocus: Int?
    
    init(numOfFields: Int, codeString: Binding<String>) {
        self.numOfFields = numOfFields
        self._codeString = codeString
        self.code = Array(repeating: "", count: numOfFields)
    }
    
    @State private var oldValue = ""
    @Binding var codeString: String
    
    var body: some View {
        HStack(spacing: 15) {
            ForEach(0..<numOfFields) { index in
                TextField("", text: $code[index], onEditingChanged: {
                    editing in
                    if editing {
                        oldValue = code[index]
                    }
                })
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
                .frame(width: 45, height: 45)
                .background(.gray.opacity(0.2))
                .keyboardType(.numberPad)
                .overlay(
                    Rectangle()
                        .frame(width: 30, height: 2)
                        .padding(.bottom, 3)
                        .foregroundColor(.gray),
                    alignment: .bottom
                )
                .cornerRadius(5.0)
                .focused($fieldFocus, equals: index)
                .tag(index)
                .onChange(of: code[index]) { newValue in
                    codeString = getCodeJoined()
                    if code[index].count > 1 {
                        let currentValue = Array(code[index])
                        if currentValue[0] == Character(oldValue) {
                            code[index] = String(code[index].suffix(1))
                        } else {
                            code[index] = String(code[index].prefix(1))
                        }
                    }
                    if !newValue.isEmpty {
                        if index == numOfFields - 1 {
                            fieldFocus = nil
                        }
                        else {
                            fieldFocus = (fieldFocus ?? 0) + 1
                        }
                    }
                    else {
                        fieldFocus = (fieldFocus ?? 0) - 1
                    }
                    
                }
            }
        }
        .padding(.top, 15)
    }
    func getCodeJoined() -> String {
        return code.joined()
    }
}

#Preview {
    VerifyCodeInputView(numOfFields: 6, codeString: .constant(""))
}
