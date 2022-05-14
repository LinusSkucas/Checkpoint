//
//  ComposeSessionHandler.swift
//  BodyScan
//
//  Created by Linus Skucas on 5/13/22.
//

import MailKit

class ComposeSessionHandler: NSObject, MEComposeSessionHandler {

    func mailComposeSessionDidBegin(_ session: MEComposeSession) {
        // Perform any setup necessary for handling the compose session.
    }
    
    func mailComposeSessionDidEnd(_ session: MEComposeSession) {
        // Perform any cleanup now that the compose session is over.
    }
    
    // MARK: - Annotating Address Tokens

    func annotateAddressesForSession(_ session: MEComposeSession) async -> [MEEmailAddress: MEAddressAnnotation] {
        var annotations: [MEEmailAddress: MEAddressAnnotation] = [:]
        
        // Iterate through all the receipients in the message.
        //
        // NOTE: If there isn't any definitive information we can provide about
        // the address, don't add an annotation for it.
        for address in session.mailMessage.allRecipientAddresses {
            // If the address ends in @example.com, indicate that's an error.
            if address.rawString.hasSuffix("@example.com") {
                // Create an address annotation that Mail shows in the address token.
                let message = "example.com is not a valid domain"
                let annotation = MEAddressAnnotation.error(withLocalizedDescription: message)
                
                // Add the annotation to the results dictionary.
                annotations[address] = annotation
            }
        }
        
        // Call the Completion handler with the results.
        return annotations
    }

    // MARK: - Displaying Custom Compose Options

    func viewController(for session: MEComposeSession) -> MEExtensionViewController {
        return ComposeSessionViewController(nibName: "ComposeSessionViewController", bundle: Bundle.main)
    }
    
    // MARK: - Adding Custom Headers

    func additionalHeaders(for session: MEComposeSession) -> [String : [String]] {
        // To insert custom headers into a message, return a dictionary with
        // the key and an array of one or more values.
        return ["X-CustomHeader": ["This ia a custom header."]]
    }
    
    // MARK: - Confirming Message Delivery

    enum ComposeSessionError: LocalizedError {
        case invalidRecipientDomain
        
        var errorDescription: String? {
            switch self {
            case .invalidRecipientDomain:
                return "example.com is not a valid recipient domain"
            }
        }
    }
    
    func allowMessageSendForSession(_ session: MEComposeSession, completion: @escaping (Error?) -> Void) {
        // Before Mail sends a message, your extension can validate the
        // contents of the compose session. If the message is ready to be sent,
        // call the compltion block with nil. If the message isn't ready to be
        // sent, call the completion with an error.
        if session.mailMessage.allRecipientAddresses.contains(where: { $0.rawString.hasSuffix("@example.com")}) {
            completion(ComposeSessionError.invalidRecipientDomain)
        } else {
            completion(nil)
        }
    }
}

