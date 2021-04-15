import UIKit

public class CopyableSecondaryButton: ThemeButton {

    public var viewItem: ViewItem? {
        didSet {
            setTitle(viewItem?.text, for: .normal)
        }
    }

    public override init() {
        super.init()

        apply(style: .secondaryDefault)
        addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onTapButton() {
        guard let viewItem = viewItem else {
            return
        }

        UIPasteboard.general.setValue(viewItem.value, forPasteboardType: "public.plain-text")
        HudHelper.instance.showSuccess(title: "alert.copied".localized)
    }

}

extension CopyableSecondaryButton {

    public struct ViewItem {
        public let title: String?
        public let value: String

        public init(title: String? = nil, value: String) {
            self.title = title
            self.value = value
        }

        var text: String {
            title ?? value
        }
    }

}

extension CopyableSecondaryButton {

    public static func height(containerWidth: CGFloat, viewItem: ViewItem) -> CGFloat {
        ThemeButton.size(containerWidth: containerWidth, text: viewItem.text, style: .secondaryDefault).height
    }

}
