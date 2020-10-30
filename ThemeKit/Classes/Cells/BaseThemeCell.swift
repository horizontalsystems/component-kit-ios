import UIKit
import SnapKit

open class BaseThemeCell: UITableViewCell {
    public let selectView = UIView()

    private let topSeparatorView = UIView()
    private let bottomSeparatorView = UIView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .clear
        separatorInset.left = 0

        contentView.addSubview(topSeparatorView)
        topSeparatorView.snp.makeConstraints { maker in
            maker.leading.top.trailing.equalToSuperview()
            maker.height.equalTo(0)
        }

        topSeparatorView.backgroundColor = .themeSteel20

        contentView.addSubview(bottomSeparatorView)
        bottomSeparatorView.snp.makeConstraints { maker in
            maker.leading.bottom.trailing.equalToSuperview()
            maker.height.equalTo(0)
        }

        bottomSeparatorView.backgroundColor = .themeSteel20

        contentView.addSubview(selectView)
        selectView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(topSeparatorView.snp.bottom)
            maker.bottom.equalTo(bottomSeparatorView.snp.top)
        }

        selectView.alpha = 0
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    public func bind(topSeparator: Bool = true, bottomSeparator: Bool = false) {
        topSeparatorView.snp.updateConstraints { maker in
            maker.height.equalTo(topSeparator ? 1 / UIScreen.main.scale : 0)
        }

        bottomSeparatorView.snp.updateConstraints { maker in
            maker.height.equalTo(bottomSeparator ? 1 / UIScreen.main.scale : 0)
        }
    }

    public func layout(leftView: UIView, rightView: UIView) {
        contentView.addSubview(leftView)
        leftView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(CGFloat.margin4x)
            maker.top.bottom.equalToSuperview()
        }

        contentView.addSubview(rightView)
        rightView.snp.makeConstraints { maker in
            maker.leading.equalTo(leftView.snp.trailing).offset(CGFloat.margin4x)
            maker.trailing.equalToSuperview().inset(CGFloat.margin4x)
            maker.top.bottom.equalToSuperview()
        }
    }

}
