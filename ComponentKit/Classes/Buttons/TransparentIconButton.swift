import UIKit
import ThemeKit
import SnapKit

open class TransparentIconButton: UIButton {

    public init() {
        super.init(frame: .zero)

        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .horizontal)

        contentEdgeInsets = UIEdgeInsets(top: 0, left: .margin12, bottom: 0, right: .margin12)
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
