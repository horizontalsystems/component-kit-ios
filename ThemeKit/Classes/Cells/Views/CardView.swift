import UIKit
import SnapKit

open class CardView: UIView {
    private let roundedBackground = UIView()
    private let clippingView = UIView()
    public let contentView = UIView()

    public init(insets: UIEdgeInsets) {
        super.init(frame: .zero)

        addSubview(roundedBackground)
        roundedBackground.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        roundedBackground.backgroundColor = .themeLawrence
        roundedBackground.layer.cornerRadius = .cornerRadius4x
        roundedBackground.layer.shadowColor = UIColor.themeAndy.cgColor
        roundedBackground.layer.shadowRadius = .cornerRadius1x
        roundedBackground.layer.shadowOffset = CGSize(width: 0, height: 4)
        roundedBackground.layer.shadowOpacity = 1

        addSubview(clippingView)
        clippingView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        clippingView.backgroundColor = .clear
        clippingView.clipsToBounds = true
        clippingView.layer.cornerRadius = .cornerRadius4x

        clippingView.addSubview(contentView)
        contentView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(insets)
        }

        contentView.backgroundColor = .clear
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
