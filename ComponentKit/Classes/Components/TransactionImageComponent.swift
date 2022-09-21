import UIKit
import SnapKit
import Kingfisher
import HUD

public class TransactionImageComponent: UIView {
    private let spinner = HUDProgressView(
            progress: 0,
            strokeLineWidth: 2,
            radius: 21,
            strokeColor: .themeGray,
            donutColor: .themeSteel10,
            duration: 2
    )

    private let imageView = UIImageView()

    private let doubleImageWrapper = UIView()
    private let backImageView = UIImageView()
    private let frontImageMask = UIView()
    private let frontImageView = UIImageView()

    init() {
        super.init(frame: .zero)

        addSubview(spinner)
        spinner.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.size.equalTo(44)
        }

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.center.equalTo(spinner)
            maker.size.equalTo(CGFloat.iconSize24)
        }

        imageView.cornerRadius = .cornerRadius4

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

        imageView.image = nil
        imageView.kf.setImage(with: urlString.flatMap { URL(string: $0) }, placeholder: placeholder, options: [.onlyLoadFirstFrame, .transition(.fade(0.5))])
    }

    public func setDoubleImage(frontType: ImageType, frontUrl: String?, frontPlaceholder: UIImage?, backType: ImageType, backUrl: String?, backPlaceholder: UIImage?) {
        imageView.isHidden = true
        doubleImageWrapper.isHidden = false

        switch frontType {
        case .circle:
            frontImageView.cornerRadius = CGFloat.iconSize20 / 2
            frontImageMask.cornerRadius = CGFloat.iconSize20 / 2
        case .squircle:
            frontImageView.cornerRadius = .cornerRadius4
            frontImageMask.cornerRadius = .cornerRadius4
        }

        switch backType {
        case .circle:
            backImageView.cornerRadius = CGFloat.iconSize20 / 2
        case .squircle:
            backImageView.cornerRadius = .cornerRadius4
        }

        frontImageView.image = nil
        backImageView.image = nil

        frontImageView.kf.setImage(with: frontUrl.flatMap { URL(string: $0) }, placeholder: frontPlaceholder)
        backImageView.kf.setImage(with: backUrl.flatMap { URL(string: $0) }, placeholder: backPlaceholder)
    }

}

extension TransactionImageComponent {

    public enum ImageType {
        case circle
        case squircle
    }

}
