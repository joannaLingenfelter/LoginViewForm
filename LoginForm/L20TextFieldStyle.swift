//
//  L20TextFieldStyle.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/17/22.
//

import SwiftUI

struct L20TextFieldStyle: TextFieldStyle {
    let title: String

    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .padding(.leading, 10)
                Spacer(minLength: 10)
                configuration
                    .shadow(color: .gray, radius: 10)
            }

            Rectangle()
                .frame(height: 1)
                .background(Color.gray)
        }
    }

    fileprivate init(title: String) {
        self.title = title
    }
}

extension TextFieldStyle where Self == L20TextFieldStyle {

    static func l20TextField(title: String) -> Self {
        L20TextFieldStyle(title: title)
    }
}

