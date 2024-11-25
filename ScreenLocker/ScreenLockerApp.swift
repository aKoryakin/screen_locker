//
//  ScreenLockerApp.swift
//  ScreenLocker
//
//  Created by Alex on 22.11.2024.
//

import SwiftUI
import FamilyControls

@main
struct ScreenLockerApp: App {
    var body: some Scene {
        WindowGroup {
            LockerView(model: LockerViewModel())
                .onAppear {
                    Task {
                        do {
                            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
        }
    }
}
