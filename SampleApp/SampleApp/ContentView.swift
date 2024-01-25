//
//  ContentView.swift
//  SampleApp
//
//  Created by David Gavilan Ruiz on 25/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var text: NSAttributedString
    
    init() {
        let highlightr = Highlightr()!
        highlightr.setTheme(to: "railscasts")
        let fontSize: CGFloat = 12
        highlightr.theme.codeFont = highlightr.theme.codeFont.withSize(fontSize)
        highlightr.theme.boldCodeFont = highlightr.theme.boldCodeFont.withSize(fontSize)
        highlightr.theme.italicCodeFont = highlightr.theme.italicCodeFont.withSize(fontSize)
        let code = """
// Comments may look the wrong font with certain styles
// like pojoaque, which it's the default, sadly
let a = 42
let b = "This is a string"
"""
        // You can omit the second parameter to use automatic language detection.
        text = highlightr.highlight(code, as: "swift")!
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            AttributedText(attributedString: text)
        }
        .padding()
    }
}

// https://stackoverflow.com/a/70444050/1765629
@available(OSX 11.0, *)
public struct AttributedText: NSViewRepresentable {
    private let text: NSAttributedString
    
    public init(attributedString: NSAttributedString) {
        text = attributedString
    }
    
    public func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField(labelWithAttributedString: text)
        textField.isSelectable = true
        textField.allowsEditingTextAttributes = true // Fix of clear of styles on click
        
        textField.preferredMaxLayoutWidth = textField.frame.width
        
        return textField
    }
    
    public func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.attributedStringValue = text
    }
}

#Preview {
    ContentView()
}
