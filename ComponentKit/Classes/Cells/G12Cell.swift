import UIKit
import SnapKit

open class G12Cell: BaseSelectableThemeCell {
    private let leftView = LeftGView()
    private let rightView = Right12View()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, rightView: rightView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var leftImage: UIImage? {
        get { leftView.image }
        set { leftView.image = newValue }
    }

    public var leftImageTintColor: UIColor? {
        get { leftView.tintColor }
        set { leftView.tintColor = newValue }
    }

    public func setTitleImage(urlString: String?, placeholder: UIImage?) {
        leftView.setImage(urlString: urlString, placeholder: placeholder)
    }

    public var titleImageCornerRadius: CGFloat {
        get { leftView.imageCornerRadius }
        set { leftView.imageCornerRadius = newValue }
    }

    public var titleImageBackgroundColor: UIColor? {
        get { leftView.imageBackgroundColor }
        set { leftView.imageBackgroundColor = newValue }
    }

    public var topText: String? {
        get { leftView.topText }
        set { leftView.topText = newValue }
    }

    public var bottomText: String? {
        get { leftView.bottomText }
        set { leftView.bottomText = newValue }
    }

    public var leftBadgeText: String? {
        get { leftView.leftBadgeText }
        set { leftView.leftBadgeText = newValue }
    }

    public var leftBadgeTextColor: UIColor {
        get { leftView.leftBadgeTextColor }
        set { leftView.leftBadgeTextColor = newValue }
    }

    public var leftBadgeBackgroundColor: UIColor? {
        get { leftView.leftBadgeBackgroundColor }
        set { leftView.leftBadgeBackgroundColor = newValue }
    }

    public var rightBadgeText: String? {
        get { leftView.rightBadgeText }
        set { leftView.rightBadgeText = newValue }
    }

    public var rightBadgeTextColor: UIColor {
        get { leftView.rightBadgeTextColor }
        set { leftView.rightBadgeTextColor = newValue }
    }

    public var rightBadgeBackgroundColor: UIColor? {
        get { leftView.rightBadgeBackgroundColor }
        set { leftView.rightBadgeBackgroundColor = newValue }
    }

    public var valueTopText: String? {
        get { rightView.topText }
        set { rightView.topText = newValue }
    }

    public var valueTopTextColor: UIColor {
        get { rightView.topTextColor }
        set { rightView.topTextColor = newValue }
    }

    public var valueBottomText: String? {
        get { rightView.bottomText }
        set { rightView.bottomText = newValue }
    }

    public var valueBottomTextColor: UIColor {
        get { rightView.bottomTextColor }
        set { rightView.bottomTextColor = newValue }
    }

}
