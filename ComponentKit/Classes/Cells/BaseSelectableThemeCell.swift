import UIKit
import SnapKit

open class BaseSelectableThemeCell: BaseThemeCell {
    private let selectView = UIView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .default

        wrapperView.insertSubview(selectView, at: 0)
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

    open override func set(backgroundStyle: BackgroundStyle, isFirst: Bool = false, isLast: Bool = false) {
        super.set(backgroundStyle: backgroundStyle, isFirst: isFirst, isLast: isLast)

        switch backgroundStyle {
        case .lawrence, .bordered:
            selectView.backgroundColor = .themeLawrencePressed
        case .transparent:
            selectView.backgroundColor = .themeLawrencePressed
        }

        selectView.snp.updateConstraints { maker in
            maker.top.equalToSuperview().inset(wrapperView.viewBorders.contains(.top) ? wrapperView.viewBorderWidth : 0)
            maker.leading.equalToSuperview().inset(wrapperView.viewBorders.contains(.left) ? wrapperView.viewBorderWidth : 0)
            maker.trailing.equalToSuperview().inset(wrapperView.viewBorders.contains(.right) ? wrapperView.viewBorderWidth : 0)
            maker.bottom.equalToSuperview().inset(wrapperView.viewBorders.contains(.bottom) ? wrapperView.viewBorderWidth : 0).priority(.high)
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
