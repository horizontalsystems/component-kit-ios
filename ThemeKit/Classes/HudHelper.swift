import UIKit
import HUD

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

        let content = HUDActivityView(
                dashHeight: 10,
                dashStrokeWidth: 4,
                radius: 20,
                strokeColor: .gray,
                duration: 0.834
        )

        HUD.instance.showHUD(content, onTapHUD: { hud in
            hud.hide()
        })

        content.startAnimating()
   }

    public func hide() {
        HUD.instance.hide()
    }

    private func show(type: ImageType, title: String?, subtitle: String?) {
        let statusImage: UIImage?
        switch type {
        case .success: statusImage = ThemeKit.image(named: "checkmark_48")
        case .error: statusImage = ThemeKit.image(named: "close_48")?.tinted(with: .themeOz)
        case .attention: statusImage = ThemeKit.image(named: "Hud Attention Icon")
        }

        guard let image = statusImage else {
            return
        }

        HUD.instance.config = themeConfigHud()

        let statusConfig = configStatusModel()

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
        config.backgroundColor = UIColor.themeTyler.withAlphaComponent(0.4)
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
