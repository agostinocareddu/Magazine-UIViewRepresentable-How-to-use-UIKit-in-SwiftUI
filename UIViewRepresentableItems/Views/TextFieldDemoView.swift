//
//  TextFieldDemoView.swift
//  UIViewRepresentableItems
//
//  Created by Agostino Careddu on 19/05/26.
//

import SwiftUI

struct TextFieldDemoView: View {
    @State private var swiftUIText: String = ""
    @State private var uiKitText: String = ""
    @State private var didPressReturn: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Native SwiftUI")
                    .font(.title3.weight(.semibold))
                    .padding(.top, 20)

                TextField(
                    "",
                    text: $swiftUIText,
                    prompt: Text("Write something")
                        .foregroundColor(.gray)
                )
                .textFieldStyle(.roundedBorder)

                Text("Current text: \(swiftUIText.isEmpty ? "-" : swiftUIText)")
                    .font(.body.monospaced())

                Spacer()
                    .frame(height: 50)
                
                Text("UIKit with UIViewRepresentable")
                    .font(.title3.weight(.semibold))

                UIKitTextField(text: $uiKitText, placeholder: "Write something") {
                    didPressReturn = true
                }
                .frame(height: 36)

                Text("Current text: \(uiKitText.isEmpty ? "-" : uiKitText)")
                    .font(.body.monospaced())

                if didPressReturn {
                    Text("Return pressed")
                        .font(.footnote)
                        .foregroundStyle(.green)
                }

                Text("Benefits of this approach: \nleft icon, clear button while editing, return key callback")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
        .navigationTitle("TextField")
    }
}

#Preview {
    NavigationStack {
        TextFieldDemoView()
    }
}
