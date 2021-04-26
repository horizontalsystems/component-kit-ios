import UIKit
import SnapKit

open class B11Cell: BaseThemeCell {
    private let leftView = LeftBView()
    private let rightView = Right11View()

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

    public var rightImage: UIImage? {
        get { rightView.image }
        set { rightView.image = newValue }
    }

    public var isOn: Bool {
        get { rightView.isOn }
        set { rightView.isOn = newValue }
    }

    public var onToggle: ((Bool) -> ())? {
        get { rightView.onToggle }
        set { rightView.onToggle = newValue }
    }

}
