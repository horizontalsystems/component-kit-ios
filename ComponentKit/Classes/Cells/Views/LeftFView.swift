import UIKit
import SnapKit

open class LeftFView: UIView {
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(topLabel)
        topLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(10)
        }

        topLabel.font = .body
        topLabel.textColor = .themeOz

        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(topLabel.snp.bottom).offset(5)
        }

        bottomLabel.font = .subhead2
        bottomLabel.textColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var topText: String? {
        get { topLabel.text }
        set { topLabel.text = newValue }
    }

    public var bottomText: String? {
        get { bottomLabel.text }
        set { bottomLabel.text = newValue }
    }

    public var topTextColor: UIColor {
        get { topLabel.textColor }
        set { topLabel.textColor = newValue }
    }

    public var bottomTextColor: UIColor {
        get { bottomLabel.textColor }
        set { bottomLabel.textColor = newValue }
    }

}
