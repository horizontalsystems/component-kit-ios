import UIKit
import UIExtensions
import SnapKit

open class DoubleRowButtonView: UIView {
    public static let height: CGFloat = 58

    private let leftButton = ThemeButton()
    private let rightButton = ThemeButton()

    private var onTapLeft: (() -> ())?
    private var onTapRight: (() -> ())?

    public init(leftButtonStyle: ThemeButtonStyle, rightButtonStyle: ThemeButtonStyle) {
        super.init(frame: .zero)

        let buttonWrapper = UIControl()     // disable touch events through cell to tableView

        addSubview(leftButton)
        leftButton.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview().offset(CGFloat.margin2x)
            maker.height.equalTo(CGFloat.heightButton)
        }

        leftButton.apply(style: leftButtonStyle)
        leftButton.addTarget(self, action: #selector(onLeft), for: .touchUpInside)

        addSubview(buttonWrapper)
        buttonWrapper.snp.makeConstraints { maker in
            maker.leading.equalTo(leftButton.snp.trailing).offset(CGFloat.margin2x)
            maker.top.equalTo(leftButton.snp.top)
            maker.trailing.equalToSuperview()
            maker.width.equalTo(leftButton.snp.width)
            maker.height.equalTo(CGFloat.heightButton)
        }

        addSubview(rightButton)
        rightButton.snp.makeConstraints { maker in
            maker.edges.equalTo(buttonWrapper.snp.edges)
        }

        rightButton.apply(style: rightButtonStyle)
        rightButton.addTarget(self, action: #selector(onRight), for: .touchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    public func bind(leftTitle: String, rightTitle: String) {
        leftButton.setTitle(leftTitle, for: .normal)
        rightButton.setTitle(rightTitle, for: .normal)
    }

    public func bind(leftEnabled: Bool, rightEnabled: Bool, leftAction: @escaping () -> (), rightAction: @escaping () -> ()) {
        leftButton.isEnabled = leftEnabled
        rightButton.isEnabled = rightEnabled

        onTapLeft = leftAction
        onTapRight = rightAction
    }

    @objc private func onLeft() {
        onTapLeft?()
    }

    @objc private func onRight() {
        onTapRight?()
    }

}
