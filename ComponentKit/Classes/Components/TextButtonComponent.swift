import UIKit
import SnapKit

public class TextButtonComponent: UIButton {
    public var onTap: (() -> ())?

    public init() {
        super.init(frame: .zero)

        addTarget(self, action: #selector(_onTap), for: .touchUpInside)
    }

    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var intrinsicContentSize: CGSize {
        titleLabel?.intrinsicContentSize ?? super.intrinsicContentSize
    }

    @objc private func _onTap() {
        onTap?()
    }

    public var font: UIFont? {
        get { titleLabel?.font }
        set { titleLabel?.font = newValue }
    }

    public var textColor: UIColor? {
        get { titleColor(for: .normal) }
        set { setTitleColor(newValue, for: .normal) }
    }

    public var text: String? {
        get { title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }

}

extension TextButtonComponent {

    public static func height(width: CGFloat, font: UIFont, text: String) -> CGFloat {
        text.height(forContainerWidth: width, font: font)
    }

    public static func width(font: UIFont, text: String) -> CGFloat {
        text.size(containerWidth: CGFloat.greatestFiniteMagnitude, font: font).width
    }

}
