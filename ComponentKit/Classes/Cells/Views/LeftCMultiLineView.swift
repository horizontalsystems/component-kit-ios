import UIKit
import SnapKit

open class LeftCMultiLineView: UIView {
    private static let font: UIFont = .subhead2

    private let imageButton = ThemeButton()
    private let label = UILabel()

    public var imageAction: (() -> ())? {
        didSet {
            imageButton.isUserInteractionEnabled = imageAction != nil
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageButton)
        imageButton.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.bottom.equalToSuperview()
            maker.width.equalTo(CGFloat.margin16 + CGFloat.iconSize20 + CGFloat.margin16)
        }

        imageButton.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        imageButton.isUserInteractionEnabled = false

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.equalTo(imageButton.snp.trailing)
            maker.top.trailing.bottom.equalToSuperview()
        }

        label.numberOfLines = 0
        label.font = Self.font
        label.textColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onTapButton() {
        imageAction?()
    }

    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }

    public var image: UIImage? {
        get { imageButton.image(for: .normal) }
        set { imageButton.setImage(newValue, for: .normal) }
    }

}

extension LeftCMultiLineView {

    public static func height(containerWidth: CGFloat, text: String) -> CGFloat {
        let textWidth = containerWidth - CGFloat.margin16 - CGFloat.iconSize20 - CGFloat.margin16
        let textHeight = text.height(forContainerWidth: textWidth, font: font)
        return textHeight + 31
    }

}
