import UIKit
import SnapKit

open class D1Cell: LawrenceThemeCell {
    private let leftView = LeftDView()
    private let rightView = Right1View()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, rightView: rightView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(title: String?, last: Bool = false) {
        super.bind(bottomSeparator: last)

        leftView.text = title
    }

}
