import UIKit
import SnapKit

open class SwitchCellView: UIView {
    private let switchView = UISwitch()
    private var onSwitch: ((Bool) -> ())?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        switchView.tintColor = .themeSteel20
        switchView.setContentCompressionResistancePriority(.required, for: .horizontal)
        switchView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        addSubview(switchView)
        switchView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview().offset(-CGFloat.margin4x)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(isOn: Bool, onSwitch: @escaping (Bool) -> ()) {
        switchView.isOn = isOn
        self.onSwitch = onSwitch
    }

    @objc private func switchChanged() {
        onSwitch?(switchView.isOn)
    }

}
