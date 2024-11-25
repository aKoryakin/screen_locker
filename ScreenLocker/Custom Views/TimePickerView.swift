//
//  TimePickerView.swift
//  ScreenLocker
//
//  Created by Alex on 22.11.2024.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var selectedTime: Date
    var title: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "",
                    selection: $selectedTime,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding()
                
                Button("Done") {
                    dismiss()
                }
                .padding()
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
