import UIKit
import UIExtensions
import SnapKit

open class BalanceDoubleRowView: UIView {
    private let coinValueLabel = UILabel()
    private let currencyValueLabel = UILabel()

    public init() {
        super.init(frame: .zero)

        addSubview(coinValueLabel)
        coinValueLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(CGFloat.margin1x)
            maker.top.equalToSuperview().offset(11)
        }

        coinValueLabel.font = .subhead2
        coinValueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        addSubview(currencyValueLabel)
        currencyValueLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(coinValueLabel.snp.trailing).offset(CGFloat.margin2x)
            maker.trailing.equalToSuperview().inset(CGFloat.margin1x)
            maker.bottom.equalTo(coinValueLabel.snp.bottom)
        }

        currencyValueLabel.font = .headline2
        currencyValueLabel.textAlignment = .right
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    public func bind(coinValue: (text: String?, dimmed: Bool), currencyValue: (text: String?, dimmed: Bool)?, animated: Bool = false, duration: TimeInterval = 0.2) {
        coinValueLabel.text = coinValue.text
        coinValueLabel.textColor = coinValue.dimmed ? .themeGray50 : .themeLeah

        if let currencyValue = currencyValue {
            currencyValueLabel.set(hidden: false, animated: animated, duration: duration)
            currencyValueLabel.text = currencyValue.text
            currencyValueLabel.textColor = currencyValue.dimmed ? .themeYellow50 : .themeJacob
        } else {
            currencyValueLabel.set(hidden: true, animated: animated, duration: duration)
        }
    }

}
