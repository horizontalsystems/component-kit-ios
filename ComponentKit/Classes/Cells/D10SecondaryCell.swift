import UIKit
import SnapKit

open class D10SecondaryCell: BaseThemeCell {
    private let leftView = LeftDView()
    private let rightView = Right10SecondaryView()

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

    public func set(viewItems: [ViewItem]) {
        rightView.set(viewItems: viewItems)
    }

    public var onTapButton: ((Int) -> ())? {
        get { rightView.onTapButton }
        set { rightView.onTapButton = newValue }
    }

}

extension D10SecondaryCell {

    public struct ViewItem {
        let title: String?
        let enabled: Bool

        public init(title: String?, enabled: Bool) {
            self.title = title
            self.enabled = enabled
        }

    }

}
