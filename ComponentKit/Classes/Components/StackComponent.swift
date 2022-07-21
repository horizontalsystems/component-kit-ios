import UIKit
import SnapKit

public class StackComponent: UIView {
    let stackView = UIStackView()

    init(centered: Bool) {
        super.init(frame: .zero)

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            if centered {
                maker.leading.trailing.equalToSuperview()
                maker.centerY.equalToSuperview()
            } else {
                maker.edges.equalToSuperview()
            }
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
