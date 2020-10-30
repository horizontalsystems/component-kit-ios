import UIKit
import SnapKit

open class Right1View: UIView {
    private let disclosureImageView = UIImageView(image: ThemeKit.image(named: "Disclosure Indicator")?.withRenderingMode(.alwaysTemplate))

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(disclosureImageView)
        disclosureImageView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        disclosureImageView.tintColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
