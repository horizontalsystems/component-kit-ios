import UIKit
import ThemeKit
import SnapKit

public class PrimaryCircleButton: UIButton {

    public init() {
        super.init(frame: .zero)

        cornerRadius = 25

        setBackgroundColor(.themeSteel20, for: .disabled)

        snp.makeConstraints { maker in
            maker.size.equalTo(CGFloat.heightButton)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(image: UIImage?) {
        setImage(image?.withTintColor(.themeClaude), for: .normal)
        setImage(image?.withTintColor(.themeSteel20), for: .disabled)
    }

    public func set(style: Style) {
        switch style {
        case .yellow:
            setBackgroundColor(.themeYellowD, for: .normal)
            setBackgroundColor(.themeYellow50, for: .highlighted)
        case .red:
            setBackgroundColor(.themeLucian, for: .normal)
            setBackgroundColor(.themeRed50, for: .highlighted)
        case .gray:
            setBackgroundColor(.themeLeah, for: .normal)
            setBackgroundColor(.themeNina, for: .highlighted)
        }
    }

    public enum Style {
        case yellow
        case red
        case gray
    }

}
