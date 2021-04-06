import UIKit
import SnapKit

open class CardCell: UITableViewCell {
    static public let animationDuration = 0.15

    private static let horizontalMargin: CGFloat = .margin4x
    private static let bottomMargin: CGFloat = .margin2x

    private let selectView = UIView()

    private let roundedBackground = UIView()
    public let clippingView = UIView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .clear
        backgroundColor = .clear

        roundedBackground.backgroundColor = .themeLawrence
        roundedBackground.layer.cornerRadius = .cornerRadius4x
        roundedBackground.layer.shadowRadius = .cornerRadius1x
        roundedBackground.layer.shadowOffset = CGSize(width: 0, height: 4)
        roundedBackground.layer.shadowOpacity = 1

        contentView.addSubview(roundedBackground)
        roundedBackground.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.trailing.equalToSuperview().inset(CardCell.horizontalMargin)
            maker.bottom.equalToSuperview().inset(CardCell.bottomMargin)
        }

        clippingView.backgroundColor = .clear
        clippingView.clipsToBounds = true
        clippingView.layer.cornerRadius = .cornerRadius4x

        roundedBackground.addSubview(clippingView)
        clippingView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        selectView.backgroundColor = .themeSteel20
        selectView.alpha = 0

        clippingView.addSubview(selectView)
        selectView.snp.makeConstraints { maker in
            maker.leading.top.trailing.bottom.equalToSuperview()
        }

        updateUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        guard selectionStyle != .none else { return }
        if animated {
            UIView.animate(withDuration: .themeAnimationDuration) {
                self.selectView.alpha = highlighted ? 1 : 0
            }
        } else {
            selectView.alpha = highlighted ? 1 : 0
        }
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        guard selectionStyle != .none else { return }
        if animated {
            UIView.animate(withDuration: .themeAnimationDuration) {
                self.selectView.alpha = selected ? 1 : 0
            }
        } else {
            selectView.alpha = selected ? 1 : 0
        }
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateUI()
    }

    private func updateUI() {
        roundedBackground.layer.shadowColor = UIColor.themeAndy.cgColor
    }

}

extension CardCell {

    static public func contentWidth(containerWidth: CGFloat) -> CGFloat {
        containerWidth - CardCell.horizontalMargin * 2
    }

    static public func height(contentHeight: CGFloat) -> CGFloat {
        contentHeight + CardCell.bottomMargin
    }

}
