import UIKit
import SnapKit

open class Right14View: UIView {
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(topLabel)
        topLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(13)
        }

        topLabel.textAlignment = .right
        topLabel.font = .body
        topLabel.textColor = .themeLeah

        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(topLabel.snp.bottom).offset(CGFloat.margin2)
        }

        bottomLabel.textAlignment = .right
        bottomLabel.font = .caption
        bottomLabel.textColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var topText: String? {
        get { topLabel.text }
        set { topLabel.text = newValue }
    }

    public var bottomText: String? {
        get { bottomLabel.text }
        set { bottomLabel.text = newValue }
    }

    public var bottomTextColor: UIColor {
        get { bottomLabel.textColor }
        set { bottomLabel.textColor = newValue }
    }

}
