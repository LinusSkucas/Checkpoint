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
                Text("\(shouldWhitelistSession ? "Enable" : "Disable") Checkpoint")
            }
            .controlSize(.large)
            .toggleStyle(.button)
            .keyboardShortcut(.defaultAction)
            
            Spacer()
            
            Toggle(isOn: $shouldDefaultToPrompting) {
                Text("Enable by Default")
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
        .frame(width: 175, height: 90)
    }
}
