import UIKit
import SnapKit

open class A2Cell: BaseSelectableThemeCell {
    private let leftView = LeftAView()
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

    public var titleImage: UIImage? {
        get { leftView.image }
        set { leftView.image = newValue }
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

    public var disclosureImageTintColor: UIColor? {
        get { rightView.disclosureImageTintColor }
        set { rightView.disclosureImageTintColor = newValue }
    }

}
