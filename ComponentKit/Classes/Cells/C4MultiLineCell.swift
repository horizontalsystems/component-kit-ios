import UIKit
import SnapKit

open class C4MultiLineCell: BaseSelectableThemeCell {
    private let leftView = LeftCMultiLineView()
    private let rightView = Right4View()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, leftInset: 0, rightView: rightView)
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

    public var titleImageAction: (() -> ())? {
        get { leftView.imageAction }
        set { leftView.imageAction = newValue }
    }

    public var valueImage: UIImage? {
        get { rightView.image }
        set { rightView.image = newValue }
    }

    public var valueImageTintColor: UIColor? {
        get { rightView.imageTintColor }
        set { rightView.imageTintColor = newValue }
    }

}

extension C4MultiLineCell {

    public static func height(containerWidth: CGFloat, backgroundStyle: BackgroundStyle, title: String) -> CGFloat {
        let titleWidth = containerWidth - Self.margin(backgroundStyle: backgroundStyle).width - Right4View.width - Self.middleInset - Self.rightInset
        return LeftCMultiLineView.height(containerWidth: titleWidth, text: title)
    }

}
