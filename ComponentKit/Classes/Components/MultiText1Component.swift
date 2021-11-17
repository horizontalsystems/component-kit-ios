import UIKit
import SnapKit

public class MultiText1Component: UIView {
    public let title = TextComponent()
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
