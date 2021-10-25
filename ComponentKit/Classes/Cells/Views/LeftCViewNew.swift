import UIKit
import SnapKit

extension LeftCViewNew {
    public enum Style {
        case bodyOz
        case subhead2Grey
    }
}

open class LeftCViewNew: UIView {
    private let imageButton = ThemeButton()
    private let label = UILabel()

    public var imageAction: (() -> ())? {
        didSet {
            imageButton.isUserInteractionEnabled = imageAction != nil
        }
    }

    override public init(frame: CGRect) {
        style = .bodyOz

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
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.textColor = .themeGray
        label.lineBreakMode = .byTruncatingMiddle
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onTapButton() {
        imageAction?()
    }

    public var style: Style {
        didSet {
            switch style {
            case .bodyOz:
                label.font = .body
            case .subhead2Grey:
                label.font = .subhead2
            }
        }
    }

    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }

    public var lineBreakMode: NSLineBreakMode {
        get { label.lineBreakMode }
        set { label.lineBreakMode = newValue }
    }

    public var image: UIImage? {
        get { imageButton.image(for: .normal) }
        set { imageButton.setImage(newValue, for: .normal) }
    }

}
