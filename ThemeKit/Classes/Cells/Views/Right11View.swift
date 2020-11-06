import UIKit
import SnapKit

open class Right11View: UIView {
    private let toggleView = UISwitch()
    public var onToggle: ((Bool) -> ())?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(toggleView)
        toggleView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        toggleView.tintColor = .themeSteel20
        toggleView.addTarget(self, action: #selector(onSwitch), for: .valueChanged)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onSwitch() {
        onToggle?(toggleView.isOn)
    }

    public var isOn: Bool {
        get {
            toggleView.isOn
        }
        set {
            toggleView.isOn = newValue
        }
    }

}
