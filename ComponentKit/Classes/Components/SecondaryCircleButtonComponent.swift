import UIKit
import SnapKit

public class SecondaryCircleButtonComponent: UIView {
    public let button = SecondaryCircleButton()

    public var onTap: (() -> ())?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(button)
        button.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        button.addTarget(self, action: #selector(_onTap), for: .touchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func _onTap() {
        onTap?()
    }

}
