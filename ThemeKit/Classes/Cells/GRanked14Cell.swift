import UIKit
import SnapKit

open class GRanked14Cell: BaseThemeCell {
    private let leftView = LeftGRankedView()
    private let rightView = Right14TitledView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout(leftView: leftView, rightView: rightView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var leftImage: UIImage? {
        get { leftView.image }
        set { leftView.image = newValue }
    }

    public var topText: String? {
        get { leftView.topText }
        set { leftView.topText = newValue }
    }

    public var rankText: String? {
        get { leftView.rankText }
        set { leftView.rankText = newValue }
    }

    public var rankTextColor: UIColor {
        get { leftView.rankTextColor }
        set { leftView.rankTextColor = newValue }
    }

    public var rankBackgroundColor: UIColor? {
        get { leftView.rankBackgroundColor }
        set { leftView.rankBackgroundColor = newValue }
    }

    public var bottomText: String? {
        get { leftView.bottomText }
        set { leftView.bottomText = newValue }
    }

    public var primaryValueText: String? {
        get { rightView.topText }
        set { rightView.topText = newValue }
    }

    public var secondaryTitleText: String? {
        get { rightView.bottomTitleText }
        set { rightView.bottomTitleText = newValue }
    }

    public var secondaryValueText: String? {
        get { rightView.bottomText }
        set { rightView.bottomText = newValue }
    }

    public var secondaryValueTextColor: UIColor {
        get { rightView.bottomTextColor }
        set { rightView.bottomTextColor = newValue }
    }

}
