import UIKit
import SnapKit

open class Cell9: BaseThemeCell {
    public static let verticalInset: CGFloat = .margin8

    private let button = CopyableSecondaryButton()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        wrapperView.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(Self.leftInset)
            maker.trailing.equalToSuperview().inset(Self.rightInset)
            maker.top.bottom.equalToSuperview().inset(Self.verticalInset)
        }

        button.titleLabel?.numberOfLines = 0
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var viewItem: CopyableSecondaryButton.ViewItem {
        get { button.viewItem }
        set { button.viewItem = newValue }
    }

    public var handler: ((CopyableSecondaryButton.ViewItem) -> ())? {
        get { button.handler }
        set { button.handler = newValue }
    }

}

extension Cell9 {

    public static func height(containerWidth: CGFloat, backgroundStyle: BackgroundStyle, viewItem: CopyableSecondaryButton.ViewItem) -> CGFloat {
        let buttonWidth = containerWidth - margin(backgroundStyle: backgroundStyle).width - leftInset - rightInset
        let buttonHeight = CopyableSecondaryButton.height(containerWidth: buttonWidth, viewItem: viewItem)
        return buttonHeight + verticalInset * 2
    }

}
