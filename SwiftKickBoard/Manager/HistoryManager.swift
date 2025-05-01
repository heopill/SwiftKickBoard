//
//  HistoryManager.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 5/1/25.
//

import Foundation
import UIKit

class HistoryManager {
    private let defaults = UserDefaults.standard
    
    private var stateData: Bool {
        get {
            defaults.bool(forKey: Key.state.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Key.state.rawValue)
        }
    }
    
    private var historyData: [[String]] {
        get {
            defaults.array(forKey: Key.history.rawValue) as? [[String]] ?? []
        }
        set {
            defaults.set(newValue, forKey: Key.history.rawValue)
        }
    }
    
    private enum Key: String {
        case state
        case history
    }
}

// MARK: - Method
extension HistoryManager {
    func updateState(upState: Bool) {
        self.stateData = upState
    }
    
    func fetchState() -> Bool {
        let state = stateData
        return state
    }
    
    func updateHistory(date: String, runTime: String) {
        var history = historyData
        history.append([date, runTime])
        self.historyData = history
    }
    
    func fetchHistory() -> [[String]] {
        let history = historyData
        return history
    }

}
