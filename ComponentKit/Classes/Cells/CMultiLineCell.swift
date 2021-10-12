import UIKit
import SnapKit

open class CMultiLineCell: BaseThemeCell {
    private let view = LeftCMultiLineView()

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

extension CMultiLineCell {

    public static func height(containerWidth: CGFloat, backgroundStyle: BackgroundStyle, title: String) -> CGFloat {
        let titleWidth = containerWidth - Self.margin(backgroundStyle: backgroundStyle).width - Self.rightInset
        return LeftCMultiLineView.height(containerWidth: titleWidth, text: title)
    }

}
