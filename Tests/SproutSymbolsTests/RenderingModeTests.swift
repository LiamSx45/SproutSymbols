import Foundation
import SwiftUI
import Testing
import SproutSymbols

@MainActor
struct RenderingModeTests {
    @Test("Each rendering mode has distinct layer output", arguments: SproutSymbol.allCases)
    func renderingModes(symbol: SproutSymbol) throws {
        let modes: [SymbolRenderingMode] = [.monochrome, .hierarchical, .palette, .multicolor]
        let outputs = try modes.map { mode in
            try pixels(of: Image(sprout: symbol)
                .symbolRenderingMode(mode)
                .foregroundStyle(.red, .green, .blue))
        }
        #expect(Set(outputs).count == 4)
    }

    @Test("Variable color responds at low, middle, and full values", arguments: SproutSymbol.allCases)
    func variableColor(symbol: SproutSymbol) throws {
        let outputs = try [0.0, 0.5, 1.0].map { value in
            try pixels(of: Image(sprout: symbol, variableValue: value)
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(.brown))
        }
        #expect(Set(outputs).count == 3)
    }

    @Test("Native gradients change the rendered image", arguments: SproutSymbol.allCases)
    func gradients(symbol: SproutSymbol) throws {
        if #available(iOS 26, macOS 26, *) {
            let flat = try pixels(of: Image(sprout: symbol)
                .symbolRenderingMode(.multicolor)
                .symbolColorRenderingMode(.flat))
            let gradient = try pixels(of: Image(sprout: symbol)
                .symbolRenderingMode(.multicolor)
                .symbolColorRenderingMode(.gradient))
            #expect(flat != gradient)
        }
    }

    private func pixels(of content: some View) throws -> Data {
        let renderer = ImageRenderer(content: content
            .font(.system(size: 80))
            .frame(width: 140, height: 140)
            .environment(\.colorScheme, .light))
        let image = try #require(renderer.cgImage)
        return try #require(image.dataProvider?.data) as Data
    }
}
