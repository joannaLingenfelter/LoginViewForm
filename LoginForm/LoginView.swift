//
//  LoginView.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/16/22.
//

import SwiftUI

enum TextFieldKey: String, CustomStringConvertible {

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
                L20TextField(usernameModel)
                    .focused(self.$focusedField, equals: .username)
                    .onChange(of: self.focusedField) { [focusedField] _ in
                        withAnimation {
                            if focusedField == .username {
                                usernameModel.error = usernameModel.text.isEmpty ? errorText : nil
                            }
                        }
                    }.onSubmit {
                        focusedField = .password
                    }.submitLabel(.next)
                L20TextField(passwordModel)
                    .focused(self.$focusedField, equals: .password)
                    .onChange(of: self.focusedField) { [focusedField] _ in
                        withAnimation {
                            if focusedField == .password {
                                passwordModel.error = passwordModel.text.isEmpty ? errorText : nil
                            }
                        }
                    }.onSubmit {
                        focusedField = nil
                    }.submitLabel(.send)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
