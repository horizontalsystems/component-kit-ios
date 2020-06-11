import UIKit
import SnapKit

open class SingleLineCheckmarkCell: ThemeCell {
    private let leftView = SingleLineCellView()
    private let rightView = CheckmarkCellView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(leftView)
        leftView.snp.makeConstraints { maker in
            maker.leading.top.bottom.equalToSuperview()
        }

        contentView.addSubview(rightView)
        rightView.snp.makeConstraints { maker in
            maker.trailing.top.bottom.equalToSuperview()
            maker.leading.equalTo(leftView.snp.trailing)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(text: String?, checkmarkVisible: Bool, last: Bool = false) {
        super.bind(last: last)

        leftView.bind(text: text)
        rightView.bind(visible: checkmarkVisible)
    }

}
