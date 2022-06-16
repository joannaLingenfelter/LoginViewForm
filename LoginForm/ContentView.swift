//
//  ContentView.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/16/22.
//

import SwiftUI

protocol ErrorShowingTextFieldStyle: TextFieldStyle {
    init(title: String, error: String)
}

struct ErrorTextField<TextFieldStyle: ErrorShowingTextFieldStyle>: View {
    typealias Body = TextField

    @Binding var text: String
    @Binding var error: String

    let title: String
    let textFieldStyle: TextFieldStyle.Type

    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(textFieldStyle.init(title: self.title, error: error))
    }
}

struct LabeledTextFieldStyle: ErrorShowingTextFieldStyle {
    let title: String
    let error: String

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

            Text(error)
                .foregroundColor(.red)
                .opacity(error.isEmpty ? 0.0 : 1.0)
                .font(.caption)
        }
    }
}

struct ContentView: View {
    enum FormField: String {
        case username
        case password

        var title: String {
            return rawValue.uppercased()
        }
    }

    @FocusState private var focusedField: FormField?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showUsernameFocusError = false
    @State private var showPasswordFocusError = false

    let errorText = "Required field"

    var body: some View {
        VStack() {
            let userNameErrorBinding: Binding<String> = Binding {
                showUsernameFocusError ? errorText : ""
            } set: { _ in }

            let passwordErrorBinding: Binding<String> = Binding {
                showPasswordFocusError ? errorText : ""
            } set: { _ in }

            ErrorTextField(text: $username, error: userNameErrorBinding, title: FormField.username.title, textFieldStyle: LabeledTextFieldStyle.self)
                .focused($focusedField, equals: .username)
                .padding(.horizontal, 20)
                .onChange(of: focusedField) { [focusedField] newValue in
                    if focusedField == nil {
                        // First change of focus
                        if newValue == .username {
                            showUsernameFocusError = username.isEmpty
                        } else if newValue == .password {
                            showPasswordFocusError = password.isEmpty
                        }
                    } else {
                        showUsernameFocusError = username.isEmpty
                        showPasswordFocusError = password.isEmpty
                    }
                }

            ErrorTextField(text: $password, error: passwordErrorBinding, title: FormField.password.title, textFieldStyle: LabeledTextFieldStyle.self)
                .focused($focusedField, equals: .password)
                .padding(.horizontal, 20)
                .onChange(of: focusedField) { [focusedField] newValue in
                    if focusedField == nil {
                        // First change of focus
                        if newValue == .password {
                            showPasswordFocusError = password.isEmpty
                        } else if newValue == .username {
                            showUsernameFocusError = username.isEmpty
                        }
                    } else {
                        showUsernameFocusError = username.isEmpty
                        showPasswordFocusError = password.isEmpty
                    }
                }
            Spacer(minLength: 20)
            Button {
                showUsernameFocusError = username.isEmpty
                showPasswordFocusError = password.isEmpty
            } label: {
                Text("Login")
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .background(Color(.black))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))

        }
        .fixedSize(horizontal: false, vertical: true)
        .onSubmit {
            showUsernameFocusError = username.isEmpty
            showPasswordFocusError = password.isEmpty
            
            if focusedField == .username {
                focusedField = .password
            } else {
                focusedField = nil
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
