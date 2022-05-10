import UIKit
import SnapKit

public class TextComponent: UILabel {

    public func set(style: Style) {
        font = style.font
        textColor = style.textColor
    }

}

extension TextComponent {

    public enum Style {
        case a1, a2, a3, a4, a5, a6, a7, a8, a9, a10
        case b1, b2, b3, b4, b5, b6, b7, b8, b9, b10
        case c1, c2, c3, c4, c5, c6, c7, c8, c9, c10
        case d1, d2, d3, d4, d5, d6, d7, d8, d9, d10
        case e1, e2, e3, e4, e5, e6, e7, e8, e9, e10
        case f1, f2, f3, f4, f5, f6, f7, f8, f9, f10
        case g1, g2, g3, g4, g5, g6, g7, g8, g9, g10
        case h1, h2, h3, h4, h5, h6, h7, h8, h9, h10

        var font: UIFont {
            switch self {
            case .a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8, .a9, .a10: return .headline2
            case .b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8, .b9, .b10: return .body
            case .c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9, .c10: return .subhead1
            case .d1, .d2, .d3, .d4, .d5, .d6, .d7, .d8, .d9, .d10: return .subhead2
            case .e1, .e2, .e3, .e4, .e5, .e6, .e7, .e8, .e9, .e10: return .captionSB
            case .f1, .f2, .f3, .f4, .f5, .f6, .f7, .f8, .f9, .f10: return .caption
            case .g1, .g2, .g3, .g4, .g5, .g6, .g7, .g8, .g9, .g10: return .subhead1I
            case .h1, .h2, .h3, .h4, .h5, .h6, .h7, .h8, .h9, .h10: return .title3
            }
        }

        var textColor: UIColor {
            switch self {
            case .a1, .b1, .c1, .d1, .e1, .f1, .g1, .h1: return .themeGray
            case .a2, .b2, .c2, .d2, .e2, .f2, .g2, .h2: return .themeLeah
            case .a3, .b3, .c3, .d3, .e3, .f3, .g3, .h3: return .themeJacob
            case .a4, .b4, .c4, .d4, .e4, .f4, .g4, .h4: return .themeRemus
            case .a5, .b5, .c5, .d5, .e5, .f5, .g5, .h5: return .themeLucian
            case .a6, .b6, .c6, .d6, .e6, .f6, .g6, .h6: return .themeIssykBlue
            case .a7, .b7, .c7, .d7, .e7, .f7, .g7, .h7: return .themeGray50
            case .a8, .b8, .c8, .d8, .e8, .f8, .g8, .h8: return .themeYellow50
            case .a9, .b9, .c9, .d9, .e9, .f9, .g9, .h9: return .themeGreen50
            case .a10, .b10, .c10, .d10, .e10, .f10, .g10, .h10: return .themeRed50
            }
        }
    }

}

extension TextComponent {

    public static func height(width: CGFloat, style: Style, text: String) -> CGFloat {
        text.height(forContainerWidth: width, font: style.font)
    }

}
