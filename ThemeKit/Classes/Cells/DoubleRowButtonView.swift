import UIKit
import SnapKit

open class DoubleRowButtonView: UIView {
    private let leftButton: UIButton
    private let rightButton: UIButton

    private var onTapLeft: (() -> ())?
    private var onTapRight: (() -> ())?

    public init(leftButton: UIButton, rightButton: UIButton) {
        self.leftButton = leftButton
        self.rightButton = rightButton

        super.init(frame: .zero)

        let buttonWrapper = UIControl()     // disable touch events through cell to tableView

        addSubview(leftButton)
        leftButton.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(CGFloat.margin2x)
            maker.top.equalToSuperview().offset(CGFloat.margin3x)
            maker.height.equalTo(CGFloat.heightButton)
        }

        leftButton.addTarget(self, action: #selector(onLeft), for: .touchUpInside)

        addSubview(buttonWrapper)
        buttonWrapper.snp.makeConstraints { maker in
            maker.leading.equalTo(leftButton.snp.trailing).offset(CGFloat.margin2x)
            maker.top.equalTo(leftButton.snp.top)
            maker.trailing.equalToSuperview().inset(CGFloat.margin2x)
            maker.width.equalTo(leftButton.snp.width)
            maker.height.equalTo(CGFloat.heightButton)
        }

        addSubview(rightButton)
        rightButton.snp.makeConstraints { maker in
            maker.edges.equalTo(buttonWrapper.snp.edges)
        }

        rightButton.addTarget(self, action: #selector(onRight), for: .touchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    public func bind(left: (title: String, enabled: Bool?, action: (() -> ())?), right: (title: String, enabled: Bool?, action: (() -> ())?), animated: Bool) {
        leftButton.setTitle(left.title, for: .normal)
        rightButton.setTitle(right.title, for: .normal)

        if let enabled = left.enabled {
            leftButton.set(hidden: false, animated: animated, duration: CardCell.animationDuration)
            leftButton.isEnabled = enabled
        } else {
            leftButton.set(hidden: true, animated: animated, duration: CardCell.animationDuration)
        }

        if let enabled = right.enabled {
            rightButton.set(hidden: false, animated: animated, duration: CardCell.animationDuration)
            rightButton.isEnabled = enabled
        } else {
            rightButton.set(hidden: true, animated: animated, duration: CardCell.animationDuration)
        }

        onTapLeft = left.action
        onTapRight = right.action
    }

    @objc private func onLeft() {
        onTapLeft?()
    }

    @objc private func onRight() {
        onTapRight?()
    }

}
