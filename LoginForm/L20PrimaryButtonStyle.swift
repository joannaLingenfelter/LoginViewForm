//
//  L20PrimaryButtonStyle.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/17/22.
//

import SwiftUI

struct L20PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
            .background(Color(.black))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    fileprivate init() {

    }
}

extension ButtonStyle where Self == L20PrimaryButtonStyle {
    static var l20Primary: Self {
        L20PrimaryButtonStyle()
    }
}
