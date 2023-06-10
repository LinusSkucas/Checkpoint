//
//  ComposeSessionHandler.swift
//  BodyScan
//
//  Created by Linus Skucas on 5/13/22.
//

import MailKit
import SwiftUI

class ComposeSessionHandler: NSObject, MEComposeSessionHandler {

    func mailComposeSessionDidBegin(_ session: MEComposeSession) {
        // Perform any setup necessary for handling the compose session.
    }
    
    func mailComposeSessionDidEnd(_ session: MEComposeSession) {
        // Perform any cleanup now that the compose session is over.
    }

    // MARK: - Displaying Custom Compose Options

    func viewController(for session: MEComposeSession) -> MEExtensionViewController {
        let viewController = MEExtensionViewController()
        viewController.view = NSHostingView(rootView: Text("Hello, World!"))
        return viewController
    }
    
    func allowMessageSendForSession(_ session: MEComposeSession, completion: @escaping (Error?) -> Void) {
        let checkpointError = MEComposeSessionError(MEComposeSessionError.Code.invalidBody, userInfo: [NSLocalizedDescriptionKey: "Checkpoint! Confirm that you want to send this."])
        completion(checkpointError)
    }
}

