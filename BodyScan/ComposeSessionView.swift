//
//  ComposeSessionView.swift
//  BodyScan
//
//  Created by Linus Skucas on 6/10/23.
//

import SwiftUI

struct ComposeSessionView: View {
    @AppStorage(SessionStore.shouldDefaultToPromptingKey) var shouldDefaultToPrompting: Bool = false
    @EnvironmentObject var sessionStore: SessionStore
    @State var shouldWhitelistSession = true
    var sessionID: UUID
    
    var body: some View {
        VStack {
            Toggle(isOn: $shouldWhitelistSession) {
                ZStack {
                    Text("\(shouldWhitelistSession ? "Enable" : "Disable") Checkpoint")
                    Text("Disable Checkpoint")  // Make the button big enough so it doesn't clip
                        .hidden()
                }
            }
            .controlSize(.large)
            .toggleStyle(.button)
            .keyboardShortcut(.defaultAction)
            .padding(.bottom, 9)
            
            Spacer()
            
            Toggle(isOn: $shouldDefaultToPrompting) {
                Text("Enable by default")
            }
            .controlSize(.small)
        }
        .onAppear {
            if sessionStore.shouldPromptForSession(sessionID) {
                shouldWhitelistSession = false
            } else {
                shouldWhitelistSession = true
            }
        }
        .onChange(of: shouldWhitelistSession, perform: { newValue in
            if shouldWhitelistSession {
                sessionStore.addSession(sessionID)
            } else {
                sessionStore.removeSession(sessionID)
            }
        })
        .padding()
    }
}
