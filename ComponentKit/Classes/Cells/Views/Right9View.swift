import UIKit
import SnapKit

open class Right9View: UIView {
    private let button = CopyableSecondaryButton()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(button)
        button.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var viewItem: CopyableSecondaryButton.ViewItem {
        get {
            button.viewItem
        }
        set {
            button.viewItem = newValue
        }
    }

}
