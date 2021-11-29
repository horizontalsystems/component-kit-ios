import UIKit
import SnapKit
import SkeletonView
import Kingfisher

open class LeftGView: UIView {
    private let imageView = UIImageView()
    private let topLabel = UILabel()
    private let stackView = UIStackView()
    private let leftBadgeView = BadgeView()
    private let bottomLabel = UILabel()
    private let rightBadgeView = BadgeView()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        isSkeletonable = true

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.size.equalTo(CGFloat.iconSize24)
        }

        imageView.clipsToBounds = true
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.isHiddenWhenSkeletonIsActive = true
        imageView.isSkeletonable = true

        addSubview(topLabel)
        topLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(CGFloat.margin16)
            maker.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(10)
        }

        topLabel.font = .body
        topLabel.textColor = .themeOz
        topLabel.isHiddenWhenSkeletonIsActive = true
        topLabel.isSkeletonable = true

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.leading.equalTo(topLabel.snp.leading)
            maker.top.equalTo(topLabel.snp.bottom).offset(5)
            maker.trailing.equalToSuperview()
        }

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = .margin8
        stackView.isHiddenWhenSkeletonIsActive = true
        stackView.isSkeletonable = true

        stackView.addArrangedSubview(leftBadgeView)
        leftBadgeView.isHidden = true
        leftBadgeView.font = .microSB

        stackView.addArrangedSubview(bottomLabel)
        bottomLabel.font = .subhead2
        bottomLabel.textColor = .themeGray

        stackView.addArrangedSubview(rightBadgeView)
        rightBadgeView.isHidden = true
        rightBadgeView.font = .microSB

        stackView.addArrangedSubview(UIView())

        buildSkeleton()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildSkeleton() {
        let imageSkeleton = UIView()

        addSubview(imageSkeleton)
        imageSkeleton.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.size.equalTo(CGFloat.iconSize24)
        }

        imageSkeleton.isSkeletonable = true
        imageSkeleton.skeletonCornerRadius = 12

        let titleSkeleton = UIView()

        addSubview(titleSkeleton)
        titleSkeleton.snp.makeConstraints { maker in
            maker.leading.equalTo(imageSkeleton.snp.trailing).offset(CGFloat.margin16)
            maker.top.equalToSuperview().offset(CGFloat.margin12)
            maker.width.equalTo(90)
            maker.height.equalTo(16)
        }

        titleSkeleton.isSkeletonable = true
        titleSkeleton.skeletonCornerRadius = 8

        let badgeSkeleton = UIView()

        addSubview(badgeSkeleton)
        badgeSkeleton.snp.makeConstraints { maker in
            maker.leading.equalTo(titleSkeleton)
            maker.top.equalTo(titleSkeleton.snp.bottom).offset(6)
            maker.size.equalTo(14)
        }

        badgeSkeleton.isSkeletonable = true
        badgeSkeleton.skeletonCornerRadius = 7

        let subtitleSkeleton = UIView()

        addSubview(subtitleSkeleton)
        subtitleSkeleton.snp.makeConstraints { maker in
            maker.leading.equalTo(badgeSkeleton.snp.trailing).offset(6)
            maker.top.equalTo(badgeSkeleton)
            maker.width.equalTo(42)
            maker.height.equalTo(14)
        }

        subtitleSkeleton.isSkeletonable = true
        subtitleSkeleton.skeletonCornerRadius = 7
    }

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    public var imageTintColor: UIColor? {
        get { imageView.tintColor }
        set { imageView.tintColor = newValue }
    }

    public var imageCornerRadius: CGFloat {
        get { imageView.layer.cornerRadius }
        set { imageView.layer.cornerRadius = newValue }
    }

    public var imageBackgroundColor: UIColor? {
        get { imageView.backgroundColor }
        set { imageView.backgroundColor = newValue }
    }

    public var topText: String? {
        get { topLabel.text }
        set { topLabel.text = newValue }
    }

    public var bottomText: String? {
        get { bottomLabel.text }
        set { bottomLabel.text = newValue }
    }

    public var leftBadgeText: String? {
        get { leftBadgeView.text }
        set {
            leftBadgeView.text = newValue
            leftBadgeView.isHidden = newValue == nil
        }
    }

    public var leftBadgeTextColor: UIColor {
        get { leftBadgeView.textColor }
        set { leftBadgeView.textColor = newValue }
    }

    public var leftBadgeBackgroundColor: UIColor? {
        get { leftBadgeView.backgroundColor }
        set { leftBadgeView.backgroundColor = newValue }
    }

    public var rightBadgeText: String? {
        get { rightBadgeView.text }
        set {
            rightBadgeView.text = newValue
            rightBadgeView.isHidden = newValue == nil
        }
    }

    public var rightBadgeTextColor: UIColor {
        get { rightBadgeView.textColor }
        set { rightBadgeView.textColor = newValue }
    }

    public var rightBadgeBackgroundColor: UIColor? {
        get { rightBadgeView.backgroundColor }
        set { rightBadgeView.backgroundColor = newValue }
    }

    public func setImage(urlString: String?, placeholder: UIImage?) {
        imageView.kf.setImage(with: urlString.flatMap { URL(string: $0) }, placeholder: placeholder, options: [.scaleFactor(UIScreen.main.scale)])
    }

}
