import UIKit
import SnapKit

open class Right23View: UIView {
    private let stackView = UIStackView()
    private let topLabel = UILabel()
    private let leftImageView = UIImageView()
    private let rightImageView = UIImageView()
    private let bottomLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(10)
        }

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        stackView.setContentHuggingPriority(.required, for: .horizontal)

        stackView.addArrangedSubview(topLabel)
        topLabel.textAlignment = .right
        topLabel.font = .body
        topLabel.textColor = .themeLeah
        topLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        stackView.addArrangedSubview(leftImageView)
        leftImageView.snp.makeConstraints { maker in
            maker.size.equalTo(CGFloat.iconSize20)
        }
        leftImageView.isHidden = true

        stackView.addArrangedSubview(rightImageView)
        rightImageView.snp.makeConstraints { maker in
            maker.size.equalTo(CGFloat.iconSize20)
        }
        rightImageView.isHidden = true

        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().inset(10)
        }

        bottomLabel.textAlignment = .right
        bottomLabel.font = .subhead2
        bottomLabel.textColor = .themeGray
        bottomLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var topText: String? {
        get { topLabel.text }
        set { topLabel.text = newValue }
    }

    public var topTextColor: UIColor {
        get { topLabel.textColor }
        set { topLabel.textColor = newValue }
    }

    public var leftIconImage: UIImage? {
        get { leftImageView.image }
        set {
            leftImageView.image = newValue
            leftImageView.isHidden = newValue == nil
        }
    }

    public var leftIconTinColor: UIColor {
        get { leftImageView.tintColor }
        set { leftImageView.tintColor = newValue }
    }

    public var rightIconImage: UIImage? {
        get { rightImageView.image }
        set {
            rightImageView.image = newValue
            rightImageView.isHidden = newValue == nil
        }
    }

    public var rightIconTinColor: UIColor {
        get { rightImageView.tintColor }
        set { rightImageView.tintColor = newValue }
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
