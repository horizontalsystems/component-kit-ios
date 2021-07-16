import UIKit
import SnapKit

open class H23Cell: BaseSelectableThemeCell {
    private let leftView = LeftHView()
    private let rightView = Right23View()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, leftInset: 0, rightView: rightView)
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

    public var topText: String? {
        get { leftView.topText }
        set { leftView.topText = newValue }
    }

    public var topTextColor: UIColor {
        get { leftView.topTextColor }
        set { leftView.topTextColor = newValue }
    }

    public var bottomText: String? {
        get { leftView.bottomText }
        set { leftView.bottomText = newValue }
    }

    public func set(spinnerProgress: Float?) {
        leftView.set(spinnerProgress: spinnerProgress)
    }

    public var valueTopText: String? {
        get { rightView.topText }
        set { rightView.topText = newValue }
    }

    public var valueTopTextColor: UIColor {
        get { rightView.topTextColor }
        set { rightView.topTextColor = newValue }
    }

    public var valueLeftIconImage: UIImage? {
        get { rightView.leftIconImage }
        set { rightView.leftIconImage = newValue }
    }

    public var valueLeftIconTinColor: UIColor {
        get { rightView.leftIconTinColor }
        set { rightView.leftIconTinColor = newValue }
    }

    public var valueRightIconImage: UIImage? {
        get { rightView.rightIconImage }
        set { rightView.rightIconImage = newValue }
    }

    public var valueRightIconTinColor: UIColor {
        get { rightView.rightIconTinColor }
        set { rightView.rightIconTinColor = newValue }
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
