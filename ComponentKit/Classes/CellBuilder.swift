import UIKit
import SnapKit
import SectionsTableView

public class CellBuilder {
    public static let defaultMargin: CGFloat = .margin16

    public static func row(
            elements: [CellElement],
            tableView: UITableView,
            id: String,
            hash: String? = nil,
            height: CGFloat? = nil,
            rowActionProvider: (() -> [RowAction])? = nil,
            dynamicHeight: ((CGFloat) -> CGFloat)? = nil,
            bind: ((BaseThemeCell) -> ())? = nil
    ) -> RowProtocol {
        let cellId = elements.cellId

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

                    build(cell: cell, elements: elements)
                }),
                dynamicHeight: dynamicHeight,
                bind: { cell, _ in bind?(cell) }
        )
    }

    public static func selectableRow(
            elements: [CellElement],
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
        let cellId = elements.cellId

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

                    build(cell: cell, elements: elements)
                }),
                dynamicHeight: dynamicHeight,
                bind: { cell, _ in bind?(cell) },
                action: { _ in action?() }
        )
    }

    public static func build(cell: BaseThemeCell, elements: [CellElement]) {
        if cell.id != nil {
            return
        }

        var lastView: UIView?
        var lastMargin = defaultMargin

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
                    cell.componentView.addSubview(view)
                    view.snp.makeConstraints { maker in
                        if let lastView = lastView {
                            maker.leading.equalTo(lastView.snp.trailing).offset(lastMargin)
                        } else {
                            maker.leading.equalToSuperview().inset(lastMargin)
                        }
                        maker.top.bottom.equalToSuperview()
                    }

                    lastView = view
                    lastMargin = defaultMargin
                }
            }
        }

        lastView?.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(lastMargin)
        }

        cell.id = elements.cellId
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
        case .multiText1: return MultiText1Component()
        case .multiText2: return MultiText2Component()
        case .multiText3: return MultiText3Component()
        case .multiText4: return MultiText4Component()
        case .multiText5: return MultiText5Component()
        case .multiText6: return MultiText6Component()
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

}

extension CellBuilder {

    public enum CellElement: String {
        case text
        case multiText1
        case multiText2
        case multiText3
        case multiText4
        case multiText5
        case multiText6
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

extension Collection where Self.Element == CellBuilder.CellElement {

    var cellId: String {
        map { $0.rawValue }.joined(separator: "-")
    }

}