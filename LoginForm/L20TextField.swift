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

    @Binding private var isSecure: Bool

    init(_ model: ViewModel) {
        _model = StateObject(wrappedValue: model)
    }

    var body: some View {
        HybridTextField(title: "", isSecure: $isSecure, text: $model.text)
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
                                      isSecure: Binding<Bool>,
                                      text: Binding<String>) -> some View {
        if isSecure.wrappedValue {
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
        @Published var isSecure: Bool

        init(title: String, isSecure: Bool) {
            self.title = title
            self.isSecure = isSecure
        }

        init<S>(title: S, isSecure: Bool) where S: CustomStringConvertible {
            self.title = title.description
            self.isSecure = isSecure
        }
    }
}
