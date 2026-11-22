import SwiftUI

/// Botanical symbols bundled with SproutSymbols.
public enum SproutSymbol: String, CaseIterable, Sendable {
    /// A branching root system with tapered, rounded roots.
    case roots

    /// A SwiftUI image that supports native symbol font, weight, scale, and tint.
    public var image: Image {
        Image(sprout: self)
    }

    var accessibilityTitle: LocalizedStringKey {
        switch self {
        case .roots: "Roots"
        }
    }
}
