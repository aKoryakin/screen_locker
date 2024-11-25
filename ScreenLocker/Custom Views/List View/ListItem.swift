//
//  ListItem.swift
//  ScreenLocker
//
//  Created by Alex on 22.11.2024.
//

import SwiftUI

enum ListItemType {
    case button(title: String, action: () -> Void)
    case toggle(title: String, isOn: Binding<Bool>)
    case timePicker(title: String, time: Binding<Date>, action: () -> Void)
}

struct ListItem: View {
    
    struct Config {
        let type: ListItemType
    }
    
    let config: Config

    var body: some View {
        HStack {
            switch config.type {
            case .button(let title, _), .toggle(let title, _), .timePicker(let title, _, _):
                Text(title)
                    .font(.system(size: 16))
            }
            Spacer()

            switch config.type {
            case .button(_, let action):
                Button(action: action) {
                    Text("Select")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .cornerRadius(6)
                }

            case .toggle(_, let isOn):
                Toggle("", isOn: isOn)
                    .labelsHidden()

            case .timePicker(_, let time, let action):
                Button(action: action) {
                    Text(timeString(from: time.wrappedValue))
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .padding(8)
                        .frame(width: 80)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                }
            }
        }
        .padding(.vertical, 8)
    }

    private func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
