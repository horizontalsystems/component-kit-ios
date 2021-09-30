import UIKit
import SnapKit

open class G21Cell: BaseThemeCell {
    private let leftView = LeftGView()
    private let rightView = Right21View()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, rightView: rightView, middleInset: 0)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setTitleImage(urlString: String?, placeholder: UIImage?) {
        leftView.setImage(urlString: urlString, placeholder: placeholder)
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

    public var rightButtonImage: UIImage? {
        get { rightView.buttonImage }
        set { rightView.buttonImage = newValue }
    }

    public var onTapRightButton: (() -> ())? {
        get { rightView.onTap }
        set { rightView.onTap = newValue }
    }

    public var isOn: Bool {
        get { rightView.isOn }
        set { rightView.isOn = newValue }
    }

    public var onToggle: ((Bool) -> ())? {
        get { rightView.onToggle }
        set { rightView.onToggle = newValue }
    }

    public func set(isOn: Bool, animated: Bool) {
        rightView.set(isOn: isOn, animated: animated)
    }

}
