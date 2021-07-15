import UIKit
import SnapKit

open class F2Cell: BaseSelectableThemeCell {
    private let leftView = LeftFView()
    private let rightView = Right2View()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, rightView: rightView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var title: String? {
        get { leftView.topText }
        set { leftView.topText = newValue }
    }

    public var subtitle: String? {
        get { leftView.bottomText }
        set { leftView.bottomText = newValue }
    }

    public var titleColor: UIColor {
        get { leftView.topTextColor }
        set { leftView.topTextColor = newValue }
    }

    public var subtitleColor: UIColor {
        get { leftView.bottomTextColor }
        set { leftView.bottomTextColor = newValue }
    }

    public var value: String? {
        get { rightView.text }
        set { rightView.text = newValue }
    }

    public var valueColor: UIColor {
        get { rightView.textColor }
        set { rightView.textColor = newValue }
    }

}
