import UIKit
import SnapKit
import Kingfisher
import HUD

public class TransactionImageComponent: UIView {
    private let spinner = HUDProgressView(
            progress: 0,
            strokeLineWidth: 2,
            radius: 19,
            strokeColor: .themeGray,
            donutColor: .themeSteel10,
            duration: 2
    )

    private let imageView = UIImageView()

    private let doubleImageWrapper = UIView()
    private let backImageView = UIImageView()
    private let frontImageView = UIImageView()

    init() {
        super.init(frame: .zero)

        addSubview(spinner)
        spinner.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.size.equalTo(40)
        }

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.center.equalTo(spinner)
            maker.size.equalTo(CGFloat.iconSize24)
        }

        addSubview(doubleImageWrapper)
        doubleImageWrapper.snp.makeConstraints { maker in
            maker.center.equalTo(spinner)
            maker.size.equalTo(28)
        }

        doubleImageWrapper.addSubview(backImageView)
        backImageView.snp.makeConstraints { maker in
            maker.leading.top.equalToSuperview()
            maker.size.equalTo(CGFloat.iconSize20)
        }

        let frontImageMask = UIView()

        doubleImageWrapper.addSubview(frontImageMask)
        doubleImageWrapper.addSubview(frontImageView)

        frontImageView.snp.makeConstraints { maker in
            maker.trailing.bottom.equalToSuperview()
            maker.size.equalTo(CGFloat.iconSize20)
        }

        frontImageMask.snp.makeConstraints { maker in
            maker.size.equalTo(frontImageView)
            maker.center.equalTo(frontImageView).offset(-1)
        }

        frontImageMask.backgroundColor = .themeTyler
        frontImageMask.cornerRadius = 10
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(progress: Float?) {
        if let progress = progress {
            spinner.isHidden = false
            spinner.set(progress: progress)
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
            spinner.isHidden = true
        }
    }

    public func set(image: UIImage?) {
        doubleImageWrapper.isHidden = true
        imageView.isHidden = false

        imageView.image = image
    }

    public func setImage(urlString: String?, placeholder: UIImage?) {
        doubleImageWrapper.isHidden = true
        imageView.isHidden = false

        imageView.kf.setImage(with: urlString.flatMap { URL(string: $0) }, placeholder: placeholder, options: [.scaleFactor(UIScreen.main.scale)])
    }

    public func setDoubleImage(frontUrlString: String?, frontPlaceholder: UIImage?, backUrlString: String?, backPlaceholder: UIImage?) {
        imageView.isHidden = true
        doubleImageWrapper.isHidden = false

        frontImageView.kf.setImage(with: frontUrlString.flatMap { URL(string: $0) }, placeholder: frontPlaceholder)
        backImageView.kf.setImage(with: backUrlString.flatMap { URL(string: $0) }, placeholder: backPlaceholder)
    }

}
