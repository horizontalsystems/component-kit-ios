import UIKit
import SectionsTableView
import ThemeKit
import ComponentKit

class LanguageSettingsViewController: ThemeViewController {
    private let delegate: ILanguageSettingsViewDelegate

    private var items = [LanguageViewItem]()
    private let tableView = SectionsTableView(style: .grouped)

    init(delegate: ILanguageSettingsViewDelegate) {
        self.delegate = delegate

        super.init()

        hidesBottomBarWhenPushed = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "settings_language.title".localized

        tableView.registerCell(forClass: G4Cell.self)
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

extension LanguageSettingsViewController: SectionsDataSource {

    func buildSections() -> [SectionProtocol] {
        [
            Section(
                    id: "languages",
                    headerState: .margin(height: .margin3x),
                    footerState: .margin(height: .margin8x),
                    rows: items.enumerated().map { (index, item) in
                        let isFirst = index == 0
                        let isLast = index == items.count - 1

                        return Row<G4Cell>(
                                id: item.language,
                                height: .heightDoubleLineCell,
                                bind: { cell, _ in
                                    cell.set(backgroundStyle: .lawrence, isFirst: isFirst, isLast: isLast)
                                    cell.titleImage = ModuleKit.image(named: item.language)
                                    cell.title = item.name
                                    cell.subtitle = item.nativeName
                                    cell.valueImage = item.selected ? ComponentKit.image(named: "check_1_20")?.withRenderingMode(.alwaysTemplate) : nil
                                    cell.valueImageTintColor = .themeJacob
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

extension LanguageSettingsViewController: ILanguageSettingsView {

    func show(viewItems: [LanguageViewItem]) {
        self.items = viewItems
    }

}
