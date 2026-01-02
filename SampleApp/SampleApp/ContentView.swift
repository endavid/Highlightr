//
//  ContentView.swift
//  SampleApp
//
//  Created by David Gavilan Ruiz on 25/01/2024.
//

import SwiftUI
import Highlightr

struct ContentView: View {
    @State private var textA: NSAttributedString
    @State private var textB: NSAttributedString

    init() {
        let highlightr = Highlightr()!
        highlightr.setTheme(to: "pojoaque")
        let fontSize: CGFloat = 8
        highlightr.theme.codeFont = highlightr.theme.codeFont.withSize(fontSize)
        highlightr.theme.boldCodeFont = highlightr.theme.boldCodeFont.withSize(fontSize)
        highlightr.theme.italicCodeFont = highlightr.theme.italicCodeFont.withSize(fontSize)
        let codeA = """
// Comments may look the wrong font with certain styles
// like pojoaque, which it's the default, sadly
let a = 42
let b = "This is a string"
"""
        // You can omit the second parameter to use automatic language detection.
        textA = highlightr.highlight(codeA, as: "swift")!
        let codeB = """
/// This is a Metal Shader example
fragment half4 main()
{
    float pi = 3.1416;
    float2 uv = frag.uv;
    float4 a = texA.sample(sam, uv);
    int2 dummy = int2(0, 1);
    return half4(a);
}
"""
        textB = highlightr.highlight(codeB, as: "cpp")!
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            AttributedText(attributedString: textA)
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            AttributedText(attributedString: textB)
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
