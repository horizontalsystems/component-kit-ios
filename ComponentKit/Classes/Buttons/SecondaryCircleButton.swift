import UIKit
import ThemeKit
import SnapKit

public class SecondaryCircleButton: UIButton {

    public init() {
        super.init(frame: .zero)

        cornerRadius = 14

        setBackgroundColor(.themeSteel20, for: .normal)

        snp.makeConstraints { maker in
            maker.size.equalTo(28)
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
