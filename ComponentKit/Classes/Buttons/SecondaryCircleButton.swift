import UIKit
import ThemeKit
import SnapKit

open class SecondaryCircleButton: UIButton {
    public static let size: CGFloat = 28

    public init() {
        super.init(frame: .zero)

        cornerRadius = Self.size / 2

        setBackgroundColor(.themeSteel20, for: .normal)
        setBackgroundColor(.themeSteel10, for: .highlighted)
        setBackgroundColor(.themeSteel20, for: .disabled)

        snp.makeConstraints { maker in
            maker.size.equalTo(Self.size)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(image: UIImage?) {
        setImage(image?.withTintColor(.themeLeah), for: .normal)
        setImage(image?.withTintColor(.themeGray), for: .highlighted)
        setImage(image?.withTintColor(.themeGray50), for: .disabled)
        setImage(image?.withTintColor(.themeJacob), for: .selected)
        setImage(image?.withTintColor(.themeYellow50), for: [.selected, .highlighted])
    }

}
