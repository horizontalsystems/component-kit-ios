import UIKit
import ThemeKit
import SnapKit

class FontCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let fontLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .clear
        backgroundColor = .clear

        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(CGFloat.margin4x)
            maker.centerY.equalToSuperview()
        }

        nameLabel.font = .subhead1
        nameLabel.textColor = .themeOz

        contentView.addSubview(fontLabel)
        fontLabel.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(CGFloat.margin4x)
            maker.centerY.equalToSuperview()
        }

        fontLabel.textColor = .themeOz
        fontLabel.text = "Hello World"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func bind(font: FontsController.Font) {
        nameLabel.text = font.name
        fontLabel.font = font.value
    }

}
