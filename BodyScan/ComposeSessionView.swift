//
//  ComposeSessionView.swift
//  BodyScan
//
//  Created by Linus Skucas on 6/10/23.
//

import SwiftUI

struct ComposeSessionView: View {
    @AppStorage("shouldDefaultToPrompting") var shouldDefaultToPrompting: Bool = false
    @EnvironmentObject var sessionStore: SessionStore
    @State var shouldPrompt = false
    var sessionID: UUID
    
    var body: some View {
        VStack {
            Toggle(isOn: $shouldPrompt) {
                Text("\(shouldPrompt ? "Disable" : "Enable") Checkpoint")
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
            if shouldDefaultToPrompting {
                sessionStore.addSession(sessionID)
            }
            
            if sessionStore.promptingSessions.contains(sessionID) {
                shouldPrompt = true
            }
        }
        .onChange(of: shouldPrompt, perform: { newValue in
            if shouldPrompt {
                sessionStore.addSession(sessionID)
            } else {
                sessionStore.removeSession(sessionID)
            }
        })
        .padding()
        .frame(width: 175, height: 90)
    }
}
