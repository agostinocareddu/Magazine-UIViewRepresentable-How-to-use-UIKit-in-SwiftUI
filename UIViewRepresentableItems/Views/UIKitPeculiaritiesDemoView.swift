//
//  UIKitPeculiaritiesDemoView.swift
//  UIViewRepresentableItems
//
//  Created by Agostino Careddu on 20/05/26.
//

import SwiftUI

struct UIKitPeculiaritiesDemoView: View {
    @State private var swiftUIText: String = ""
    @FocusState private var swiftUIFocused: Bool

    @State private var uiKitText: String = ""
    @State private var uiKitFocused: Bool = false

    private let maxLength: Int = 120

    private var swiftUIRemaining: Int {
        maxLength - swiftUIText.count
    }

    private var uiKitRemaining: Int {
        maxLength - uiKitText.count
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Native SwiftUI")
                    .font(.title3.weight(.semibold))
                    .padding(.top, 20)

                TextEditor(text: $swiftUIText)
                    .frame(height: 170)
                    .padding(8)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .focused($swiftUIFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                swiftUIFocused = false
                            }
                        }
                    }
                    .onChange(of: swiftUIText) { _, newValue in
                        if newValue.count > maxLength {
                            swiftUIText = String(newValue.prefix(maxLength))
                        }
                    }

                Text("Remaining: \(swiftUIRemaining)")
                    .font(.body.monospacedDigit())

                Text("Current text: \(swiftUIText.isEmpty ? "-" : swiftUIText)")
                    .font(.body.monospaced())

                Spacer()
                    .frame(height: 40)

                Text("UIKit with UIViewRepresentable")
                    .font(.title3.weight(.semibold))

                UIKitAdvancedTextView(
                    text: $uiKitText,
                    isFirstResponder: $uiKitFocused,
                    placeholder: "Write a multiline note",
                    maxLength: maxLength
                )
                .frame(height: 170)

                HStack {
                    Text("Remaining: \(uiKitRemaining)")
                        .font(.body.monospacedDigit())
                    Spacer()
                    Button(uiKitFocused ? "Dismiss Keyboard" : "Focus") {
                        uiKitFocused.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                }

                Text("Current text: \(uiKitText.isEmpty ? "-" : uiKitText)")
                    .font(.body.monospaced())

                Text("Benefits of this approach: \n - native inputAccessoryView \n - delegate callbacks for text flow control \n - custom placeholder inside UITextView \n - direct first responder management.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
        .navigationTitle("UIKit Focus")
    }
}

#Preview {
    NavigationStack {
        UIKitPeculiaritiesDemoView()
    }
}
