//
//  UIKitTextField.swift
//  UIViewRepresentableItems
//
//  Created by Agostino Careddu on 15/05/26.
//

import SwiftUI

struct UIKitTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var onReturn: (() -> Void)? = nil

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.gray]
        )


        // UIKit-only customization that is hard to reproduce 1:1 in pure SwiftUI TextField.
        textField.returnKeyType = .done

        let clearButton = UIButton(type: .system)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = .gray
        clearButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        clearButton.addAction(UIAction { [weak textField, weak coordinator = context.coordinator] _ in
            textField?.text = ""
            coordinator?.text.wrappedValue = ""
            if let textField {
                coordinator?.updateClearButtonVisibility(for: textField)
            }
        }, for: .touchUpInside)
        textField.rightView = clearButton
        textField.rightViewMode = .whileEditing

        let iconView = UIImageView(image: UIImage(systemName: "person.text.rectangle"))
        iconView.tintColor = .blue
        textField.leftView = iconView
        textField.leftViewMode = .always

        textField.delegate = context.coordinator
        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.textDidChange(_:)),
            for: .editingChanged
        )
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        context.coordinator.updateClearButtonVisibility(for: uiView)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, onReturn: onReturn)
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var onReturn: (() -> Void)?

        init(text: Binding<String>, onReturn: (() -> Void)?) {
            self.text = text
            self.onReturn = onReturn
        }

        @objc func textDidChange(_ sender: UITextField) {
            text.wrappedValue = sender.text ?? ""
            updateClearButtonVisibility(for: sender)
        }

        func updateClearButtonVisibility(for textField: UITextField) {
            let isEmpty = (textField.text ?? "").isEmpty
            textField.rightView?.isHidden = isEmpty
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            onReturn?()
            return true
        }
    }
}
