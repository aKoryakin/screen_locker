//
//  LockerView.swift
//  ScreenLocker
//
//  Created by Alex on 22.11.2024.
//

import SwiftUI
import FamilyControls

protocol LockerViewVMP {
    var activitySelection: FamilyActivitySelection { get }
    var isAllDayEnabled: Bool { get }
    var startTime: Date { get }
    var endTime: Date { get }
    var days: [DayModel] { get }
    var isLocked: Bool { get }
}

struct LockerView: View {
    @State private var pickerIsPresented = false
    @State private var isStartPickerPresented = false
    @State private var isEndPickerPresented = false
    @ObservedObject var model: LockerViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer().frame(height: 20)
                    
                    ListView(items: [
                        ListItem.Config(type: .button(title: "Apps & Websites") {
                            pickerIsPresented = true
                        }),
                        
                        ListItem.Config(type: .toggle(title: "All Day", isOn: $model.isAllDayEnabled)),
                        
                        ListItem.Config(type: .timePicker(title: "Starts", time: $model.startTime) {
                            isStartPickerPresented = true
                        }),
                        
                        ListItem.Config(type: .timePicker(title: "Ends", time: $model.endTime) {
                            isEndPickerPresented = true
                        })
                    ])
                    .padding(.horizontal, 16)
                    .background(.black.opacity(0.05))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    
                    Spacer().frame(height: 20)
                    
                    DayButtonsView(days: $model.days)
                        .padding(.top)
                    
                    Button(action: {
                        model.toggleBlocking()
                    }) {
                        Text(model.isLocked ? "Deactivate" : "Activate")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(model.isLocked ? Color.red : Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Test App by Koriakin")
            .familyActivityPicker(
                isPresented: $pickerIsPresented,
                selection: $model.activitySelection
            )
            .sheet(isPresented: $isStartPickerPresented) {
                TimePickerView(
                    selectedTime: $model.startTime,
                    title: "Select Start Time"
                )
            }
            .sheet(isPresented: $isEndPickerPresented) {
                TimePickerView(
                    selectedTime: $model.endTime,
                    title: "Select End Time"
                )
            }
        }
    }
}
