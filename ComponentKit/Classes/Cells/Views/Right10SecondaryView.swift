import UIKit
import SnapKit

open class Right10SecondaryView: UIView {
    private let stackView = UIStackView()

    public var onTapButton: ((Int) -> ())?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.bottom.equalToSuperview().inset(10)
        }

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.spacing = 8
        stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        stackView.setContentHuggingPriority(.required, for: .horizontal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func _onTapButton(_ button: UIButton) {
        onTapButton?(button.tag)
    }

    func set(viewItems: [D10SecondaryCell.ViewItem]) {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }

        viewItems.enumerated().forEach { index, viewItem in
            let button = ThemeButton()
            button.tag = index

            button.apply(style: .secondaryDefault)
            button.addTarget(self, action: #selector(_onTapButton(_:)), for: .touchUpInside)

            button.setTitle(viewItem.title, for: .normal)
            button.isEnabled = viewItem.enabled

            stackView.addArrangedSubview(button)
        }

        layoutSubviews()
    }

}
