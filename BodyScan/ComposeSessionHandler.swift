//
//  ComposeSessionHandler.swift
//  BodyScan
//
//  Created by Linus Skucas on 5/13/22.
//

import MailKit
import SwiftUI

class ComposeSessionHandler: NSObject, MEComposeSessionHandler {
    
    let sessionStore = SessionStore.shared

    func mailComposeSessionDidBegin(_ session: MEComposeSession) {
        // Perform any setup necessary for handling the compose session.
        sessionStore.newSession(session.sessionID)
    }
    
    func mailComposeSessionDidEnd(_ session: MEComposeSession) {
        // Perform any cleanup now that the compose session is over.
        sessionStore.removeSession(session.sessionID)
    }

    // MARK: - Displaying Custom Compose Options

    func viewController(for session: MEComposeSession) -> MEExtensionViewController {
        let viewController = MEExtensionViewController()
        let rootView = ComposeSessionView(sessionID: session.sessionID).environmentObject(sessionStore)
        viewController.view = NSHostingView(rootView: rootView)
        return viewController
    }
    
    func allowMessageSendForSession(_ session: MEComposeSession, completion: @escaping (Error?) -> Void) {
        if sessionStore.shouldPromptForSession(session.sessionID) {
            let checkpointError = MEComposeSessionError(MEComposeSessionError.Code.invalidBody, userInfo: [NSLocalizedDescriptionKey: "Checkpoint! Confirm that you want to send this."])
            completion(checkpointError)
        } else {
            return completion(nil)
        }
    }
}

