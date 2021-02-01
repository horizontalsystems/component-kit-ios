import UIKit
import SnapKit

open class Right14View: UIView {
    private let topLabel = UILabel()
    private let stackView = UIStackView()
    private let bottomLabel = UILabel()
    private let bottomTitleLabel = UILabel()

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

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(topLabel.snp.bottom).offset(CGFloat.margin2)
        }

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = .margin4

        stackView.addArrangedSubview(UIView())

        stackView.addArrangedSubview(bottomTitleLabel)
        bottomTitleLabel.font = .caption
        bottomTitleLabel.textColor = .themeJacob

        stackView.addArrangedSubview(bottomLabel)
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

    public var bottomTitleText: String? {
        get { bottomTitleLabel.text }
        set { bottomTitleLabel.text = newValue }
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
