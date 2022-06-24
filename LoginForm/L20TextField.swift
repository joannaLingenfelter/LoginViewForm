//
//  L20TextField.swift
//  LoginForm
//
//  Created by Chris Stroud on 6/17/22.
//

import Foundation
import SwiftUI

struct L20TextField: View {

    @StateObject private var model: ViewModel

    var isSecure: Bool

    init(_ model: ViewModel, isSecure: Bool) {
        _model = StateObject(wrappedValue: model)
        self.isSecure = isSecure
    }

    var body: some View {
        HybridTextField(title: "", isSecure: isSecure, text: $model.text)
            .textFieldStyle(.l20TextField(title: model.title))
            .inlineError(model.error)
            .onChange(of: $model.text.wrappedValue) { newValue in
                if model.error != nil && !newValue.isEmpty {
                    withAnimation {
                        model.error = nil
                    }
                }
            }
            .padding(.horizontal, 20)
    }

    @ViewBuilder func HybridTextField(title: String,
                                      isSecure: Bool,
                                      text: Binding<String>) -> some View {
        if isSecure {
            SecureField(title, text: text)
        } else {
            TextField(title, text: text)
        }
    }
}

extension L20TextField {

    class ViewModel: ObservableObject {

        let title: String
        
        @Published var text: String = ""
        @Published var error: String? = nil

        init(title: String) {
            self.title = title
        }

        init<S>(title: S) where S: CustomStringConvertible {
            self.title = title.description
        }
    }
}
