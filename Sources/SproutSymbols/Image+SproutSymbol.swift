import SwiftUI

public extension Image {
    /// Loads a custom symbol from this package's resource bundle.
    ///
    /// Use standard SwiftUI modifiers to set the font, weight, scale, and color.
    /// Override `accessibilityLabel(_:)` when the image represents a more specific
    /// action, or use it inside a `Label` to provide visible, localized text.
    init(sprout symbol: SproutSymbol) {
        self = Image(
            symbol.rawValue,
            bundle: .module,
            label: Text(symbol.accessibilityTitle, bundle: .module)
        ).renderingMode(.template)
    }
}
