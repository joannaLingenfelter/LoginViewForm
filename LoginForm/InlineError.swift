//
//  InlineError.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/17/22.
//

import SwiftUI

private struct InlineError<Label: View>: ViewModifier {

    private let label: Label

    init(@ViewBuilder _ label: () -> Label) {
        self.label = label()
    }

    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
            label
        }
    }
}

extension View {

    func inlineError(_ title: String?) -> some View {
        modifier(InlineError {
            if let title = title {
                Text(title)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        })
    }

}
