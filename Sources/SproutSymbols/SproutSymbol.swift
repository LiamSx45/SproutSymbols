import SwiftUI

/// Botanical symbols bundled with SproutSymbols.
public enum SproutSymbol: String, CaseIterable, Sendable {
    /// A branching root system with tapered, rounded roots.
    case roots
    /// A tapered nursery pot with a broad rim and drainage ribs.
    case pot
    /// A climbing vine wrapped around a moss or coir support pole.
    case mossPole = "moss.pole"
    /// Rounded porous clay aggregate used in semi-hydroponic growing.
    case leca

    /// A SwiftUI image that supports native symbol font, weight, scale, and tint.
    public var image: Image {
        Image(sprout: self)
    }

    var accessibilityTitle: LocalizedStringKey {
        switch self {
        case .roots: "Roots"
        case .pot: "Pot"
        case .mossPole: "Moss pole"
        case .leca: "LECA"
        }
    }
}
