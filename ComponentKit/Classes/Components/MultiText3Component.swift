import UIKit
import SnapKit

public class MultiText3Component: UIView {
    public let title = TextComponent()
    public let badge = BadgeView()
    public let subtitle = TextComponent()

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
            maker.leading.top.trailing.equalToSuperview()
        }

        container.addSubview(badge)
        badge.snp.makeConstraints { maker in
            maker.leading.bottom.equalToSuperview()
            maker.top.equalTo(title.snp.bottom).offset(4)
        }

        container.addSubview(subtitle)
        subtitle.snp.makeConstraints { maker in
            maker.leading.equalTo(badge.snp.trailing).offset(CGFloat.margin8)
            maker.trailing.bottom.equalToSuperview()
            maker.centerY.equalTo(badge)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
