import UIKit

public extension UIButton {

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))

        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(UIColor.white.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))

            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            setBackgroundImage(image?.withTintColor(color), for: state)
        }
    }

}

extension UIView {

    @IBInspectable
    open var cornerCurve: CALayerCornerCurve {
        get {
            layer.cornerCurve
        }
        set {
            layer.cornerCurve = newValue
        }
    }

}

extension UIRectEdge {
    var toArray: [UIRectEdge] {
        let all: [UIRectEdge] = [.top, .right, .bottom, .left]
        return all.filter { edge in contains(edge) }
    }

    var corners: [UIRectCorner] {
        var corners = [UIRectCorner]()
        if self.contains([.top, .left]) { corners.append(.topLeft) }
        if self.contains([.top, .right]) { corners.append(.topRight) }
        if self.contains([.bottom, .left]) { corners.append(.bottomLeft) }
        if self.contains([.bottom, .right]) { corners.append(.bottomRight) }
        return corners
    }
}
