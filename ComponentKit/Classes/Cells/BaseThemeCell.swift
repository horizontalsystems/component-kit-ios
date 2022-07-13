import SkeletonView
import SnapKit
import UIKit

open class BaseThemeCell: UITableViewCell {
    public static let leftInset: CGFloat = .margin16
    public static let rightInset: CGFloat = .margin16
    public static let middleInset: CGFloat = .margin16

    public let wrapperView = CellWrapperView()

    let stackView = UIStackView()

    public var isVisible = true
    var id: String?

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        isSkeletonable = true

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        separatorInset.left = 0
        selectionStyle = .none
        clipsToBounds = true

        contentView.addSubview(wrapperView)
        wrapperView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        wrapperView.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        stackView.insetsLayoutMarginsFromSafeArea = false

        wrapperView.viewBorderColor = .themeSteel10
        wrapperView.viewBorderWidth = .heightOneDp
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open var cellHeight: CGFloat {
        isVisible ? .heightSingleLineCell : 0
    }

    private func corners(isFirst: Bool, isLast: Bool) -> CACornerMask {
        var maskedCorners: CACornerMask = []
        if isFirst {
            maskedCorners.insert(.layerMinXMinYCorner)
            maskedCorners.insert(.layerMaxXMinYCorner)
        }
        if isLast {
            maskedCorners.insert(.layerMinXMaxYCorner)
            maskedCorners.insert(.layerMaxXMaxYCorner)
        }
        return maskedCorners
    }

    open func set(backgroundStyle: BackgroundStyle, isFirst: Bool = false, isLast: Bool = false) {
        var maskedCorners: CACornerMask = []
        var cornerRadius: CGFloat = 0

        wrapperView.viewCornerEdges = []
        wrapperView.viewCornerRadius = 0

        switch backgroundStyle {
        case .lawrence:
            wrapperView.backgroundColor = .themeLawrence
            if isFirst || isLast {
                cornerRadius = .cornerRadius12
            }
            maskedCorners = corners(isFirst: isFirst, isLast: isLast)
            wrapperView.viewBorders = isFirst ? [] : [.top]
        case .bordered:
            wrapperView.backgroundColor = .clear

            var viewCornerEdges: UIRectEdge = []
            var viewBorders: UIRectEdge = [.left, .top, .right]
            if isFirst || isLast {
                cornerRadius = .cornerRadius12
            }
            maskedCorners = corners(isFirst: isFirst, isLast: isLast)
            if isFirst {
                viewCornerEdges.formUnion(.top)
            }
            if isLast {
                viewCornerEdges.formUnion(.bottom)
                viewBorders.formUnion(.bottom)
            }

            wrapperView.viewCornerEdges = viewCornerEdges
            wrapperView.viewCornerRadius = cornerRadius
            wrapperView.viewBorders = viewBorders
        case .transparent:
            wrapperView.backgroundColor = .clear

            var viewBorders: UIRectEdge = []
            if !isFirst {
                viewBorders.formUnion(.top)
            }
            if isLast {
                viewBorders.formUnion(.bottom)
            }
            wrapperView.viewBorders = viewBorders
        }

        wrapperView.snp.remakeConstraints { maker in
            maker.edges.equalToSuperview().inset(Self.margin(backgroundStyle: backgroundStyle))
        }

        wrapperView.layer.cornerRadius = cornerRadius
        wrapperView.layer.maskedCorners = maskedCorners
    }

    public func bind<T>(index: Int, block: (T) -> Void) {
        guard index < stackView.arrangedSubviews.count, let view = stackView.arrangedSubviews[index] as? T else {
            print("Cannot cast component view: \(T.self)")
            return
        }

        block(view)
    }

    public func component<T>(index: Int) -> T? {
        guard index < stackView.arrangedSubviews.count, let view = stackView.arrangedSubviews[index] as? T else {
            print("Cannot cast component view: \(T.self)")
            return nil
        }

        return view
    }

    public func layout(leftView: UIView, leftInset: CGFloat = BaseThemeCell.leftInset, rightView: UIView, rightInset: CGFloat = BaseThemeCell.rightInset, middleInset: CGFloat = BaseThemeCell.middleInset) {
        wrapperView.addSubview(leftView)
        leftView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(leftInset)
            maker.top.bottom.equalToSuperview()
        }

        wrapperView.addSubview(rightView)
        rightView.snp.makeConstraints { maker in
            maker.leading.equalTo(leftView.snp.trailing).offset(middleInset)
            maker.trailing.equalToSuperview().inset(rightInset)
            maker.top.bottom.equalToSuperview()
        }
    }

    public func layout(singleView: UIView, leftInset: CGFloat = BaseThemeCell.leftInset) {
        wrapperView.addSubview(singleView)
        singleView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(leftInset)
            maker.trailing.equalToSuperview().inset(Self.rightInset)
            maker.top.bottom.equalToSuperview()
        }
    }

    public static func margin(backgroundStyle: BackgroundStyle) -> UIEdgeInsets {
        switch backgroundStyle {
        case .lawrence, .bordered:
            return UIEdgeInsets(top: 0, left: .margin16, bottom: 0, right: .margin16)
        case .transparent:
            return UIEdgeInsets.zero
        }
    }

    public enum BackgroundStyle {
        case lawrence
        case bordered
        case transparent
    }

}
