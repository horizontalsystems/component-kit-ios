import UIKit
import ThemeKit
import SnapKit

public class PrimaryButton: UIButton {

    public init() {
        super.init(frame: .zero)

        cornerRadius = 25
        contentEdgeInsets = UIEdgeInsets(top: 0, left: .margin16, bottom: 0, right: .margin16)

        titleLabel?.font = .headline2

        setTitleColor(.themeGray50, for: .disabled)

        setBackgroundColor(.themeSteel20, for: .disabled)

        snp.makeConstraints { maker in
            maker.height.equalTo(CGFloat.heightButton)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(style: Style) {
        switch style {
        case .yellow:
            setTitleColor(.themeDark, for: .normal)
            setBackgroundColor(.themeYellowD, for: .normal)
            setBackgroundColor(.themeYellow50, for: .highlighted)
        case .red:
            setTitleColor(.themeClaude, for: .normal)
            setBackgroundColor(.themeLucian, for: .normal)
            setBackgroundColor(.themeRed50, for: .highlighted)
        case .gray:
            setTitleColor(.themeClaude, for: .normal)
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
