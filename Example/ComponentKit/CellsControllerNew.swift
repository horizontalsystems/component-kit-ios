import UIKit
import ThemeKit
import SnapKit
import SectionsTableView
import ComponentKit

class CellsControllerNew: ThemeViewController {
    private let tableView = SectionsTableView(style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionDataSource = self

        tableView.buildSections()
    }

}

extension CellsControllerNew: SectionsDataSource {

    private func rowD() -> RowProtocol {
        CellBuilder.instance.row(
                elements: [.text, .text2],
                tableView: tableView,
                id: "row-d",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (view: LeftDView) in
                        view.text = "I am D View"
                    }
                    cell.bind(index: 1) { (view: Right2View) in
                        view.text = "Right2"
                    }
                }
        )
    }

    private func rowF() -> RowProtocol {
        CellBuilder.instance.selectableRow(
                elements: [.doubleLineText, .disclosure],
                tableView: tableView,
                id: "row-f",
                height: .heightDoubleLineCell,
                autoDeselect: true,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (view: LeftFView) in
                        view.topText = "Top F"
                        view.bottomText = "Bottom F"
                    }
                },
                action: {
                    print("Did tap row F")
                }
        )
    }

    private func rowF2() -> RowProtocol {
        CellBuilder.instance.selectableRow(
                elements: [.doubleLineText, .disclosure, .margin8, .disclosure],
                tableView: tableView,
                id: "row-f2",
                height: .heightDoubleLineCell,
                autoDeselect: true,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (view: LeftFView) in
                        view.topText = "Top F2"
                        view.bottomText = "Bottom F2"
                    }
                },
                action: {
                    print("Did tap row F2")
                }
        )
    }

    func buildSections() -> [SectionProtocol] {
        [
            Section(
                    id: "main",
                    headerState: .margin(height: .margin12),
                    footerState: .margin(height: .margin32),
                    rows: [
                        rowD(),
                        rowF(),
                        rowF2()
                    ]
            )
        ]
    }

}
