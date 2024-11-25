//
//  DayButton.swift
//  ScreenLocker
//
//  Created by Alex on 22.11.2024.
//

import SwiftUI

struct DayButton: View {
    let title: String
    @Binding var isActive: Bool

    var body: some View {
        Button(action: {
            isActive.toggle()
        }) {
            Text(title)
                .fontWeight(.bold)
                .padding()
                .frame(width: 40, height: 40)
                .background(isActive ? Color.blue : Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}
