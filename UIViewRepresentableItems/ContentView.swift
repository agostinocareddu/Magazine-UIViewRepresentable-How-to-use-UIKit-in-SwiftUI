//
//  ContentView.swift
//  UIViewRepresentableItems
//
//  Created by Agostino Careddu on 15/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {

                Text("UIViewRepresentable Examples")
                    .bold()
                    .padding(.vertical, 25)

                NavigationLink("Slider") {
                    SliderDemoView()
                }

                NavigationLink("TextField") {
                    TextFieldDemoView()
                }

                NavigationLink("UIKit Focus") {
                    UIKitPeculiaritiesDemoView()
                }
            }
            .navigationTitle("Demo App")
            .listStyle(.plain)
        }
    }
}

#Preview {
    ContentView()
}
