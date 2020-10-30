import UIKit

open class LawrenceThemeCell: BaseThemeCell {

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .themeLawrence
        selectView.backgroundColor = .themeLawrencePressed
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
