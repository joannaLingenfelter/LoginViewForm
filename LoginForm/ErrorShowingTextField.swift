//
//  ErrorShowingTextField.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/17/22.
//

import SwiftUI

protocol ErrorShowingTextFieldStyle: TextFieldStyle {
    init(title: String, error: String?)
}

struct ErrorTextField<TextFieldStyle: ErrorShowingTextFieldStyle>: View {
    @Binding var text: String
    @Binding var error: String?

    let title: String
    let textFieldStyle: TextFieldStyle.Type

    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(textFieldStyle.init(title: title, error: error))
    }
}
