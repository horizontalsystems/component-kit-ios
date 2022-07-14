import SkeletonView
import UIKit

public class CellWrapperView: UIView {
    private let borderLayer = CAShapeLayer()
    private let separatorLayer = CAShapeLayer()

    var viewBorderColor: UIColor?
    var viewSeparatorColor: UIColor?
    var viewBorderWidth: CGFloat = 0
    var viewSeparatorWidth: CGFloat = 0
    var viewBorders: UIRectEdge = [] {
        didSet {
            updateSubLayers()
        }
    }

    var viewCornerRadius: CGFloat = 0
    var viewCornerEdges: UIRectEdge = []

    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = true
        isSkeletonable = true
        layer.addSublayer(borderLayer)
        layer.addSublayer(separatorLayer)

        borderLayer.contentsScale = UIScreen.main.scale
        separatorLayer.contentsScale = UIScreen.main.scale
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateSubLayers() {
        borderLayer.frame = layer.bounds
        separatorLayer.frame = layer.bounds
        guard !borderLayer.frame.isEmpty,
              let cellBorderColor = viewBorderColor,
              let cellSeparatorColor = viewSeparatorColor
        else {
            borderLayer.path = nil
            return
        }

        let offset: CGFloat = min(viewBorderWidth, 1) / 2
        let topCorner = viewCornerEdges.contains(.top) ? viewCornerRadius : 0
        let bottomCorner = viewCornerEdges.contains(.bottom) ? viewCornerRadius : 0

        let zero = CGPoint(x: 0 + offset, y: 0 + offset)
        let max = CGPoint(x: borderLayer.frame.width - offset, y: borderLayer.frame.height - offset)

        let borderPath = UIBezierPath()
        let separatorPath = UIBezierPath()

        // left
        if viewBorders.contains(.left) {
            borderPath.move(to: CGPoint(x: zero.x, y: borderLayer.frame.height - bottomCorner))
            borderPath.addLine(to: CGPoint(x: zero.x, y: 0 + topCorner))
        }
        // topLeft Corner
        if !topCorner.isZero {
            borderPath.move(to: CGPoint(x: zero.x, y: zero.y + topCorner))
            borderPath.addArc(withCenter: CGPoint(x: zero.x + topCorner, y: zero.y + topCorner), radius: topCorner, startAngle: .pi, endAngle: -0.5 * .pi, clockwise: true)
        }
        // top
        if viewBorders.contains(.top) {
            let path = !topCorner.isZero ? borderPath : separatorPath
            path.move(to: CGPoint(x: zero.x + topCorner, y: zero.y))
            path.addLine(to: CGPoint(x: max.x - topCorner, y: zero.y))
        }
        // topRight Corner
        if !topCorner.isZero {
            borderPath.addArc(withCenter: CGPoint(x: max.x - topCorner, y: zero.y + topCorner), radius: topCorner, startAngle: 1.5 * .pi, endAngle: 2 * .pi, clockwise: true)
        }
        // right
        if viewBorders.contains(.right) {
            borderPath.move(to: CGPoint(x: max.x, y: 0 + topCorner))
            borderPath.addLine(to: CGPoint(x: max.x, y: borderLayer.frame.height - bottomCorner))
        }
        // bottom part
        if !bottomCorner.isZero {
            borderPath.addArc(withCenter: CGPoint(x: max.x - bottomCorner, y: max.y - bottomCorner), radius: bottomCorner, startAngle: 0, endAngle: 0.5 * .pi, clockwise: true)
        }
        if viewBorders.contains(.bottom) {
            borderPath.move(to: CGPoint(x: max.x - bottomCorner, y: max.y))
            borderPath.addLine(to: CGPoint(x: zero.x + bottomCorner, y: max.y))
        }
        if !bottomCorner.isZero {
            borderPath.addArc(withCenter: CGPoint(x: zero.x + bottomCorner, y: max.y - bottomCorner), radius: bottomCorner, startAngle: 0.5 * .pi, endAngle: .pi, clockwise: true)
        }

        borderLayer.path = borderPath.cgPath
        borderLayer.strokeColor = cellBorderColor.cgColor
        borderLayer.fillColor = nil
        borderLayer.lineWidth = viewBorderWidth

        separatorLayer.path = separatorPath.cgPath
        separatorLayer.strokeColor = cellSeparatorColor.cgColor
        separatorLayer.fillColor = nil
        separatorLayer.lineWidth = viewSeparatorWidth

        borderLayer.removeAllAnimations()
    }

    override public func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        updateSubLayers()
    }
}
