//
//  DayButtonsView.swift
//  ScreenLocker
//
//  Created by Alex on 22.11.2024.
//

import SwiftUI

struct DayButtonsView: View {
    @Binding var days: [DayModel]

    var body: some View {
        HStack {
            ForEach(days, id: \.index) { day in
                DayButton(
                    title: dayAbbreviation(for: day.index),
                    isActive: $days[day.index].active
                )
            }
        }
        .padding()
    }

    private func dayAbbreviation(for index: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter.veryShortWeekdaySymbols[index]
    }
}
