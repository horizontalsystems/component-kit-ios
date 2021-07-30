import UIKit
import SnapKit

open class LeftDView: UIView {
    private static let font: UIFont = .subhead2

    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.font = Self.font
        label.textColor = .themeGray
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var text: String? {
        get {
            label.text
        }
        set {
            label.text = newValue
        }
    }

}

extension LeftDView {

    public static func width(text: String?) -> CGFloat {
        let text = text ?? ""
        return text.size(containerWidth: .greatestFiniteMagnitude, font: font).width
    }

}
