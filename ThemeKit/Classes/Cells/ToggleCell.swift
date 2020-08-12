import UIKit
import UIExtensions
import SnapKit

open class ToggleCell: TitleCell {
    var rightImageView = UIImageView()
    var toggleView = UISwitch()
    var onToggle: ((Bool) -> ())?

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        contentView.addSubview(toggleView)
        toggleView.snp.makeConstraints { maker in
            maker.trailing.equalTo(disclosureImageView.snp.leading).inset(1.6)
            maker.centerY.equalToSuperview()
        }

        toggleView.tintColor = .themeSteel20
        toggleView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)

        contentView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { maker in
            maker.trailing.equalTo(toggleView.snp.leading).offset(-CGFloat.margin2x)
            maker.centerY.equalToSuperview()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(titleIcon: UIImage? = nil, title: String, rightImage: UIImage? = nil, isOn: Bool, last: Bool = false, onToggle: ((Bool) -> ())? = nil) {
        super.bind(titleIcon: titleIcon, title: title, last: last)
        self.onToggle = onToggle
        toggleView.isOn = isOn
        rightImageView.image = rightImage
    }

    @objc private func switchChanged() {
        onToggle?(toggleView.isOn)
    }

}
