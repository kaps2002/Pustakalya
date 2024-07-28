//
//  EditProfileView.swift
//  Pustakalya
//
//  Created by Roro on 14/07/24.
//

import SwiftUI

struct EditProfileView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.orange.opacity(0.15)
                    .ignoresSafeArea()
            }
            .navigationBarTitle("Edit your Details")
        }
    }
}

#Preview {
    EditProfileView()
}
