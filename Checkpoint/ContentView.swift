//
//  ContentView.swift
//  Checkpoint
//
//  Created by Linus Skucas on 5/13/22.
//

import SwiftUI

struct ContentView: View {
    let mailIcon = NSWorkspace.shared.icon(forFile: "/System/Applications/Mail.app")
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Welcome to")
                Text("Checkpoint")
                    .foregroundColor(.red)
                    .fontWeight(.bold)
            }
            .font(.system(.largeTitle, design: .rounded))
            
            Spacer()
            
            GroupBox {
                VStack(alignment: .symbolInstructionAlignmentGuide) {
                    InstructionView(image: Image(nsImage: mailIcon), instructionText: "Open **Mail**")
                    InstructionView(symbol: "puzzlepiece", instructionText: "In **Settings**, select **Extensions**")
                    InstructionView(symbol: "checkmark", instructionText: "Enable **Checkpoint**")
                }
            } label: {
                Text("To get started:")
                    .textCase(.uppercase)
                    .foregroundColor(.secondary)
                    .font(.callout)
            }
        }
        .padding()
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct InstructionView: View {
    var symbol: Image
    var instructionText: String
    
    init(image: Image, instructionText: String) {
        self.symbol = image
        self.instructionText = instructionText
    }
    
    init(symbol: String, instructionText: String) {
        self.symbol = Image(systemName: symbol)
        self.instructionText = instructionText
    }
    
    var body: some View {
        HStack(alignment: .center) {  // TODO: Fix the alignment of symbols and text (text should align with other text and symbols align with other symbols)
            symbol
                .font(.title)  // TODO: Add color to the symbols
                .alignmentGuide(.symbolInstructionAlignmentGuide) { context in
                    context[HorizontalAlignment.center]
                }
            Text(.init(instructionText))
        }
        .padding(.bottom, 5)  // FIXME: More space between mail icon and other symbols
    }
}

extension HorizontalAlignment {
    private struct SymbolInstructionAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.leading]
        }
    }
    
    private struct SymbolAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    
    static let symbolInstructionAlignmentGuide = HorizontalAlignment(SymbolInstructionAlignment.self)
    static let symbolAlignmentGuide = HorizontalAlignment(SymbolAlignment.self)
}
