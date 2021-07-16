import UIKit
import SnapKit
import HUD

open class LeftHView: UIView {
    private let imageView = UIImageView()
    private let spinnerView = HUDProgressView(
            progress: 0,
            strokeLineWidth: 2,
            radius: 15,
            strokeColor: .themeGray,
            donutColor: .themeSteel10,
            duration: 2
    )
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(CGFloat.margin16)
            maker.centerY.equalToSuperview()
            maker.size.equalTo(CGFloat.iconSize20)
        }

        imageView.clipsToBounds = true

        addSubview(spinnerView)
        spinnerView.snp.makeConstraints { maker in
            maker.center.equalTo(imageView)
            maker.size.equalTo(32)
        }

        spinnerView.isHidden = true

        addSubview(topLabel)
        topLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(CGFloat.margin16)
            maker.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(10)
        }

        topLabel.font = .body
        topLabel.textColor = .themeOz

        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(topLabel.snp.leading)
            maker.top.equalTo(topLabel.snp.bottom).offset(3)
            maker.trailing.equalToSuperview()
        }

        bottomLabel.font = .subhead2
        bottomLabel.textColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    public var imageTintColor: UIColor? {
        get { imageView.tintColor }
        set { imageView.tintColor = newValue }
    }

    public var topText: String? {
        get { topLabel.text }
        set { topLabel.text = newValue }
    }

    public var topTextColor: UIColor {
        get { topLabel.textColor }
        set { topLabel.textColor = newValue }
    }

    public var bottomText: String? {
        get { bottomLabel.text }
        set { bottomLabel.text = newValue }
    }

    public func set(spinnerProgress: Float?) {
        if let progress = spinnerProgress {
            spinnerView.isHidden = false
            spinnerView.set(progress: progress)

            if !spinnerView.isAnimating {
                spinnerView.startAnimating()
            }
        } else {
            spinnerView.isHidden = true
            spinnerView.stopAnimating()
        }
    }

}
