import UIKit
import SnapKit

open class GA4Cell: BaseSelectableThemeCell {
    private let leftView = LeftGAView()
    private let rightView = Right4View()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, rightView: rightView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var titleImage: UIImage? {
        get { leftView.image }
        set { leftView.image = newValue }
    }

    public var title: String? {
        get { leftView.topText }
        set { leftView.topText = newValue }
    }

    public var subtitle: String? {
        get { leftView.bottomText }
        set { leftView.bottomText = newValue }
    }

    public var badgeText: String? {
        get { leftView.badgeText }
        set { leftView.badgeText = newValue }
    }

    public var badgeTextColor: UIColor {
        get { leftView.badgeTextColor }
        set { leftView.badgeTextColor = newValue }
    }

    public var badgeBackgroundColor: UIColor? {
        get { leftView.badgeBackgroundColor }
        set { leftView.badgeBackgroundColor = newValue }
    }

    public var valueImage: UIImage? {
        get { rightView.image }
        set { rightView.image = newValue }
    }

}