import UIKit
import SnapKit

public class MultiText2Component: UIView {
    public let title = TextComponent()
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
            maker.leading.top.trailing.equalToSuperview()
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
