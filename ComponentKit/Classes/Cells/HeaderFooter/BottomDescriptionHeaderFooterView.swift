import UIKit
import SnapKit

open class BottomDescriptionHeaderFooterView: UITableViewHeaderFooterView {
    private let descriptionView = BottomDescriptionView()

    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(descriptionView)
        descriptionView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().priority(.high)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(text: String?) {
        descriptionView.bind(text: text)
    }

}

extension BottomDescriptionHeaderFooterView {

    public static func height(containerWidth: CGFloat, text: String) -> CGFloat {
        BottomDescriptionView.height(containerWidth: containerWidth, text: text)
    }

}
