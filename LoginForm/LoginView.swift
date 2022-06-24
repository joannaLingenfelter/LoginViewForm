//
//  LoginView.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/16/22.
//

import SwiftUI

private enum TextFieldKey: String, CustomStringConvertible {

    case email
    case password

    var description: String {
        rawValue.capitalized
    }

    var errorText: String {
        "Required field"
    }
}

struct LoginView: View {

    @StateObject private var emailModel = L20TextField.ViewModel(title: TextFieldKey.email.description, isSecure: false)
    @StateObject private var passwordModel = L20TextField.ViewModel(title: TextFieldKey.password.description, isSecure: true)

    @FocusState private var focusedField: TextFieldKey?

<<<<<<< Updated upstream
    let errorText = "Required field"

    init() {
        _usernameModel = StateObject(wrappedValue: L20TextField.ViewModel(title: TextFieldKey.username.description))
        _passwordModel = StateObject(wrappedValue: L20TextField.ViewModel(title: TextFieldKey.password.description))
    }

=======
>>>>>>> Stashed changes
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 50) {
                LoginTextField(emailModel, key: .email)
                    .textContentType(.username)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
                VStack(alignment: .trailing, spacing: 5) {
                    LoginTextField(passwordModel, key: .password)
                        .textContentType(.password)
                        .submitLabel(.send)
                        .onSubmit {
                            focusedField = nil
                        }

                    Button {
                        print("Forgot password pressed!")
                    } label: {
                        Text("Forgot password?")
                            .foregroundColor(Color.black)
                    }
                    .padding(.trailing, 20)
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
        L20TextField(model, isSecure: key == .password)
            .focused(self.$focusedField, equals: key)
            .onChange(of: self.focusedField) { [focusedField] _ in
                withAnimation {
                    if focusedField == key {
                        model.error = model.text.isEmpty ? key.errorText : nil
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
