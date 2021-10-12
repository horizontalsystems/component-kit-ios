import UIKit
import SnapKit

open class LeftCView: UIView {
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
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.font = .subhead2
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
