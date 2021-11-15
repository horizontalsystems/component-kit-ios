import UIKit
import SnapKit
import SectionsTableView

public class CellBuilder {
    public static let instance = CellBuilder()

    private let defaultMargin: CGFloat = .margin16

    public func row(
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
                rowType: .dynamic(reuseIdentifier: cellId, prepare: { [weak self] cell in
                    guard let cell = cell as? BaseThemeCell else {
                        return
                    }

                    self?.build(cell: cell, elements: elements)
                }),
                dynamicHeight: dynamicHeight,
                bind: { cell, _ in bind?(cell) }
        )
    }

    public func selectableRow(
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
                rowType: .dynamic(reuseIdentifier: cellId, prepare: { [weak self] cell in
                    guard let cell = cell as? BaseThemeCell else {
                        return
                    }

                    self?.build(cell: cell, elements: elements)
                }),
                dynamicHeight: dynamicHeight,
                bind: { cell, _ in bind?(cell) },
                action: { _ in action?() }
        )
    }

    public func build(cell: BaseThemeCell, elements: [CellElement]) {
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

    private func view(element: CellElement) -> UIView? {
        switch element {
        case .text: return LeftDView()
        case .text2: return Right2View()
        case .doubleLineText: return LeftFView()
        case .disclosure: return Right1View()
        default: return nil
        }
    }

}

extension CellBuilder {

    public enum CellElement: String {
        case text
        case text2
        case doubleLineText
        case disclosure

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