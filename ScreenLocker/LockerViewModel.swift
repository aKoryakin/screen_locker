//
//  LockerViewModel.swift
//  ScreenLocker
//
//  Created by Alex on 22.11.2024.
//

import Foundation
import Combine
import FamilyControls
import ManagedSettings

class LockerViewModel: ObservableObject, LockerViewVMP {
    @Published var activitySelection = FamilyActivitySelection()
    @Published var isAllDayEnabled = false
    @Published var startTime = Date()
    @Published var endTime = Date()
    @Published var days: [DayModel] = (0...6).map { DayModel(index: $0) }
    @Published var isLocked = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }

    private func setupBindings() {
        $isAllDayEnabled
            .sink { [weak self] value in
                self?.days = (0...6).map { DayModel(index: $0, active: value) }
            }
            .store(in: &cancellables)

        $days.combineLatest($startTime, $endTime)
            .sink { [weak self] _ in
                self?.updateBlockingStatus()
            }
            .store(in: &cancellables)
    }

    private func updateBlockingStatus() {
        let currentTime = Date()
        let calendar = Calendar.current
        let currentDay = calendar.component(.weekday, from: currentTime) - 1

        let startsToday = currentTime >= startTime
        let endsToday = currentTime <= endTime
        
        if days[currentDay].active && (startsToday || endsToday || startTime > endTime) {
            if !isLocked {
                activateBlocking()
            }
        } else {
            if isLocked {
                deactivateBlocking()
            }
        }
    }

    private func activateBlocking() {
        let store = ManagedSettingsStore()
        store.shield.applications = activitySelection.applicationTokens
        store.shield.webDomains = activitySelection.webDomainTokens
        isLocked = true
    }

    private func deactivateBlocking() {
        let store = ManagedSettingsStore()
        store.shield.applications = nil
        store.shield.webDomains = nil
        isLocked = false
    }

    func toggleBlocking() {
        if isLocked {
            deactivateBlocking()
        } else {
            activateBlocking()
        }
    }
}
