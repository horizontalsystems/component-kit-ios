import UIKit
import SnapKit

open class LeftGRankedView: UIView {
    private let imageView = UIImageView()
    private let topLabel = UILabel()
    private let rankView = BadgeView()
    private let bottomLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)

        addSubview(topLabel)
        topLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(CGFloat.margin16)
            maker.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(10)
        }

        topLabel.font = .body
        topLabel.textColor = .themeOz

        addSubview(rankView)
        rankView.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(CGFloat.margin16)
            maker.top.equalTo(topLabel.snp.bottom).offset(CGFloat.margin6)
        }

        rankView.font = .microSB

        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(rankView.snp.trailing).offset(CGFloat.margin8)
            maker.trailing.equalToSuperview()
            maker.centerY.equalTo(rankView)
        }

        bottomLabel.font = .subhead2
        bottomLabel.textColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    public var topText: String? {
        get { topLabel.text }
        set { topLabel.text = newValue }
    }

    public var rankText: String? {
        get { rankView.text }
        set { rankView.text = newValue }
    }

    public var rankTextColor: UIColor {
        get { rankView.textColor }
        set { rankView.textColor = newValue }
    }

    public var rankBackgroundColor: UIColor? {
        get { rankView.backgroundColor }
        set { rankView.backgroundColor = newValue }
    }

    public var bottomText: String? {
        get { bottomLabel.text }
        set { bottomLabel.text = newValue }
    }

}
