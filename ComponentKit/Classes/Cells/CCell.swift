import UIKit
import SnapKit

open class CCell: BaseThemeCell {
    private let view = LeftCView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(singleView: view, leftInset: 0)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var title: String? {
        get { view.text }
        set { view.text = newValue }
    }

    public var titleImage: UIImage? {
        get { view.image }
        set { view.image = newValue }
    }

    public var titleImageAction: (() -> ())? {
        get { view.imageAction }
        set { view.imageAction = newValue }
    }

}
