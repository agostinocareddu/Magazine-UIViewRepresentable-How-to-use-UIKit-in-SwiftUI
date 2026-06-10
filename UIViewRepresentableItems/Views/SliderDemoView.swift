//
//  SliderDemoView.swift
//  UIViewRepresentableItems
//
//  Created by Agostino Careddu on 19/05/26.
//

import SwiftUI

struct SliderDemoView: View {
    @State private var swiftUISliderValue: Double = 50
    @State private var uiKitSliderValue: Double = 50

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Native SwiftUI")
                    .font(.title3.weight(.semibold))
                    .padding(.top, 20)

                Slider(value: $swiftUISliderValue, in: 0...100, step: 1)
                    .frame(height: 44)

                Text("Current value: \(Int(swiftUISliderValue))")
                    .font(.title2.monospacedDigit())

                Spacer()
                    .frame(height: 50)

                Text("UIKit with UIViewRepresentable")
                    .font(.title3.weight(.semibold))

                UIKitSlider(value: $uiKitSliderValue)
                    .frame(height: 44)

                Text("Current value: \(Int(uiKitSliderValue))")
                    .font(.title2.monospacedDigit())

                Text("Benefits of this approach: \n - custom thumb image \n - min/max icons customization")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
        .navigationTitle("Slider")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Slider")
                    .font(.system(size: 30))
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SliderDemoView()
    }
}
