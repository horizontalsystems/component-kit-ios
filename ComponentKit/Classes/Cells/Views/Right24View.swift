import UIKit
import SnapKit
import HUD

open class Right24View: UIView {
    private let label = UILabel()
    private let spinnerView = HUDProgressView(
            progress: 0,
            strokeLineWidth: 2,
            radius: 7,
            strokeColor: .themeGray,
            donutColor: .themeSteel10,
            duration: 2
    )

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.font = .subhead1
        label.textColor = .themeLeah
        label.setContentCompressionResistancePriority(.required, for: .horizontal)

        addSubview(spinnerView)
        spinnerView.snp.makeConstraints { maker in
            maker.leading.equalTo(label.snp.trailing).offset(CGFloat.margin8)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.size.equalTo(16)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }

    public var textColor: UIColor {
        get { label.textColor }
        set { label.textColor = newValue }
    }

    public func set(progress: Double) {
        spinnerView.set(progress: Float(progress))
        spinnerView.startAnimating()
    }

}
