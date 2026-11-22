import SwiftUI

public extension Image {
    /// Loads a custom symbol from this package's resource bundle.
    ///
    /// Use standard SwiftUI modifiers to set the font, weight, scale, and color.
    /// Override `accessibilityLabel(_:)` when the image represents a more specific
    /// action, or use it inside a `Label` to provide visible, localized text.
    /// Pass a value from 0 through 1 to progressively emphasize the symbol's layers.
    /// Leave it `nil` to display all layers normally. The native rendering mode is
    /// left configurable through `symbolRenderingMode(_:)`.
    init(sprout symbol: SproutSymbol, variableValue: Double? = nil) {
        self.init(
            symbol.rawValue,
            variableValue: variableValue,
            bundle: .module,
            label: Text(symbol.accessibilityTitle, bundle: .module)
        )
    }
}
