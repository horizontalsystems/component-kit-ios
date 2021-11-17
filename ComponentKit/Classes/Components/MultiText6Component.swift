import UIKit
import SnapKit

public class MultiText6Component: UIView {
    public let title = TextComponent()
    public let imageLeft = ImageComponent()
    public let imageRight = ImageComponent()
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
            maker.leading.top.equalToSuperview()
        }

        title.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        container.addSubview(imageLeft)
        imageLeft.snp.makeConstraints { maker in
            maker.leading.equalTo(title.snp.trailing).offset(CGFloat.margin6)
            maker.centerY.equalTo(title)
        }

        container.addSubview(imageRight)
        imageRight.snp.makeConstraints { maker in
            maker.leading.equalTo(imageLeft.snp.trailing).offset(CGFloat.margin6)
            maker.trailing.equalToSuperview().priority(.medium)
            maker.centerY.equalTo(title)
        }

        container.addSubview(subtitle)
        subtitle.snp.makeConstraints { maker in
            maker.leading.bottom.trailing.equalToSuperview()
            maker.top.equalTo(title.snp.bottom).offset(3)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
