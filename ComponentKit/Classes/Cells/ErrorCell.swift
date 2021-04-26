import UIKit
import SnapKit

open class ErrorCell: UITableViewCell {
    private let errorView = ErrorView()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(errorView)
        errorView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(CGFloat.margin16)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var errorText: String? {
        get { errorView.text }
        set { errorView.text = newValue }
    }

}
