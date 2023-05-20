import SwiftUI

// Struct for each color palette in Lila's wardrobe
struct clothPalette: Hashable {
    let colors: [Color]
    let description: String
    let endMessage: String
}
