import UIKit
import SnapKit

open class RightLabelCell: TitleCell {
    private var rightLabel = UILabel()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel.snp.trailing).offset(CGFloat.margin4x)
            maker.trailing.equalTo(disclosureImageView.snp.leading).offset(-CGFloat.margin4x)
            maker.centerY.equalToSuperview()
        }

        rightLabel.lineBreakMode = .byTruncatingMiddle
        rightLabel.textColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(titleIcon: UIImage?, title: String, rightText: String?, showDisclosure: Bool, last: Bool = false) {
        super.bind(titleIcon: titleIcon, title: title, showDisclosure: showDisclosure, last: last)
        rightLabel.text = rightText
    }

}
