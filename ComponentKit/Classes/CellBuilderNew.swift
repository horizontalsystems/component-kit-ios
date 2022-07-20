import UIKit
import SnapKit
import SectionsTableView
import ThemeKit

public class CellBuilderNew {
    public static let defaultMargin: CGFloat = .margin16
    public static let defaultLayoutMargins = UIEdgeInsets(top: 0, left: defaultMargin, bottom: 0, right: defaultMargin)

    public static func preparedCell(tableView: UITableView, indexPath: IndexPath, rootElement: CellElement, layoutMargins: UIEdgeInsets = defaultLayoutMargins) -> UITableViewCell {
        let reuseIdentifier = reuseIdentifier(rootElement: rootElement, layoutMargins: layoutMargins)
        tableView.register(BaseThemeCell.self, forCellReuseIdentifier: reuseIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let cell = cell as? BaseThemeCell {
            build(cell: cell, rootElement: rootElement, layoutMargins: layoutMargins)
        }
        return cell
    }

    public static func preparedSelectableCell(tableView: UITableView, indexPath: IndexPath, rootElement: CellElement, layoutMargins: UIEdgeInsets = defaultLayoutMargins) -> UITableViewCell {
        let reuseIdentifier = selectableReuseIdentifier(rootElement: rootElement, layoutMargins: layoutMargins)
        tableView.register(BaseSelectableThemeCell.self, forCellReuseIdentifier: reuseIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let cell = cell as? BaseThemeCell {
            build(cell: cell, rootElement: rootElement, layoutMargins: layoutMargins)
        }
        return cell
    }

    public static func row(
            rootElement: CellElement,
            layoutMargins: UIEdgeInsets = defaultLayoutMargins,
            tableView: UITableView,
            id: String,
            hash: String? = nil,
            height: CGFloat? = nil,
            rowActionProvider: (() -> [RowAction])? = nil,
            dynamicHeight: ((CGFloat) -> CGFloat)? = nil,
            bind: ((BaseThemeCell) -> ())? = nil
    ) -> RowProtocol {
        let reuseIdentifier = reuseIdentifier(rootElement: rootElement, layoutMargins: layoutMargins)

        tableView.register(BaseThemeCell.self, forCellReuseIdentifier: reuseIdentifier)

        return Row<BaseThemeCell>(
                id: id,
                hash: hash,
                height: height,
                rowActionProvider: rowActionProvider,
                rowType: .dynamic(reuseIdentifier: reuseIdentifier, prepare: { cell in
                    guard let cell = cell as? BaseThemeCell else {
                        return
                    }

                    build(cell: cell, rootElement: rootElement, layoutMargins: layoutMargins)
                }),
                dynamicHeight: dynamicHeight,
                bind: { cell, _ in bind?(cell) }
        )
    }

    public static func selectableRow(
            rootElement: CellElement,
            layoutMargins: UIEdgeInsets = defaultLayoutMargins,
            tableView: UITableView,
            id: String,
            hash: String? = nil,
            height: CGFloat? = nil,
            autoDeselect: Bool = false,
            rowActionProvider: (() -> [RowAction])? = nil,
            dynamicHeight: ((CGFloat) -> CGFloat)? = nil,
            bind: ((BaseThemeCell) -> ())? = nil,
            action: (() -> ())? = nil,
            actionWithCell: ((BaseThemeCell) -> ())? = nil
    ) -> RowProtocol {
        let reuseIdentifier = selectableReuseIdentifier(rootElement: rootElement, layoutMargins: layoutMargins)

        tableView.register(BaseSelectableThemeCell.self, forCellReuseIdentifier: reuseIdentifier)

        return Row<BaseSelectableThemeCell>(
                id: id,
                hash: hash,
                height: height,
                autoDeselect: autoDeselect,
                rowActionProvider: rowActionProvider,
                rowType: .dynamic(reuseIdentifier: reuseIdentifier, prepare: { cell in
                    guard let cell = cell as? BaseThemeCell else {
                        return
                    }

                    build(cell: cell, rootElement: rootElement, layoutMargins: layoutMargins)
                }),
                dynamicHeight: dynamicHeight,
                bind: { cell, _ in bind?(cell) },
                action: { cell in
                    action?()
                    actionWithCell?(cell)
                }
        )
    }

    public static func build(cell: BaseThemeCell, rootElement: CellElement, layoutMargins: UIEdgeInsets = defaultLayoutMargins) {
        if cell.id != nil {
            return
        }

        if let rootView = view(element: rootElement) {
            cell.wrapperView.addSubview(rootView)
            rootView.snp.makeConstraints { maker in
                maker.edges.equalToSuperview().inset(layoutMargins)
            }

            cell.rootView = rootView
        }

        cell.id = cellId(rootElement: rootElement, layoutMargins: layoutMargins)
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
            case .margin32: lastMargin = .margin32
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

    public static func stackComponent(axis: NSLayoutConstraint.Axis, elements: [CellElement], centered: Bool = false) -> StackComponent {
        let component = StackComponent(centered: centered)

        var lastView: UIView?
        var lastMargin: CGFloat?

        for element in elements {
            switch element {
            case .margin(let value): lastMargin = value
            case .margin0: lastMargin = 0
            case .margin4: lastMargin = .margin4
            case .margin8: lastMargin = .margin8
            case .margin12: lastMargin = .margin12
            case .margin16: lastMargin = .margin16
            case .margin24: lastMargin = .margin24
            case .margin32: lastMargin = .margin32
            default:
                if let view = view(element: element) {
                    if let last = lastMargin, let lastView = lastView {
                        component.stackView.setCustomSpacing(last, after: lastView)
                        lastMargin = nil
                    }

//                    view.backgroundColor = .themeSteel10
                    component.stackView.addArrangedSubview(view)
                    lastView = view
                }
            }
        }

        component.stackView.axis = axis
        component.stackView.distribution = .fill
        component.stackView.alignment = .fill
        component.stackView.spacing = defaultMargin

        return component
    }

    private static func view(element: CellElement) -> UIView? {
        switch element {
        case let .hStack(elements): return stackComponent(axis: .horizontal, elements: elements)
        case let .vStack(elements): return stackComponent(axis: .vertical, elements: elements)
        case let .vStackCentered(elements): return stackComponent(axis: .vertical, elements: elements, centered: true)

        case .text: return TextComponent()
        case .image16: return ImageComponent(size: .iconSize16)
        case .image20: return ImageComponent(size: .iconSize20)
        case .image24: return ImageComponent(size: .iconSize24)
        case .transactionImage: return TransactionImageComponent()
        case .switch: return SwitchComponent()
        case .primaryButton: return PrimaryButtonComponent()
        case .primaryCircleButton: return PrimaryCircleButtonComponent()
        case .secondaryButton: return SecondaryButtonComponent()
        case .secondaryCircleButton: return SecondaryCircleButtonComponent()
        case .transparentIconButton: return TransparentIconButtonComponent()
        case .badge: return BadgeComponent()
        case .spinner20: return SpinnerComponent(style: .small20)
        case .spinner24: return SpinnerComponent(style: .medium24)
        case .spinner48: return SpinnerComponent(style: .large48)
        case .determiniteSpinner20: return DeterminiteSpinnerComponent(size: .iconSize20)
        case .determiniteSpinner24: return DeterminiteSpinnerComponent(size: .iconSize24)
        case .determiniteSpinner48: return DeterminiteSpinnerComponent(size: .iconSize48)

        default: return nil
        }
    }

    private static func reuseIdentifier(rootElement: CellElement, layoutMargins: UIEdgeInsets = defaultLayoutMargins) -> String {
        "\(BaseThemeCell.self)|\(cellId(rootElement: rootElement, layoutMargins: layoutMargins))"
    }

    private static func selectableReuseIdentifier(rootElement: CellElement, layoutMargins: UIEdgeInsets = defaultLayoutMargins) -> String {
        "\(BaseSelectableThemeCell.self)|\(cellId(rootElement: rootElement, layoutMargins: layoutMargins))"
    }

    private static func cellId(rootElement: CellElement, layoutMargins: UIEdgeInsets) -> String {
        "\(rootElement.id)|\(Int(layoutMargins.top))-\(Int(layoutMargins.left))-\(Int(layoutMargins.bottom))-\(Int(layoutMargins.right))"
    }

}

extension CellBuilderNew {

    public enum CellElement {
        case hStack(_ elements: [CellElement])
        case vStack(_ elements: [CellElement])
        case vStackCentered(_ elements: [CellElement])

        case margin(_ value: CGFloat)
        case margin0
        case margin4
        case margin8
        case margin12
        case margin16
        case margin24
        case margin32

        case text
        case image16
        case image20
        case image24
        case transactionImage
        case `switch`
        case primaryButton
        case primaryCircleButton
        case secondaryButton
        case secondaryCircleButton
        case transparentIconButton
        case badge
        case spinner20
        case spinner24
        case spinner48
        case determiniteSpinner20
        case determiniteSpinner24
        case determiniteSpinner48

        var id: String {
            switch self {
            case let .hStack(elements): return "hStack[\(elements.map { $0.id }.joined(separator: "-"))]"
            case let .vStack(elements): return "vStack[\(elements.map { $0.id }.joined(separator: "-"))]"
            case let .vStackCentered(elements): return "vStackCentered[\(elements.map { $0.id }.joined(separator: "-"))]"

            case .margin(let value): return "margin\(value)"
            case .margin0: return "margin0"
            case .margin4: return "margin4"
            case .margin8: return "margin8"
            case .margin12: return "margin12"
            case .margin16: return "margin16"
            case .margin24: return "margin24"
            case .margin32: return "margin32"

            case .text: return "text"
            case .image16: return "image16"
            case .image20: return "image20"
            case .image24: return "image24"
            case .transactionImage: return "transactionImage"
            case .switch: return "switch"
            case .primaryButton: return "primaryButton"
            case .primaryCircleButton: return "primaryCircleButton"
            case .secondaryButton: return "secondaryButton"
            case .secondaryCircleButton: return "secondaryCircleButton"
            case .transparentIconButton: return "transparentIconButton"
            case .badge: return "badge"
            case .spinner20: return "spinner20"
            case .spinner24: return "spinner24"
            case .spinner48: return "spinner48"
            case .determiniteSpinner20: return "determiniteSpinner20"
            case .determiniteSpinner24: return "determiniteSpinner24"
            case .determiniteSpinner48: return "determiniteSpinner48"
            }
        }
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
        case margin32
    }

}
