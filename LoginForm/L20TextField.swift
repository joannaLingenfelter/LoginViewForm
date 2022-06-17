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

    init(_ model: ViewModel) {
        _model = StateObject(wrappedValue: model)
    }

    var body: some View {
        TextField("", text: $model.text)
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
}

extension L20TextField {

    class ViewModel: ObservableObject {

        let title: String
        @Published var text: String = ""
        @Published var error: String? = nil

        init<S>(title: S) where S: StringProtocol {
            self.title = String(title)
        }

        init<S>(title: S) where S: CustomStringConvertible {
            self.title = title.description
        }
    }
}
