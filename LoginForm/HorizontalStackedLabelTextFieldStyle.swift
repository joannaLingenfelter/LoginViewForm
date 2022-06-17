//
//  HorizontalStackedLabelTextFieldStyle.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/17/22.
//

import SwiftUI

struct HorizontalStackedLabelTextFieldStyle: ErrorShowingTextFieldStyle {
    let title: String
    let error: String?

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

            if let error = error {
                Text(error)
                    .foregroundColor(.red)
                    .opacity(error.isEmpty ? 0.0 : 1.0)
                    .font(.caption)
            }
        }
    }
}

