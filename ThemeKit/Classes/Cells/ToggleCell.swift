import UIKit
import SnapKit
import ThemeKit

open class ToggleCell: TitleCell {
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
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(titleIcon: UIImage? = nil, title: String, isOn: Bool, last: Bool = false, onToggle: ((Bool) -> ())? = nil) {
        super.bind(titleIcon: titleIcon, title: title, last: last)
        self.onToggle = onToggle
        toggleView.isOn = isOn
    }

    @objc private func switchChanged() {
        onToggle?(toggleView.isOn)
    }

}
