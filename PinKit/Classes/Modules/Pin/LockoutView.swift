import UIKit
import SnapKit
import UIExtensions
import LanguageKit

class LockoutView: UIView {
    private let lockoutIconBackgroundSideSize: CGFloat = 94

    let lockIcon = UIImageView(image: PinKit.image(named: "Lock Out Large"))
    let infoLabel = UILabel()

    init() {
        super.init(frame: .zero)
        backgroundColor = .themeBackgroundFromGradient

        let wrapper = UIView()

        addSubview(wrapper)
        wrapper.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.leading.equalToSuperview().offset(CGFloat.margin8x)
            maker.trailing.equalToSuperview().offset(-CGFloat.margin8x)
        }

        wrapper.addSubview(lockIcon)
        lockIcon.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview()
        }

        wrapper.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(lockIcon.snp.bottom).offset(CGFloat.margin4x)
            maker.bottom.equalToSuperview()
        }

        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.font = .body
        infoLabel.textColor = .themeGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    func show(expirationDate: Date) {
        isHidden = false
        infoLabel.text = "unlock_pin.blocked_until".localized(formatLockoutExpirationDate(from: expirationDate))
    }

    func hide() {
        isHidden = true
    }

    private func formatLockoutExpirationDate(from date: Date) -> String {
        DateFormatter.cachedFormatter(format: "\(LanguageHourFormatter.hourFormat):mm:ss").string(from: date)
    }

}
