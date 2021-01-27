import UIKit
import SectionsTableView
import ThemeKit

class BaseCurrencySettingsViewController: ThemeViewController {
    private let delegate: IBaseCurrencySettingsViewDelegate

    private var items = [CurrencyViewItem]()
    private let tableView = SectionsTableView(style: .grouped)

    init(delegate: IBaseCurrencySettingsViewDelegate) {
        self.delegate = delegate

        super.init()

        hidesBottomBarWhenPushed = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "settings_base_currency.title".localized

        tableView.registerCell(forClass: G4Cell.self)
        tableView.registerHeaderFooter(forClass: BottomDescriptionHeaderFooterView.self)
        tableView.sectionDataSource = self

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        delegate.viewDidLoad()
        tableView.buildSections()
    }

}

extension BaseCurrencySettingsViewController: SectionsDataSource {

    private func footer(hash: String, text: String) -> ViewState<BottomDescriptionHeaderFooterView> {
        .cellType(
                hash: hash,
                binder: { view in
                    view.bind(text: text)
                },
                dynamicHeight: { [unowned self] _ in
                    BottomDescriptionHeaderFooterView.height(containerWidth: self.tableView.bounds.width, text: text)
                }
        )
    }

    func buildSections() -> [SectionProtocol] {
        [
            Section(
                    id: "currencies",
                    headerState: .margin(height: .margin3x),
                    footerState: footer(hash: "currencies_footer", text: "settings_base_currency.provided_by".localized),
                    rows: items.enumerated().map { (index, item) in
                        let isFirst = index == 0
                        let isLast = index == items.count - 1

                        return Row<G4Cell>(
                                id: item.code,
                                height: .heightDoubleLineCell,
                                bind: { [weak self] cell, _ in
                                    cell.set(backgroundStyle: .lawrence, isFirst: isFirst, isLast: isLast)
                                    cell.titleImage = CurrencyKit.image(named: item.code)
                                    cell.title = item.code
                                    cell.subtitle = item.symbol
                                    cell.valueImage = item.selected ? ThemeKit.image(named: "check_1_20")?.tinted(with: .themeJacob) : nil
                                },
                                action: { [weak self] _ in
                                    self?.delegate.didSelect(index: index)
                                }
                        )
                    }
            )
        ]
    }

}

extension BaseCurrencySettingsViewController: IBaseCurrencySettingsView {

    func show(viewItems: [CurrencyViewItem]) {
        items = viewItems
    }

}
