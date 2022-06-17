//
//  LoginView.swift
//  LoginForm
//
//  Created by Joanna Lingenfelter on 6/16/22.
//

import SwiftUI

struct LoginView: View {
    enum FormField: String, CaseIterable {
        case username
        case password

        var title: String {
            return rawValue.uppercased()
        }
    }

    @FocusState private var focusedField: FormField?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var usernameFocusError: String? = nil
    @State private var passwordFocusError: String? = nil

    let errorText = "Required field"

    var body: some View {
        VStack() {
            makeErrorTextField(text: $username,
                               error: $usernameFocusError,
                               title: FormField.username.title,
                               formField: .username)

            makeErrorTextField(text: $password,
                               error: $passwordFocusError,
                               title: FormField.password.title,
                               formField: .password)

            Spacer(minLength: 20)
            Button {
                withAnimation {
                    setFocusError(for: FormField.allCases)
                }
            } label: {
                Text("Login")
            }
            .buttonStyle(PrimaryButtonStyle())

        }
        .fixedSize(horizontal: false, vertical: true)
        .onSubmit {
            withAnimation {
                setFocusError(for: FormField.allCases)
            }
            
            if focusedField == .username {
                focusedField = .password
            } else {
                focusedField = nil
            }
        }
    }

    @ViewBuilder
    func makeErrorTextField(text: Binding<String>,
                            error: Binding<String?>,
                            title: String,
                            formField: FormField) -> some View {
        VStack(alignment: .leading) {
            TextField("", text: text)
                .textFieldStyle(HorizontalStackedLabelTextFieldStyle(title: title))
                .focused(self.$focusedField, equals: formField)
                .onChange(of: self.focusedField) { [focusedField] newValue in
                    withAnimation {
                        updateErrorsForFocusState(currentlyActiveField: newValue, previouslyActiveField: focusedField)
                    }
                }
                .onChange(of: text.wrappedValue) { newValue in
                    if error.wrappedValue != nil && !newValue.isEmpty {
                        withAnimation {
                            error.wrappedValue = nil
                        }
                    }
                }.modifier(InlineError(error: error.wrappedValue))
        }
        .padding(.horizontal, 20)
    }

    func updateErrorsForFocusState(currentlyActiveField: FormField?, previouslyActiveField: FormField?) {
        if previouslyActiveField == .username {
            if currentlyActiveField == .password {
                setFocusError(for: [.username])
            }
        } else if previouslyActiveField == .password {
            if currentlyActiveField == .username {
                setFocusError(for: [.password])
            }
        }
    }

    func setFocusError(for fields: [FormField]) {
        for field in fields {
            switch field {
            case .username:
                usernameFocusError = username.isEmpty ? errorText : nil
            case .password:
                passwordFocusError = password.isEmpty ? errorText : nil
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
