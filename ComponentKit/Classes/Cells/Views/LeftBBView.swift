import UIKit
import SnapKit

open class LeftBBView: UIView {
    private let numberLabel = UILabel()
    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(numberLabel)
        numberLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.width.equalTo(24)
        }

        numberLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        numberLabel.font = .captionSB
        numberLabel.textColor = .themeGray

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.equalTo(numberLabel.snp.trailing).offset(CGFloat.margin12)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.font = .body
        label.textColor = .themeOz
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var numberText: String? {
        get { numberLabel.text }
        set { numberLabel.text = newValue }
    }

    public var numberTextColor: UIColor {
        get { numberLabel.textColor }
        set { numberLabel.textColor = newValue }
    }

    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }

    public var textColor: UIColor {
        get { label.textColor }
        set { label.textColor = newValue }
    }

}
