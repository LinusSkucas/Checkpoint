//
//  ComposeSessionHandler.swift
//  Checkpoint
//
//  Created by Linus Skucas on 12/18/21.
//

import MailKit
import SwiftUI

class SessionStore: ObservableObject {
    @Published var shouldPrompt = false
    
    static var shared = SessionStore()
}

struct CheckpointView: View {
    @AppStorage("shouldDefaultToBlocking") var shouldDefaultToBlocking: Bool = false
    @ObservedObject var session = SessionStore.shared
    
    var body: some View {
        VStack {
            Toggle(isOn: $session.shouldPrompt) {
                Text("\(session.shouldPrompt ? "Disable": "Enable") Checkpoint")
            }
            .controlSize(.large)
            .toggleStyle(.button)
            .keyboardShortcut(.defaultAction)
            
            Toggle(isOn: $shouldDefaultToBlocking) {
                Text("Enable by Default")
            }
            .controlSize(.small)
            .onAppear {
                if shouldDefaultToBlocking {
                    session.shouldPrompt = true
                }
            }
        }
        .padding()
        .frame(width: 175, height: 75)
    }
}

class ComposeSessionHandler: NSObject, MEComposeSessionHandler {
    func viewController(for session: MEComposeSession) -> MEExtensionViewController {
        let vc = MEExtensionViewController()
        vc.view = NSHostingView(rootView: CheckpointView())
        return vc
    }
    

    func mailComposeSessionDidBegin(_ session: MEComposeSession) {
        // Perform any setup necessary for handling the compose session.
    }
    
    func mailComposeSessionDidEnd(_ session: MEComposeSession) {
        // Perform any cleanup now that the compose session is over.
    }
        
    // MARK: - Confirming Message Delivery

    enum ComposeSessionError: LocalizedError {
        case checkpoint
        
        var errorDescription: String {
            switch self {
            case .checkpoint:
                return "Checkpoint! Do you really want to send this email?"
            }
        }
    }
    
    func allowMessageSendForSession(_ session: MEComposeSession) async throws {
        // Before Mail sends a message, your extension can validate the
        // contents of the compose session. If the message is ready to be sent,
        // call the compltion block with nil. If the message isn't ready to be
        // sent, call the completion with an error.
        
        if SessionStore.shared.shouldPrompt {
//            SessionStore.shared.shouldPrompt = false  // FIXME: Enable sending after first round
            throw ComposeSessionError.checkpoint
        }
    }
}

