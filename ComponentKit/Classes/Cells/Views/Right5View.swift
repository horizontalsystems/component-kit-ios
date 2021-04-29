import UIKit
import SnapKit

open class Right5View: UIView {
    private let defaultTextColor: UIColor = .themeLeah

    private let button = UIButton()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(button)
        button.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.bottom.equalToSuperview()
        }

        button.titleLabel?.font = .subhead1
        button.setTitleColor(defaultTextColor, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(ComponentKit.image(named: "arrow_small_down_20"), for: .normal)
        button.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: .margin8 + .margin16, bottom: 0, right: .margin16)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -.margin8, bottom: 0, right: .margin8)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)

        button.isUserInteractionEnabled = false
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onTapButton() {
        onTap?()
    }

    public var onTap: (() -> ())? {
        didSet {
            button.isUserInteractionEnabled = onTap != nil
        }
    }

    public var text: String? {
        get { button.title(for: .normal) }
        set { button.setTitle(newValue, for: .normal) }
    }

    public var textColor: UIColor {
        get { button.titleColor(for: .normal) ?? defaultTextColor }
        set { button.setTitleColor(newValue, for: .normal) }
    }

}
