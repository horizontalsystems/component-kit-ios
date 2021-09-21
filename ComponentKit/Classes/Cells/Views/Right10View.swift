import UIKit
import SnapKit

open class Right10View: UIView {
    private let button = CopyableSecondaryButton()
    private let iconButton = ThemeButton()

    public var onTapIconButton: (() -> ())?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(button)
        button.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        addSubview(iconButton)
        iconButton.snp.makeConstraints { maker in
            maker.leading.equalTo(button.snp.trailing).offset(CGFloat.margin8)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        iconButton.apply(style: .secondaryIcon)
        iconButton.addTarget(self, action: #selector(_onTapIconButton), for: .touchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func _onTapIconButton() {
        onTapIconButton?()
    }

    public var viewItem: CopyableSecondaryButton.ViewItem {
        get { button.viewItem }
        set { button.viewItem = newValue }
    }

    public func set(iconButtonImage: UIImage?) {
        iconButton.setImage(iconButtonImage, for: .normal)
    }

}
