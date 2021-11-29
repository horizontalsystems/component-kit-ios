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
        image = placeholder

        if let url = URL(string: urlString) {
            kf.setImage(with: url, placeholder: placeholder)
        }
    }

}
