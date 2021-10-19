import UIKit
import SnapKit

open class LeftDBView: UIView {
    private let label = UILabel()
    private let badgeView = BadgeView()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.font = .subhead2
        label.textColor = .themeGray

        addSubview(badgeView)
        badgeView.snp.makeConstraints { maker in
            maker.leading.equalTo(label.snp.trailing).offset(CGFloat.margin8)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }

    public var badgeText: String? {
        get { badgeView.text }
        set { badgeView.text = newValue }
    }

}
