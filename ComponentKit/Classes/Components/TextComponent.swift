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
        case a1
        case a2
        case a3
        case a4
        case a5
        case a6
        case a7
        case a8
        case a9
        case a10
        case b1
        case b2
        case b3
        case b4
        case b5
        case b6
        case b7
        case b8
        case b9
        case b10
        case c1
        case c2
        case c3
        case c4
        case c5
        case c6
        case c7
        case c8
        case c9
        case c10
        case d1
        case d2
        case d3
        case d4
        case d5
        case d6
        case d7
        case d8
        case d9
        case d10
        case e1
        case e2
        case e3
        case e4
        case e5
        case e6
        case e7
        case e8
        case e9
        case e10
        case f1
        case f2
        case f3
        case f4
        case f5
        case f6
        case f7
        case f8
        case f9
        case f10

        var font: UIFont {
            switch self {
            case .a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8, .a9, .a10:
                return .headline2
            case .b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8, .b9, .b10:
                return .body
            case .c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9, .c10:
                return .subhead1
            case .d1, .d2, .d3, .d4, .d5, .d6, .d7, .d8, .d9, .d10:
                return .subhead2
            case .e1, .e2, .e3, .e4, .e5, .e6, .e7, .e8, .e9, .e10:
                return .captionSB
            case .f1, .f2, .f3, .f4, .f5, .f6, .f7, .f8, .f9, .f10:
                return .caption
            }
        }

        var textColor: UIColor {
            switch self {
            case .a1, .b1, .c1, .d1, .e1, .f1:
                return .themeGray
            case .a2, .b2, .c2, .d2, .e2, .f2:
                return .themeLeah
            case .a3, .b3, .c3, .d3, .e3, .f3:
                return .themeJacob
            case .a4, .b4, .c4, .d4, .e4, .f4:
                return .themeRemus
            case .a5, .b5, .c5, .d5, .e5, .f5:
                return .themeLucian
            case .a6, .b6, .c6, .d6, .e6, .f6:
                return .themeIssykBlue
            case .a7, .b7, .c7, .d7, .e7, .f7:
                return .themeGray50
            case .a8, .b8, .c8, .d8, .e8, .f8:
                return .themeYellow50
            case .a9, .b9, .c9, .d9, .e9, .f9:
                return .themeGreen50
            case .a10, .b10, .c10, .d10, .e10, .f10:
                return .themeRed50
            }
        }
    }

}

extension TextComponent {

    public static func height(width: CGFloat, style: Style, text: String) -> CGFloat {
        text.height(forContainerWidth: width, font: style.font)
    }

}
