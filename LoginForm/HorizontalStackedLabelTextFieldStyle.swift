//
//  HorizontalStackedLabelTextFieldStyle.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/17/22.
//

import SwiftUI

struct HorizontalStackedLabelTextFieldStyle: TextFieldStyle {
    let title: String

    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                Spacer(minLength: 10)
                configuration
                    .shadow(color: .gray, radius: 10)
            }

            Rectangle()
                .frame(height: 1)
                .background(Color.gray)
        }
    }
}

