import UIKit
import SnapKit

open class D20Cell: BaseSelectableThemeCell {
    private let leftView = LeftDView()
    private let rightView = Right20View()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, rightView: rightView)
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

    public var valueBackground: UIColor? {
        get { rightView.badgeColor }
        set { rightView.badgeColor = newValue }
    }

    public var image: UIImage? {
        get { rightView.image }
        set { rightView.image = newValue }
    }

    public var imageTintColor: UIColor? {
        get { rightView.imageTintColor }
        set { rightView.imageTintColor = newValue }
    }

}
