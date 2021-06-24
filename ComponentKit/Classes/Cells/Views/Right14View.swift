import UIKit
import SnapKit
import SkeletonView

open class Right14View: UIView {
    private let topLabel = UILabel()
    private let stackView = UIStackView()
    private let bottomLabel = UILabel()
    private let bottomTitleLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        isSkeletonable = true

        addSubview(topLabel)
        topLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(13)
        }

        topLabel.textAlignment = .right
        topLabel.font = .body
        topLabel.textColor = .themeLeah
        topLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        topLabel.isHiddenWhenSkeletonIsActive = true
        topLabel.isSkeletonable = true

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(topLabel.snp.bottom).offset(CGFloat.margin2)
        }

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = .margin4
        stackView.isHiddenWhenSkeletonIsActive = true
        stackView.isSkeletonable = true

        stackView.addArrangedSubview(UIView())

        stackView.addArrangedSubview(bottomTitleLabel)
        bottomTitleLabel.font = .caption
        bottomTitleLabel.textColor = .themeJacob
        bottomTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        stackView.addArrangedSubview(bottomLabel)
        bottomLabel.font = .caption
        bottomLabel.textColor = .themeGray
        bottomLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        buildSkeleton()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildSkeleton() {
        let topSkeleton = UIView()

        addSubview(topSkeleton)
        topSkeleton.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(CGFloat.margin12)
            maker.width.equalTo(88)
            maker.height.equalTo(16)
        }

        topSkeleton.isSkeletonable = true
        topSkeleton.skeletonCornerRadius = 8

        let bottomValueSkeleton = UIView()

        addSubview(bottomValueSkeleton)
        bottomValueSkeleton.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview()
            maker.top.equalTo(topSkeleton.snp.bottom).offset(6)
            maker.width.equalTo(32)
            maker.height.equalTo(14)
        }

        bottomValueSkeleton.isSkeletonable = true
        bottomValueSkeleton.skeletonCornerRadius = 7

        let bottomTitleSkeleton = UIView()

        addSubview(bottomTitleSkeleton)
        bottomTitleSkeleton.snp.makeConstraints { maker in
            maker.trailing.equalTo(bottomValueSkeleton.snp.leading).offset(-6)
            maker.top.equalTo(bottomValueSkeleton)
            maker.width.equalTo(32)
            maker.height.equalTo(14)
        }

        bottomTitleSkeleton.isSkeletonable = true
        bottomTitleSkeleton.skeletonCornerRadius = 7
    }

    public var topText: String? {
        get { topLabel.text }
        set { topLabel.text = newValue }
    }

    public var topTextColor: UIColor {
        get { topLabel.textColor }
        set { topLabel.textColor = newValue }
    }
    
    public var bottomTitleText: String? {
        get { bottomTitleLabel.text }
        set { bottomTitleLabel.text = newValue }
    }

    public var bottomText: String? {
        get { bottomLabel.text }
        set { bottomLabel.text = newValue }
    }

    public var bottomTextColor: UIColor {
        get { bottomLabel.textColor }
        set { bottomLabel.textColor = newValue }
    }

}
