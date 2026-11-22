import Foundation
import SwiftUI
import Testing
@testable import SproutSymbols

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

struct SymbolResourceTests {
    @Test("Every public symbol resolves to a native symbol asset", arguments: SproutSymbol.allCases)
    @MainActor
    func assetLoads(symbol: SproutSymbol) throws {
        #if canImport(UIKit)
        let image = try #require(UIImage(named: symbol.rawValue, in: .module, compatibleWith: nil))
        #expect(image.isSymbolImage)
        #elseif canImport(AppKit)
        let image = try #require(Bundle.module.image(forResource: symbol.rawValue))
        #expect(image.withSymbolConfiguration(.init(pointSize: 24, weight: .semibold)) != nil)
        #endif
    }

    @Test("SwiftUI renders visible pixels in both appearances", arguments: [ColorScheme.light, .dark])
    @MainActor
    func imageRenders(appearance: ColorScheme) throws {
        let renderer = ImageRenderer(content:
            Image(sprout: .roots)
                .font(.title.weight(.semibold))
                .foregroundStyle(.primary)
                .environment(\.colorScheme, appearance)
                .padding(8)
        )
        let image = try #require(renderer.cgImage)
        let width = image.width
        let height = image.height
        var pixels = [UInt8](repeating: 0, count: width * height * 4)
        let hasVisiblePixels = pixels.withUnsafeMutableBytes { bytes in
            guard let context = CGContext(
                data: bytes.baseAddress,
                width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4,
                space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            ) else { return false }
            context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
            return stride(from: 3, to: bytes.count, by: 4).contains { bytes[$0] > 0 }
        }
        #expect(hasVisiblePixels)
    }
}
