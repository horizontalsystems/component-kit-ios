import UIKit
import SkeletonView

public class CellWrapperView: UIView {
    private let borderLayer = CAShapeLayer()

    var viewBorderColor: UIColor?
    var viewBorderWidth: CGFloat = 0
    var viewBorders: UIRectEdge = [] {
        didSet {
            updateBorderLayer()
        }
    }

    var viewCornerRadius: CGFloat = 0
    var viewCornerEdges: UIRectEdge = []

    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = true
        isSkeletonable = true
        layer.addSublayer(borderLayer)

        borderLayer.contentsScale = UIScreen.main.scale
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateBorderLayer() {
        borderLayer.frame = layer.bounds
        guard !borderLayer.frame.isEmpty, let cellBorderColor = viewBorderColor else {
            borderLayer.path = nil
            return
        }

        let offset: CGFloat = viewBorderWidth / 2
        let topCorner = viewCornerEdges.contains(.top) ? viewCornerRadius : 0
        let bottomCorner = viewCornerEdges.contains(.bottom) ? viewCornerRadius : 0

        let zero = CGPoint(x: 0 + offset, y: 0 + offset)
        let max = CGPoint(x: borderLayer.frame.width - offset, y: borderLayer.frame.height - offset)
        let path = UIBezierPath()

        // left
        if viewBorders.contains(.left) {
            path.move(to: CGPoint(x: zero.x, y: borderLayer.frame.height - bottomCorner))
            path.addLine(to: CGPoint(x: zero.x, y: zero.y + topCorner))
        }
        // topLeft Corner
        if !topCorner.isZero {
            path.move(to: CGPoint(x: zero.x, y: zero.y + topCorner))
            path.addArc(withCenter: CGPoint(x: zero.x + topCorner, y: zero.y + topCorner), radius: topCorner, startAngle: .pi, endAngle: -0.5 * .pi, clockwise: true)
        }
        //top
        if viewBorders.contains(.top) {
            path.move(to: CGPoint(x: zero.x + topCorner, y: zero.y))
            path.addLine(to: CGPoint(x: max.x - topCorner, y: zero.y))
        }
        //topRight Corner
        if !topCorner.isZero {
            path.addArc(withCenter: CGPoint(x: max.x - topCorner, y: zero.y + topCorner), radius: topCorner, startAngle: 1.5 * .pi, endAngle: 2 * .pi, clockwise: true)
        }
        //right
        if viewBorders.contains(.right) {
            path.move(to: CGPoint(x: max.x, y: zero.y + topCorner))
            path.addLine(to: CGPoint(x: max.x, y: borderLayer.frame.height - bottomCorner))
        }
        //bottom part
        if !bottomCorner.isZero {
            path.addArc(withCenter: CGPoint(x: max.x - bottomCorner, y: max.y - bottomCorner), radius: bottomCorner, startAngle: 0, endAngle: 0.5 * .pi, clockwise: true)
        }
        if viewBorders.contains(.bottom) {
            path.move(to: CGPoint(x: max.x - bottomCorner, y: max.y))
            path.addLine(to: CGPoint(x: zero.x + bottomCorner, y: max.y))
        }
        if !bottomCorner.isZero {
        path.addArc(withCenter: CGPoint(x: zero.x + bottomCorner, y: max.y - bottomCorner), radius: bottomCorner, startAngle: 0.5 * .pi, endAngle: .pi, clockwise: true)
        }

        borderLayer.path = path.cgPath
        borderLayer.strokeColor = cellBorderColor.cgColor
        borderLayer.fillColor = nil
        borderLayer.lineWidth = viewBorderWidth

        borderLayer.removeAllAnimations()
    }

    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        updateBorderLayer()
    }

}
