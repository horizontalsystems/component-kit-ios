import UIKit
import SnapKit

open class BottomDescriptionView: UIView {
    private static let sideMargin: CGFloat = .margin32
    private static let topMargin: CGFloat = .margin12
    private static let bottomMargin: CGFloat = .margin32
    private static let font: UIFont = .subhead2

    private let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        label.numberOfLines = 0
        label.font = BottomDescriptionView.font
        label.textColor = .themeGray

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(BottomDescriptionView.sideMargin)
            maker.top.equalToSuperview().offset(BottomDescriptionView.topMargin)
            maker.bottom.equalToSuperview().inset(BottomDescriptionView.bottomMargin)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(text: String?) {
        label.text = text
    }

}

extension BottomDescriptionView {

    public static func height(containerWidth: CGFloat, text: String) -> CGFloat {
        let textHeight = text.height(forContainerWidth: containerWidth - 2 * BottomDescriptionView.sideMargin, font: BottomDescriptionView.font)
        return textHeight + BottomDescriptionView.topMargin + BottomDescriptionView.bottomMargin
    }

}
