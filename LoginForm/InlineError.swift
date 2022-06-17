//
//  InlineError.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/17/22.
//

import SwiftUI

private struct InlineError<Label: View>: ViewModifier {
    let label: Label?

    init(_ error: String?) where Label == Text {
        if let error = error {
            label = Text(error)
                .foregroundColor(.red)
                .font(.caption)
        } else {
            label = nil
        }
    }

    init(@ViewBuilder _ label: () -> Label) {
        self.label = label()
    }

    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
            if let label = label {
                label
            }
        }
    }
}

extension View {

    func inlineError<Label: View>(@ViewBuilder _ label: () -> Label) -> some View {
        modifier(InlineError(label))
    }

    func inlineError(_ title: String?) -> some View {
        modifier(InlineError(title))
    }
}
