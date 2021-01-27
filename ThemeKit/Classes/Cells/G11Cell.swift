import UIKit
import SnapKit

open class G11Cell: BaseThemeCell {
    private let leftView = LeftGView()
    private let rightView = Right11View()

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
