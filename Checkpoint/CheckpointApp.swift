//
//  CheckpointApp.swift
//  Checkpoint
//
//  Created by Linus Skucas on 5/13/22.
//

import SwiftUI

@main
struct CheckpointApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 300, maxWidth: 320, minHeight:450, maxHeight: 470)
        }
        .windowResizabilityContentSize()
    }
}

extension Scene {
    func windowResizabilityContentSize() -> some Scene {
        if #available(macOS 13.0, *) {
            return windowResizability(.contentSize)
        } else {
            return self
        }
    }
}
