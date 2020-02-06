import UIKit
import SnapKit
import UIExtensions
import LanguageKit

class LockoutView: UIView {
    private let lockoutIconBackgroundSideSize: CGFloat = 94

    let iconBackgroundView = UIView()
    let lockIcon = UIImageView(image: PinKit.image(named: "Lock Out Large"))
    let infoLabel = UILabel()

    init() {
        super.init(frame: .zero)
        backgroundColor = .themeBackgroundFromGradient

        addSubview(iconBackgroundView)
        iconBackgroundView.backgroundColor = .themeJeremy
        iconBackgroundView.layer.cornerRadius = lockoutIconBackgroundSideSize / 2
        iconBackgroundView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().multipliedBy(0.66)
            maker.size.equalTo(lockoutIconBackgroundSideSize)
        }

        addSubview(lockIcon)
        lockIcon.snp.makeConstraints { maker in
            maker.center.equalTo(iconBackgroundView)
            maker.centerY.equalToSuperview().multipliedBy(0.66)
        }
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(self.iconBackgroundView.snp.bottom).offset(CGFloat.margin6x)
            maker.leading.equalTo(self.snp.leading).offset(CGFloat.margin8x)
            maker.trailing.equalTo(self.snp.trailing).offset(-CGFloat.margin8x)
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
