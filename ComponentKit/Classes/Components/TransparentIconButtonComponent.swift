import UIKit
import SnapKit

public class TransparentIconButtonComponent: UIView {
    public let button = TransparentIconButton()

    public var onTap: (() -> ())?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(button)
        button.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
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
