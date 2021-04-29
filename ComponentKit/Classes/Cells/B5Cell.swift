import UIKit
import SnapKit

open class B5Cell: BaseSelectableThemeCell {
    private let leftView = LeftBView()
    private let rightView = Right5View()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, rightView: rightView, rightInset: 0, middleInset: 0)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var title: String? {
        get { leftView.text }
        set { leftView.text = newValue }
    }

    public var value: String? {
        get { rightView.text }
        set { rightView.text = newValue }
    }

    public var valueColor: UIColor {
        get { rightView.textColor }
        set { rightView.textColor = newValue }
    }

    public var valueAction: (() -> ())? {
        get { rightView.onTap }
        set { rightView.onTap = newValue }
    }

}
