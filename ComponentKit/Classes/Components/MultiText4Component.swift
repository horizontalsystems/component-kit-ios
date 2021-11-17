import UIKit
import SnapKit

public class MultiText4Component: UIView {
    public let title = TextComponent()
    public let badge = BadgeView()
    public let subtitleLeft = TextComponent()
    public let subtitleRight = TextComponent()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        let container = UIView()

        addSubview(container)
        container.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        container.addSubview(title)
        title.snp.makeConstraints { maker in
            maker.leading.top.equalToSuperview()
        }

        title.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        container.addSubview(badge)
        badge.snp.makeConstraints { maker in
            maker.leading.equalTo(title.snp.trailing).offset(CGFloat.margin6)
            maker.trailing.equalToSuperview().priority(.medium)
            maker.centerY.equalTo(title)
        }

        container.addSubview(subtitleLeft)
        subtitleLeft.snp.makeConstraints { maker in
            maker.leading.bottom.equalToSuperview()
            maker.top.equalTo(title.snp.bottom).offset(3)
        }

        subtitleLeft.setContentHuggingPriority(.required, for: .horizontal)

        container.addSubview(subtitleRight)
        subtitleRight.snp.makeConstraints { maker in
            maker.leading.equalTo(subtitleLeft.snp.trailing).offset(CGFloat.margin4)
            maker.trailing.bottom.equalToSuperview()
            maker.top.equalTo(subtitleLeft)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
