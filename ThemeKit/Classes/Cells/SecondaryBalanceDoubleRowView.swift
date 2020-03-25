import UIKit
import UIExtensions
import SnapKit

open class SecondaryBalanceDoubleRowView: UIView {
    public static let height: CGFloat = 25

    private let icon = UIImageView()
    private let coinValueLabel = UILabel()
    private let currencyValueLabel = UILabel()

    public init() {
        super.init(frame: .zero)

        backgroundColor = .clear

        addSubview(icon)
        icon.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(CGFloat.margin1x)
        }

        icon.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        addSubview(coinValueLabel)
        coinValueLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(icon.snp.trailing).offset(CGFloat.margin1x)
            maker.top.equalToSuperview().offset(CGFloat.margin1x)
            maker.centerY.equalTo(icon.snp.centerY)
        }

        coinValueLabel.font = .subhead2
        coinValueLabel.textColor = .themeGray

        addSubview(currencyValueLabel)
        currencyValueLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(coinValueLabel.snp.trailing).offset(CGFloat.margin2x)
            maker.trailing.equalToSuperview().inset(CGFloat.margin1x)
            maker.centerY.equalTo(coinValueLabel.snp.centerY)
        }

        currencyValueLabel.font = .subhead1
        currencyValueLabel.textColor = .themeLeah
        currencyValueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    public func bind(image: UIImage?, coinValue: (text: String?, dimmed: Bool), currencyValue: (text: String?, dimmed: Bool)?) {
        icon.image = image

        coinValueLabel.text = coinValue.text

        if let currencyValue = currencyValue {
            currencyValueLabel.text = currencyValue.text
        } else {
            currencyValueLabel.text = nil
        }
    }

}
