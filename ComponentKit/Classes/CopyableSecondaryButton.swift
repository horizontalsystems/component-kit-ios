import UIKit

public class CopyableSecondaryButton: ThemeButton {

    public var viewItem = ViewItem(type: .raw, value: { "" }) {
        didSet {
            switch viewItem.type {
            case .image:
                apply(style: .secondaryIcon)
                setImage(ComponentKit.image(named: "copy_20"), for: .normal)
            case .title(let text):
                apply(style: .secondaryDefault)
                setTitle(text, for: .normal)
            case .raw:
                apply(style: .secondaryDefault)
                setTitle(viewItem.value(), for: .normal)
            }
        }
    }

    public var handler: ((ViewItem) -> ())?

    public override init() {
        super.init()

        addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onTapButton() {
        guard let handler = handler else {
            UIPasteboard.general.setValue(viewItem.value(), forPasteboardType: "public.plain-text")
            HudHelper.instance.showSuccess(title: "alert.copied".localized)
            return
        }

        handler(viewItem)
    }

}

extension CopyableSecondaryButton {

    public enum ViewItemType {
        case image
        case title(text: String)
        case raw
    }

    public struct ViewItem {
        public let type: ViewItemType
        public let value: () -> String

        public init(type: ViewItemType, value: @escaping () -> String) {
            self.type = type
            self.value = value
        }
    }

}

extension CopyableSecondaryButton {

    public static func height(containerWidth: CGFloat, viewItem: ViewItem) -> CGFloat {
        switch viewItem.type {
        case .image:
            return 28
        case .title(let text):
            return ThemeButton.size(containerWidth: containerWidth, text: text, style: .secondaryDefault).height
        case .raw:
            return ThemeButton.size(containerWidth: containerWidth, text: viewItem.value(), style: .secondaryDefault).height
        }
    }

}
