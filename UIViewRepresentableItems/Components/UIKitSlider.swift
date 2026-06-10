//
//  UIKitSlider.swift
//  UIViewRepresentableItems
//
//  Created by Agostino Careddu on 10/05/26.
//

import SwiftUI

struct UIKitSlider: UIViewRepresentable {
    @Binding var value: Double

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = .systemBlue
        slider.minimumValueImage = UIImage(systemName: "tortoise.fill")
        slider.maximumValueImage = UIImage(systemName: "hare.fill")
        slider.setThumbImage(
            UIImage(
                systemName: "figure.outdoor.rowing.circle.fill",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
            ),
            for: .normal
        )
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        let newValue = Float(value)
        if uiView.value != newValue {
            uiView.value = newValue
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }

    final class Coordinator: NSObject {
        var value: Binding<Double>

        init(value: Binding<Double>) {
            self.value = value
        }

        @objc func valueChanged(_ sender: UISlider) {
            value.wrappedValue = Double(sender.value)
        }
    }
}
