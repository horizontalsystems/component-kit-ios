import UIKit
import ThemeKit
import SnapKit

class ColorCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let colorView = UIView()

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

        contentView.addSubview(colorView)
        colorView.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(CGFloat.margin2x)
            maker.trailing.equalToSuperview().inset(CGFloat.margin4x)
            maker.width.equalTo(72)
        }

        colorView.layer.borderWidth = 1
        colorView.layer.borderColor = UIColor.themeNina.cgColor
        colorView.layer.cornerRadius = 8
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func bind(color: ColorsController.Color) {
        nameLabel.text = color.name
        colorView.backgroundColor = color.value
    }

}
