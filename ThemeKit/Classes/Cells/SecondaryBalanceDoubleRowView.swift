import UIKit
import UIExtensions
import SnapKit

open class SecondaryBalanceDoubleRowView: UIView {
    private let icon = UIImageView()
    private let coinValueLabel = UILabel()
    private let currencyValueLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        clipsToBounds = true

        addSubview(icon)
        icon.snp.makeConstraints { maker in
            maker.leading.bottom.equalToSuperview()
        }

        icon.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        addSubview(coinValueLabel)
        coinValueLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(icon.snp.trailing).offset(CGFloat.margin1x)
            maker.bottom.equalToSuperview()
        }

        coinValueLabel.font = .subhead2
        coinValueLabel.textColor = .themeGray

        addSubview(currencyValueLabel)
        currencyValueLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(coinValueLabel.snp.trailing).offset(CGFloat.margin2x)
            maker.trailing.bottom.equalToSuperview()
        }

        currencyValueLabel.font = .subhead1
        currencyValueLabel.textColor = .themeLeah
        currencyValueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    public func bind(image: UIImage?, coinValue: (text: String, dimmed: Bool)?, currencyValue: (text: String, dimmed: Bool)?, animated: Bool) {
        if let coinValue = coinValue {
            set(hidden: false, animated: animated, duration: CardCell.animationDuration)

            icon.image = image

            coinValueLabel.text = coinValue.text

            if let currencyValue = currencyValue {
                currencyValueLabel.text = currencyValue.text
            } else {
                currencyValueLabel.text = nil
            }
        } else {
            set(hidden: true, animated: animated, duration: CardCell.animationDuration)
        }
    }

}
