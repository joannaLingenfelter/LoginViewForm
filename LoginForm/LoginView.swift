//
//  LoginView.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/16/22.
//

import SwiftUI

private enum TextFieldKey: String, CustomStringConvertible {

    case username
    case password

    var description: String {
        rawValue.capitalized
    }
}

struct LoginView: View {

    @StateObject private var usernameModel = L20TextField.ViewModel(title: TextFieldKey.username)
    @StateObject private var passwordModel = L20TextField.ViewModel(title: TextFieldKey.password)

    @FocusState private var focusedField: TextFieldKey?

    let errorText = "Required field"

    var body: some View {
        VStack(spacing: 20) {
            VStack {
                LoginTextField(usernameModel, key: .username)
                    .textContentType(.username)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
                LoginTextField(passwordModel, key: .password)
                    .textContentType(.password)
                    .submitLabel(.send)
                    .onSubmit {
                        focusedField = nil
                    }
            }
            Button {
                focusedField = nil
            } label: {
                Text("Login")
            }
            .buttonStyle(.l20Primary)
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    @ViewBuilder
    private func LoginTextField(_ model: L20TextField.ViewModel, key: TextFieldKey) -> some View {
        L20TextField(model)
            .focused(self.$focusedField, equals: key)
            .onChange(of: self.focusedField) { [focusedField] _ in
                withAnimation {
                    if focusedField == key {
                        model.error = model.text.isEmpty ? errorText : nil
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
