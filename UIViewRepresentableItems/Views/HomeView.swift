//
//  HomeView.swift
//  UIViewRepresentableItems
//
//  Created by Agostino Careddu on 15/04/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {

                Text("UIViewRepresentable Examples")
                    .bold()
                    .font(.system(size: 20))
                    .padding(.vertical, 40)
                    .foregroundStyle(Color.white)

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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Demo App")
                        .font(.system(size: 32))
                        .foregroundStyle(.red)
                }
            }
            .foregroundStyle(Color.blue)
            .listStyle(.automatic)
        }
    }
}

#Preview {
    HomeView()
}
