//
//  InlineError.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/17/22.
//

import SwiftUI

struct InlineError: ViewModifier {
    let error: String?

    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content

            Text(error ?? "")
                .foregroundColor(.red)
                .opacity(error == nil ? 0.0 : 1.0)
                .font(.caption)
        }
    }
}
