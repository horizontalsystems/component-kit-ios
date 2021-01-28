import UIKit
import SnapKit

open class BaseThemeCell: UITableViewCell {
    public static let leftInset: CGFloat = .margin16
    public static let rightInset: CGFloat = .margin16
    public static let middleInset: CGFloat = .margin16

    public let wrapperView = UIView()

    let topSeparatorView = UIView()
    let bottomSeparatorView = UIView()

    public var isVisible = true

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        separatorInset.left = 0
        selectionStyle = .none
        clipsToBounds = true

        contentView.addSubview(wrapperView)
        wrapperView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        wrapperView.clipsToBounds = true

        wrapperView.addSubview(topSeparatorView)
        topSeparatorView.snp.makeConstraints { maker in
            maker.leading.top.trailing.equalToSuperview()
            maker.height.equalTo(0)
        }

        topSeparatorView.backgroundColor = .themeSteel10

        wrapperView.addSubview(bottomSeparatorView)
        bottomSeparatorView.snp.makeConstraints { maker in
            maker.leading.bottom.trailing.equalToSuperview()
            maker.height.equalTo(0)
        }

        bottomSeparatorView.backgroundColor = .themeSteel10
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open var cellHeight: CGFloat {
        isVisible ? .heightSingleLineCell : 0
    }

    open func set(backgroundStyle: BackgroundStyle, isFirst: Bool = false, isLast: Bool = false) {
        let margin: UIEdgeInsets
        let topSeparator: Bool
        let bottomSeparator: Bool
        var maskedCorners: CACornerMask = []
        var cornerRadius: CGFloat = 0

        switch backgroundStyle {
        case .lawrence:
            wrapperView.backgroundColor = .themeLawrence
            margin = UIEdgeInsets(top: 0, left: .margin16, bottom: 0, right: .margin16)
            topSeparator = !isFirst
            bottomSeparator = false

            if isFirst || isLast {
                cornerRadius = .cornerRadius12
            }
            if isFirst {
                maskedCorners.insert(.layerMinXMinYCorner)
                maskedCorners.insert(.layerMaxXMinYCorner)
            }
            if isLast {
                maskedCorners.insert(.layerMinXMaxYCorner)
                maskedCorners.insert(.layerMaxXMaxYCorner)
            }
        case .claude:
            wrapperView.backgroundColor = .themeClaude
            margin = UIEdgeInsets.zero
            topSeparator = !isFirst
            bottomSeparator = isLast
        case .transparent:
            wrapperView.backgroundColor = .clear
            margin = UIEdgeInsets.zero
            topSeparator = !isFirst
            bottomSeparator = isLast
        }

        wrapperView.snp.remakeConstraints { maker in
            maker.edges.equalToSuperview().inset(margin)
        }
        wrapperView.layer.cornerRadius = cornerRadius
        wrapperView.layer.maskedCorners = maskedCorners

        topSeparatorView.snp.updateConstraints { maker in
            maker.height.equalTo(topSeparator ? CGFloat.heightOneDp : 0)
        }

        bottomSeparatorView.snp.updateConstraints { maker in
            maker.height.equalTo(bottomSeparator ? CGFloat.heightOneDp : 0)
        }
    }

    public func layout(leftView: UIView, leftInset: CGFloat = BaseThemeCell.leftInset, rightView: UIView) {
        wrapperView.addSubview(leftView)
        leftView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(leftInset)
            maker.top.bottom.equalToSuperview()
        }

        wrapperView.addSubview(rightView)
        rightView.snp.makeConstraints { maker in
            maker.leading.equalTo(leftView.snp.trailing).offset(Self.middleInset)
            maker.trailing.equalToSuperview().inset(Self.rightInset)
            maker.top.bottom.equalToSuperview()
        }
    }

    public enum BackgroundStyle {
        case lawrence
        case claude
        case transparent
    }

}
