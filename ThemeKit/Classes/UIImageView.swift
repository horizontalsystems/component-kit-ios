import UIKit
import Alamofire
import Kingfisher

extension UIImageView {

    public func asyncSetImage(imageBlock: @escaping () -> UIImage?) {
        DispatchQueue.global(qos: .userInitiated).async {
            let image = imageBlock()

            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

    public func setImage(withUrlString urlString: String, placeholder: UIImage?) {
        kf.setImage(with: URL(string: urlString), placeholder: placeholder, options: [.scaleFactor(UIScreen.main.scale)])
    }

}
