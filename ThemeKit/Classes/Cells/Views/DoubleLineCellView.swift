import UIKit
import SnapKit

open class DoubleLineCellView: UIView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(CGFloat.margin4x)
            maker.trailing.equalToSuperview().offset(-CGFloat.margin4x)
            maker.top.equalToSuperview().offset(10)
        }

        titleLabel.font = .body

        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(CGFloat.margin4x)
            maker.trailing.equalToSuperview().offset(-CGFloat.margin4x)
            maker.top.equalTo(titleLabel.snp.bottom).offset(5)
        }

        subtitleLabel.font = .subhead2
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(title: String?, subtitle: String?, active: Bool = true) {
        titleLabel.text = title
        subtitleLabel.text = subtitle

        titleLabel.textColor = active ? .themeLeah : .themeNina
        subtitleLabel.textColor = active ? .themeGray : .themeGray50
    }

}
