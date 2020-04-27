import UIKit
import UIExtensions
import SnapKit

open class ThemeCell: UITableViewCell {
    public var activeBackgroundColor: UIColor = .themeLawrence
    public var selectedBackgroundColor: UIColor = .themeLawrencePressed {
        didSet {
            selectView.backgroundColor = selectedBackgroundColor
        }
    }
    public var inactiveBackgroundColor: UIColor = .themeRaina

    private let separatorColor: UIColor = .themeSteel20

    private let selectView = UIView()

    private let topSeparatorView = UIView()
    private let bottomSeparatorView = UIView()

    public let disclosureImageView = UIImageView(image: ThemeKit.image(named: "Disclosure Indicator")?.withRenderingMode(.alwaysTemplate))

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .clear
        separatorInset.left = 0

        contentView.addSubview(topSeparatorView)
        topSeparatorView.snp.makeConstraints { maker in
            maker.leading.top.trailing.equalToSuperview()
            maker.height.equalTo(0)
        }

        topSeparatorView.backgroundColor = separatorColor

        contentView.addSubview(bottomSeparatorView)
        bottomSeparatorView.snp.makeConstraints { maker in
            maker.leading.bottom.trailing.equalToSuperview()
            maker.height.equalTo(0)
        }

        bottomSeparatorView.backgroundColor = separatorColor

        contentView.addSubview(selectView)
        selectView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(topSeparatorView.snp.bottom)
            maker.bottom.equalTo(bottomSeparatorView.snp.top)
        }

        selectView.backgroundColor = selectedBackgroundColor
        selectView.alpha = 0

        contentView.addSubview(disclosureImageView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(showDisclosure: Bool = false, last: Bool = false, active: Bool = true) {
        bind(topSeparatorVisible: true, bottomSeparatorVisible: last, showDisclosure: showDisclosure, active: active)
    }

    open func bind(topSeparatorVisible: Bool = false, bottomSeparatorVisible: Bool = false, showDisclosure: Bool = false, active: Bool = true) {
        disclosureImageView.isHidden = !showDisclosure
        disclosureImageView.snp.remakeConstraints { maker in
            maker.trailing.equalTo(contentView.snp.trailingMargin)
            maker.size.equalTo(showDisclosure ? CGSize(width: 8, height: 13) : 0)
            maker.centerY.equalToSuperview()
        }

        topSeparatorView.snp.updateConstraints { maker in
            maker.height.equalTo(topSeparatorVisible ? 1 / UIScreen.main.scale : 0)
        }

        bottomSeparatorView.snp.updateConstraints { maker in
            maker.height.equalTo(bottomSeparatorVisible ? 1 / UIScreen.main.scale : 0)
        }

        backgroundColor = active ? activeBackgroundColor : inactiveBackgroundColor
        disclosureImageView.tintColor = active ? .themeGray : .themeGray50
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

open class ClaudeThemeCell: ThemeCell {

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        activeBackgroundColor = .themeClaude
        selectedBackgroundColor = .themeJeremy
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
