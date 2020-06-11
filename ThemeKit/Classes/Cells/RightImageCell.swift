import UIKit
import UIExtensions
import SnapKit

open class RightImageCell: TitleCell {
    var rightImageView = TintImageView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { maker in
            maker.trailing.equalTo(disclosureImageView.snp.leading).offset(-CGFloat.margin4x)
            maker.centerY.equalToSuperview()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(titleIcon: UIImage?, title: String, rightImage: UIImage?, rightImageTintColor: UIColor?, showDisclosure: Bool, last: Bool = false) {
        super.bind(titleIcon: titleIcon, title: title, showDisclosure: showDisclosure, last: last)
        rightImageView.tintColor = rightImageTintColor
        rightImageView.image = rightImage
    }

}
