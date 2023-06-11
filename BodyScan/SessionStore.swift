//
//  SessionStore.swift
//  BodyScan
//
//  Created by Linus Skucas on 6/10/23.
//

import SwiftUI

class SessionStore: ObservableObject {
    @Published var promptingSessions = [UUID]()
    
    static var shared = SessionStore()
    
    func addSession(_ sessionID: UUID) {
        guard !promptingSessions.contains(sessionID) else { return }
        promptingSessions.append(sessionID)
    }
    
    func removeSession(_ sessionID: UUID) {
        promptingSessions.removeAll { $0 == sessionID }
    }
}
