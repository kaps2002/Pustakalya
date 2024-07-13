//
//  ProfileImgView.swift
//  Pustakalya
//
//  Created by Roro on 11/07/24.
//

import SwiftUI

struct ProfileImgView: View {
    var name: String
    var width: Double
    var height: Double
    var fontSize: Double

    var body: some View {
        Text("\(name.dropLast(name.count-1))")
            .font(.system(size: fontSize))
            .foregroundStyle(.black)
            .background(
                Circle()
                    .fill(Color.random())
                    .frame(width: width, height: height)
            )
    }
}

public extension Color {
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}

#Preview {
    ProfileImgView(name: "Karan Pandey", width: 20, height: 20, fontSize: 30)
}
