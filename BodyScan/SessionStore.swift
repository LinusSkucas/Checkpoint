//
//  SessionStore.swift
//  BodyScan
//
//  Created by Linus Skucas on 6/10/23.
//

import SwiftUI

class SessionStore: ObservableObject {
    var whitelistedSessions = [UUID]()
    
    static var shared = SessionStore()
    static let shouldDefaultToPromptingKey = "shouldDefaultToPrompting"
    
    /// When a new session is started, determine what to do to it
    /// If Checkpoint is not autoenabled, the session will be added to the whitelist
    func newSession(_ sessionID: UUID) {
        guard !UserDefaults.standard.bool(forKey: Self.shouldDefaultToPromptingKey) else { return }
        addSession(sessionID)
    }
    
    func addSession(_ sessionID: UUID) {
        guard !whitelistedSessions.contains(sessionID) else { return }
        whitelistedSessions.append(sessionID)
    }
    
    func removeSession(_ sessionID: UUID) {
        whitelistedSessions.removeAll { $0 == sessionID }
    }
    
    /// Determine if Checkpoint should stop the message.
    /// Checks if the session exists in the whitelist. If it does not, Checkpoint should prompt.
    func shouldPromptForSession(_ sessionID: UUID) -> Bool {
        return !whitelistedSessions.contains(sessionID)
    }
}
