import UIKit
import SnapKit

open class Right6View: UIView {
    private let label = UILabel()
    private let imageView = UIImageView()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        label.font = .subhead1
        label.textColor = .themeLeah

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.equalTo(label.snp.trailing).offset(CGFloat.margin2x)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.size.equalTo(CGFloat.iconSize20)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }

    public var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    public var imageTintColor: UIColor? {
        get { imageView.tintColor }
        set { imageView.tintColor = newValue }
    }

    public var textColor: UIColor {
        get { label.textColor }
        set { label.textColor = newValue }
    }

}
