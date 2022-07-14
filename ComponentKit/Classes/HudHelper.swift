import UIKit
import HUD

public class HudHelper {
    public static let instance = HudHelper()

    private enum ImageType { case success, error, attention }

    private func show(type: ImageType, title: String?, subtitle: String?) {
        let statusConfig = configStatusModel()

        let statusImage: UIImage?
        switch type {
        case .success: statusImage = ComponentKit.image(named: "checkmark_48")
        case .error:
            statusImage = ComponentKit.image(named: "close_48")
            statusConfig.imageTintColor = .themeLeah
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
        config.appearStyle = .alphaAppear
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
        config.titleLabelColor = .themeLeah

        config.subtitleLabelFont = .subhead1
        config.subtitleLabelColor = .themeLeah

        return config
    }

}

extension HudHelper {

    public func showSuccess(title: String? = nil, subtitle: String? = nil) {
        show(type: .success, title: title, subtitle: subtitle)
    }

    public func showError(title: String? = nil, subtitle: String? = nil) {
        show(type: .error, title: title, subtitle: subtitle)
    }

    public func showAttention(title: String? = nil, subtitle: String? = nil) {
        show(type: .attention, title: title, subtitle: subtitle)
    }

    public func showSuccessBanner() {
        show(banner: .success)
    }

    public func showErrorBanner(title: String) {
        show(banner: .error(string: title))
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

}

extension HudHelper {

    private func show(banner: BannerType) {
        var config = HUDConfig()

        config.style = .banner(.top)
        config.appearStyle = .moveOut
        config.userInteractionEnabled = banner.isUserInteractionEnabled
        config.preferredSize = CGSize(width: 114, height: 56)

        config.coverBlurEffectStyle = nil
        config.coverBlurEffectIntensity = nil
        config.coverBackgroundColor = .themeBlack50

        config.blurEffectStyle = .themeHud
        config.backgroundColor = .themeAndy
        config.blurEffectIntensity = 0.4

        config.cornerRadius = 28

        let viewItem = HUD.ViewItem(
                icon: banner.icon,
                iconColor: banner.color,
                title: banner.title,
                showingTime: banner.showingTime,
                isLoading: banner.isLoading
        )

        HUD.instance.show(config: config, viewItem: viewItem, forced: banner.forced)
    }

    private enum BannerType {
        case success
        case error(string: String)

        var icon: UIImage? {
            let image: UIImage?
            switch self {
            case .success: image = UIImage(named: "circle_check_24")
            case .error: image = UIImage(named: "warning_2_24")
            }
            return image?.withRenderingMode(.alwaysTemplate)
        }

        var color: UIColor {
            switch self {
            case .error: return .themeLucian
            case .success: return .themeRemus
            }
        }

        var title: String {
            switch self {
            case .success: return "alert.copied".localized
            case .error(let description): return description
            }
        }

        var showingTime: TimeInterval? {
            2
        }

        var isLoading: Bool {
            false
        }

        var isUserInteractionEnabled: Bool {
            true
        }

        var forced: Bool {
            true
        }

    }

}
