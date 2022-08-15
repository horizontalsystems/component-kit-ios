import UIKit
import SnapKit

open class BaseSelectableThemeCell: BaseThemeCell {
    private let selectView = UIView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .default

        borderView.insertSubview(selectView, at: 0)
        selectView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview().priority(.high)
        }

        selectView.alpha = 0
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func set(backgroundStyle: BackgroundStyle, cornerRadius: CGFloat = .cornerRadius12, isFirst: Bool = false, isLast: Bool = false) {
        super.set(backgroundStyle: backgroundStyle, cornerRadius: cornerRadius, isFirst: isFirst, isLast: isLast)

        switch backgroundStyle {
        case .lawrence, .bordered:
            selectView.backgroundColor = .themeLawrencePressed
            selectView.layer.cornerRadius = borderView.cornerRadius
            selectView.layer.maskedCorners = corners(isFirst: isFirst, isLast: isLast)
        case .transparent:
            selectView.backgroundColor = .themeLawrencePressed
            selectView.layer.cornerRadius = 0
            selectView.layer.maskedCorners = []
        }

        var topInset: CGFloat = 0
        if !topSeparatorView.isHidden {
            topInset = topSeparatorView.height
        }
        if borderView.borders.contains(.top) {
            topInset = borderView.borderWidth
        }
        selectView.snp.updateConstraints { maker in
            maker.top.equalToSuperview().inset(topInset)
            maker.leading.equalToSuperview().inset(borderView.borders.contains(.left) ? borderView.borderWidth : 0)
            maker.trailing.equalToSuperview().inset(borderView.borders.contains(.right) ? borderView.borderWidth : 0)
            maker.bottom.equalToSuperview().inset(borderView.borders.contains(.bottom) ? borderView.borderWidth : 0).priority(.high)
        }

        layoutIfNeeded()
    }

    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        guard selectionStyle != .none else { return }

        if animated {
            UIView.animate(withDuration: .themeAnimationDuration) {
                self.selectView.alpha = highlighted ? 1 : 0
            }
        } else {
            selectView.alpha = highlighted ? 1 : 0
        }
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        guard selectionStyle != .none else { return }

        if animated {
            UIView.animate(withDuration: .themeAnimationDuration) {
                self.selectView.alpha = selected ? 1 : 0
            }
        } else {
            selectView.alpha = selected ? 1 : 0
        }
    }

}
