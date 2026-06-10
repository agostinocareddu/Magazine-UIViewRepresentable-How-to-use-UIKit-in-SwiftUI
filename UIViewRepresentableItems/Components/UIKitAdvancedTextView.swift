//
//  UIKitAdvancedTextView.swift
//  UIViewRepresentableItems
//
//  Created by Agostino Careddu on 20/05/26.
//

import SwiftUI

struct UIKitAdvancedTextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFirstResponder: Bool
    var placeholder: String
    var maxLength: Int

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView(frame: .zero)
        textView.delegate = context.coordinator
        textView.font = .preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        textView.backgroundColor = .secondarySystemBackground

        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = .preferredFont(forTextStyle: .body)
        placeholderLabel.textColor = .gray
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.tag = 999
        textView.addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 12),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 14)
        ])

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .prominent,
            target: context.coordinator,
            action: #selector(Coordinator.didTapDone)
        )
        let spacer = UIBarButtonItem(systemItem: .flexibleSpace)
        let toolbar = UIToolbar()
        toolbar.items = [spacer, doneButton]
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar

        context.coordinator.textView = textView
        context.coordinator.updatePlaceholderVisibility(for: textView)

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }

        context.coordinator.updatePlaceholderVisibility(for: uiView)

        if isFirstResponder, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        } else if !isFirstResponder, uiView.isFirstResponder {
            uiView.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, isFirstResponder: $isFirstResponder, maxLength: maxLength)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>
        var maxLength: Int
        weak var textView: UITextView?

        init(text: Binding<String>, isFirstResponder: Binding<Bool>, maxLength: Int) {
            self.text = text
            self.isFirstResponder = isFirstResponder
            self.maxLength = maxLength
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            isFirstResponder.wrappedValue = true
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            isFirstResponder.wrappedValue = false
        }

        func textViewDidChange(_ textView: UITextView) {
            if textView.text.count > maxLength {
                textView.text = String(textView.text.prefix(maxLength))
            }
            text.wrappedValue = textView.text
            updatePlaceholderVisibility(for: textView)
        }

        func updatePlaceholderVisibility(for textView: UITextView) {
            guard let placeholderLabel = textView.viewWithTag(999) as? UILabel else {
                return
            }
            placeholderLabel.isHidden = !textView.text.isEmpty
        }

        @objc func didTapDone() {
            textView?.resignFirstResponder()
            isFirstResponder.wrappedValue = false
        }
    }
}
