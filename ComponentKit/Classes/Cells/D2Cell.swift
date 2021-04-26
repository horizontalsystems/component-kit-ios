import UIKit
import SnapKit

open class D2Cell: BaseSelectableThemeCell {
    private let leftView = LeftDView()
    private let rightView = Right2View()

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

    public var disclosureImageTintColor: UIColor? {
        get { rightView.disclosureImageTintColor }
        set { rightView.disclosureImageTintColor = newValue }
    }

}
