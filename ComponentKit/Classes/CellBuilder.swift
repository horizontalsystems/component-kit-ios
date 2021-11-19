import UIKit
import SnapKit
import SectionsTableView

public class CellBuilder {
    public static let defaultMargin: CGFloat = .margin16
    public static let defaultLayoutMargins = UIEdgeInsets(top: 0, left: defaultMargin, bottom: 0, right: defaultMargin)

    public static func row(
            elements: [CellElement],
            layoutMargins: UIEdgeInsets = defaultLayoutMargins,
            tableView: UITableView,
            id: String,
            hash: String? = nil,
            height: CGFloat? = nil,
            rowActionProvider: (() -> [RowAction])? = nil,
            dynamicHeight: ((CGFloat) -> CGFloat)? = nil,
            bind: ((BaseThemeCell) -> ())? = nil
    ) -> RowProtocol {
        let cellId = cellId(elements: elements, layoutMargins: layoutMargins)

        tableView.register(BaseThemeCell.self, forCellReuseIdentifier: cellId)

        return Row<BaseThemeCell>(
                id: id,
                hash: hash,
                height: height,
                rowActionProvider: rowActionProvider,
                rowType: .dynamic(reuseIdentifier: cellId, prepare: { cell in
                    guard let cell = cell as? BaseThemeCell else {
                        return
                    }

                    build(cell: cell, elements: elements, layoutMargins: layoutMargins)
                }),
                dynamicHeight: dynamicHeight,
                bind: { cell, _ in bind?(cell) }
        )
    }

    public static func selectableRow(
            elements: [CellElement],
            layoutMargins: UIEdgeInsets = defaultLayoutMargins,
            tableView: UITableView,
            id: String,
            hash: String? = nil,
            height: CGFloat? = nil,
            autoDeselect: Bool = false,
            rowActionProvider: (() -> [RowAction])? = nil,
            dynamicHeight: ((CGFloat) -> CGFloat)? = nil,
            bind: ((BaseThemeCell) -> ())? = nil,
            action: (() -> ())? = nil
    ) -> RowProtocol {
        let cellId = cellId(elements: elements, layoutMargins: layoutMargins)

        tableView.register(BaseSelectableThemeCell.self, forCellReuseIdentifier: cellId)

        return Row<BaseSelectableThemeCell>(
                id: id,
                hash: hash,
                height: height,
                autoDeselect: autoDeselect,
                rowActionProvider: rowActionProvider,
                rowType: .dynamic(reuseIdentifier: cellId, prepare: { cell in
                    guard let cell = cell as? BaseThemeCell else {
                        return
                    }

                    build(cell: cell, elements: elements, layoutMargins: layoutMargins)
                }),
                dynamicHeight: dynamicHeight,
                bind: { cell, _ in bind?(cell) },
                action: { _ in action?() }
        )
    }

    public static func build(cell: BaseThemeCell, elements: [CellElement], layoutMargins: UIEdgeInsets = defaultLayoutMargins) {
        if cell.id != nil {
            return
        }

        var lastView: UIView?
        var lastMargin: CGFloat?

        for element in elements {
            switch element {
            case .margin0: lastMargin = 0
            case .margin4: lastMargin = .margin4
            case .margin8: lastMargin = .margin8
            case .margin12: lastMargin = .margin12
            case .margin16: lastMargin = .margin16
            case .margin24: lastMargin = .margin24
            default:
                if let view = view(element: element) {
                    if let last = lastMargin, let lastView = lastView {
                        cell.stackView.setCustomSpacing(last, after: lastView)
                        lastMargin = nil
                    }

                    cell.stackView.addArrangedSubview(view)
                    lastView = view
                }
            }
        }

        cell.stackView.spacing = defaultMargin
        cell.stackView.layoutMargins = layoutMargins
        cell.stackView.isLayoutMarginsRelativeArrangement = true

        cell.id = cellId(elements: elements, layoutMargins: layoutMargins)
    }

    public static func height(containerWidth: CGFloat, backgroundStyle: BaseThemeCell.BackgroundStyle, text: String, textStyle: TextComponent.Style, verticalPadding: CGFloat = defaultMargin, elements: [LayoutElement]) -> CGFloat {
        var textWidth = containerWidth - BaseThemeCell.margin(backgroundStyle: backgroundStyle).width

        var lastMargin = defaultMargin

        for element in elements {
            switch element {
            case .margin0: lastMargin = 0
            case .margin4: lastMargin = .margin4
            case .margin8: lastMargin = .margin8
            case .margin12: lastMargin = .margin12
            case .margin16: lastMargin = .margin16
            case .margin24: lastMargin = .margin24
            case .fixed(let width):
                textWidth -= lastMargin + width
                lastMargin = defaultMargin
            case .multiline:
                textWidth -= lastMargin
                lastMargin = defaultMargin
            }
        }

        textWidth -= lastMargin

        return text.height(forContainerWidth: textWidth, font: textStyle.font) + 2 * verticalPadding
    }

    private static func view(element: CellElement) -> UIView? {
        switch element {
        case .text: return TextComponent()
        case .multiText: return MultiTextComponent()
        case .image: return ImageComponent()
        case .switch: return SwitchComponent()
        case .primaryButton: return PrimaryButtonComponent()
        case .primaryCircleButton: return PrimaryCircleButtonComponent()
        case .secondaryButton: return SecondaryButtonComponent()
        case .secondaryCircleButton: return SecondaryCircleButtonComponent()
        case .transparentIconButton: return TransparentIconButtonComponent()
        case .badge: return BadgeComponent()
        default: return nil
        }
    }

    private static func cellId(elements: [CellElement], layoutMargins: UIEdgeInsets) -> String {
        "\(elements.map { $0.rawValue }.joined(separator: "-"));\(layoutMargins.top)-\(layoutMargins.left)-\(layoutMargins.bottom)-\(layoutMargins.right)"
    }

}

extension CellBuilder {

    public enum CellElement: String {
        case text
        case multiText
        case image
        case `switch`
        case primaryButton
        case primaryCircleButton
        case secondaryButton
        case secondaryCircleButton
        case transparentIconButton
        case badge

        case margin0
        case margin4
        case margin8
        case margin12
        case margin16
        case margin24
    }

    public enum LayoutElement {
        case fixed(width: CGFloat)
        case multiline

        case margin0
        case margin4
        case margin8
        case margin12
        case margin16
        case margin24
    }

}
