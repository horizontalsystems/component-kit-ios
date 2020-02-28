import UIKit
import UIExtensions
import SnapKit

open class BalanceDoubleRowView: UIView {
    private let coinValueLabel = UILabel()
    private let currencyValueLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(coinValueLabel)
        coinValueLabel.snp.makeConstraints { maker in
            maker.leading.top.equalToSuperview().offset(CGFloat.margin3x)
            maker.bottom.equalToSuperview()
        }

        coinValueLabel.font = .subhead2
        coinValueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        addSubview(currencyValueLabel)
        currencyValueLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(coinValueLabel.snp.trailing).offset(CGFloat.margin2x)
            maker.trailing.equalToSuperview().inset(CGFloat.margin3x)
            maker.bottom.equalTo(coinValueLabel.snp.bottom)
        }

        currencyValueLabel.font = .headline2
        currencyValueLabel.textAlignment = .right
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    public func bind(coinValue: (text: String, dimmed: Bool)?, currencyValue: (text: String, dimmed: Bool)?, animated: Bool) {
        if let coinValue = coinValue {
            coinValueLabel.set(hidden: false, animated: animated, duration: CardCell.animationDuration)
            coinValueLabel.text = coinValue.text
            coinValueLabel.textColor = coinValue.dimmed ? .themeGray50 : .themeLeah
        } else {
            coinValueLabel.set(hidden: true, animated: animated, duration: CardCell.animationDuration)
        }

        if let currencyValue = currencyValue {
            currencyValueLabel.set(hidden: false, animated: animated, duration: CardCell.animationDuration)
            currencyValueLabel.text = currencyValue.text
            currencyValueLabel.textColor = currencyValue.dimmed ? .themeYellow50 : .themeJacob
        } else {
            currencyValueLabel.set(hidden: true, animated: animated, duration: CardCell.animationDuration)
        }
    }

}
