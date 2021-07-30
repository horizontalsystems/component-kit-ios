import UIKit
import SnapKit

open class D10Cell: BaseThemeCell {
    private let leftView = LeftDView()
    private let rightView = Right10View()

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

    public var viewItem: CopyableSecondaryButton.ViewItem {
        get { rightView.viewItem }
        set { rightView.viewItem = newValue }
    }

    public func set(iconButtonImage: UIImage?) {
        rightView.set(iconButtonImage: iconButtonImage)
    }

    public var onTapIconButton: (() -> ())? {
        get { rightView.onTapIconButton }
        set { rightView.onTapIconButton = newValue }
    }

}
