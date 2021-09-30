import UIKit
import SnapKit

open class A5Cell: BaseSelectableThemeCell {
    private let leftView = LeftAView()
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

    public var titleImage: UIImage? {
        get { leftView.image }
        set { leftView.image = newValue }
    }

    public var titleImageTintColor: UIColor? {
        get { leftView.imageTintColor }
        set { leftView.imageTintColor = newValue }
    }

    public func set(titleImageSize: CGFloat) {
        leftView.set(imageSize: titleImageSize)
    }

    public func setTitleImage(urlString: String?, placeholder: UIImage?) {
        leftView.setImage(urlString: urlString, placeholder: placeholder)
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
