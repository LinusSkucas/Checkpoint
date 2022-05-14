//
//  MailExtension.swift
//  BodyScan
//
//  Created by Linus Skucas on 5/13/22.
//

import MailKit

class MailExtension: NSObject, MEExtension {
    
    
    func handler(for session: MEComposeSession) -> MEComposeSessionHandler {
        // Create a unique instance, since each compose window is separate.
        return ComposeSessionHandler()
    }

    
}

