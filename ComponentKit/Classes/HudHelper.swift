import UIKit
import HUD
import SnapKit

public class HudHelper {
    public static let instance = HudHelper()

    private enum ImageType { case success, error, attention }

    public func showSuccess(title: String? = nil, subtitle: String? = nil) {
        show(type: .success, title: title, subtitle: subtitle)
    }

    public func showError(title: String? = nil, subtitle: String? = nil) {
        show(type: .error, title: title, subtitle: subtitle)
    }

    public func showAttention(title: String? = nil, subtitle: String? = nil) {
        show(type: .attention, title: title, subtitle: subtitle)
    }

    public func showSpinner(title: String? = nil, userInteractionEnabled: Bool = false) {
        var customConfig = themeConfigHud()
        customConfig.hapticType = nil
        customConfig.userInteractionEnabled = userInteractionEnabled

        HUD.instance.config = customConfig

        let statusConfig = configStatusModel()

        statusConfig.dismissTimeInterval = nil
        statusConfig.customShowCancelInterval = nil

        HUDStatusFactory.instance.config = statusConfig

        let activityView = HUDActivityView.create(with: .large48)
        activityView.snp.removeConstraints()

        var titleLabel: UILabel?
        if let title = title {
            titleLabel = UILabel()
            titleLabel?.font = statusConfig.titleLabelFont
            titleLabel?.textColor = statusConfig.titleLabelColor
            titleLabel?.numberOfLines = statusConfig.titleLabelLinesCount
            titleLabel?.textAlignment = statusConfig.titleLabelAlignment
            titleLabel?.text = title
        }

        let content = HUDStatusView(frame: .zero, imageView: activityView, titleLabel: titleLabel, subtitleLabel: nil, config: statusConfig)
        HUD.instance.showHUD(content, onTapHUD: { hud in
            hud.hide()
        })

        activityView.startAnimating()
    }

    public func hide() {
        HUD.instance.hide()
    }

    private func show(type: ImageType, title: String?, subtitle: String?) {
        var statusConfig = configStatusModel()

        let statusImage: UIImage?
        switch type {
        case .success: statusImage = ComponentKit.image(named: "checkmark_48")
        case .error:
            statusImage = ComponentKit.image(named: "close_48")
            statusConfig.imageTintColor = .themeOz
        case .attention: statusImage = ComponentKit.image(named: "attention_48")
        }

        guard let image = statusImage else {
            return
        }

        HUD.instance.config = themeConfigHud()

        let textLength = (title?.count ?? 0) + (subtitle?.count ?? 0)
        let textReadDelay = min(max(1, Double(textLength) / 10), 3)

        statusConfig.dismissTimeInterval = textReadDelay

        HUDStatusFactory.instance.config = statusConfig

        let content = HUDStatusFactory.instance.view(type: .custom(image), title: title, subtitle: subtitle)
        HUD.instance.showHUD(content, onTapHUD: { hud in
            hud.hide()
        })
    }

    private func themeConfigHud() -> HUDConfig {
        var config = HUDConfig()
        config.style = .center
        config.startAdjustSize = 0.8
        config.finishAdjustSize = 0.8
        config.preferredSize = CGSize(width: 146, height: 114)
        config.backgroundColor = UIColor.themeTyler.withAlphaComponent(0.4)//todo .4 does not work for theme, it needs themed color. But it's not working without 0.4 as well
        config.blurEffectStyle = .themeHud

        return config
    }

    private func configStatusModel() -> HUDStatusModel {
        let config = HUDStatusFactory.instance.config
        config.titleLabelFont = .subhead1
        config.titleLabelColor = .themeOz

        config.subtitleLabelFont = .subhead1
        config.subtitleLabelColor = .themeOz

        return config
    }

}
