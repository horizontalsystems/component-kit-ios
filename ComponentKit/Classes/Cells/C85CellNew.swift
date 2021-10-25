import UIKit
import SnapKit

open class C85CellNew: BaseSelectableThemeCell {
    private let leftView = LeftCViewNew()
    private let rightView = Right85ViewNew()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, leftInset: 0, rightView: rightView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var titleStyle: LeftCViewNew.Style = .bodyOz {
        didSet {
            leftView.style = titleStyle
        }
    }

    public var title: String? {
        get { leftView.text }
        set { leftView.text = newValue }
    }

    public var lineBreadMode: NSLineBreakMode {
        get { leftView.lineBreakMode }
        set { leftView.lineBreakMode = newValue }
    }

    public var titleImage: UIImage? {
        get { leftView.image }
        set { leftView.image = newValue }
    }

    public var titleImageAction: (() -> ())? {
        get { leftView.imageAction }
        set { leftView.imageAction = newValue }
    }

    public var firstImage: UIImage? {
        didSet { rightView.leftImage = firstImage }
    }

    public var secondImage: UIImage? {
        didSet { rightView.rightImage = secondImage }
    }

    public var leftAction: (() -> ())? {
        get { rightView.onTapLeft }
        set { rightView.onTapLeft = newValue }
    }

    public var rightAction: (() -> ())? {
        get { rightView.onTapRight }
        set { rightView.onTapRight = newValue }
    }

}
