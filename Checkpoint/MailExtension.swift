//
//  MailExtension.swift
//  Checkpoint
//
//  Created by Linus Skucas on 12/18/21.
//

import MailKit

class MailExtension: NSObject, MEExtension {
    
    
    func handler(for session: MEComposeSession) -> MEComposeSessionHandler {
        // Create a unique instance, since each compose window is separate.
        return ComposeSessionHandler()
    }

    
}

