import UIKit
import ThemeKit
import ComponentKit
import SnapKit

public protocol IScanQrCodeDelegate: AnyObject {
    func didScan(string: String)
}

class ScanQrAlertView: UIView {
    private let cornersView = BorderedView()

    private let stackView = UIStackView()
    private let titleLabel = UILabel()

    private let actionButton = PrimaryButton()
    private var action: (() -> ())?

    init() {
        super.init(frame: .zero)

        addSubview(cornersView)
        cornersView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        cornersView.borderStyle = .corners(length: .margin24)
        cornersView.borderWidth = 2
        cornersView.cornerRadius = .cornerRadius4
        cornersView.borderColor = .themeGray

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(CGFloat.margin32)
            maker.centerY.equalToSuperview()
        }

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = .margin32

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(actionButton)

        titleLabel.font = .subhead2
        titleLabel.textColor = .themeGray
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        actionButton.set(style: .transparent)
        actionButton.addTarget(self, action: #selector(onTapAction), for: .touchUpInside)

        clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onTapAction() {
        action?()
    }

    func bind(title: String, actionTitle: String? = nil, action: (() -> ())? = nil) {
        self.action = action

        titleLabel.text = title
        actionButton.setTitle(actionTitle, for: .normal)

        actionButton.isHidden = actionTitle == nil
    }

}
