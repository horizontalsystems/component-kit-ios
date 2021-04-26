import UIKit
import SnapKit

open class BCell: BaseSelectableThemeCell {
    private let view = LeftBView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        wrapperView.addSubview(view)
        view.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(Self.leftInset)
            maker.top.bottom.equalToSuperview()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var title: String? {
        get { view.text }
        set { view.text = newValue }
    }

    public var titleColor: UIColor {
        get { view.textColor }
        set { view.textColor = newValue }
    }

}
