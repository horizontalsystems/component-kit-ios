import UIKit
import SectionsTableView
import ThemeKit

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

        tableView.registerCell(forClass: ImageDoubleLineCheckmarkCell.self)
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
                        Row<ImageDoubleLineCheckmarkCell>(
                                id: item.language,
                                height: .heightDoubleLineCell,
                                bind: { [unowned self] cell, _ in
                                    cell.bind(
                                            image: ModuleKit.image(named: item.language),
                                            title: item.name,
                                            subtitle: item.nativeName,
                                            checkmarkVisible: item.selected,
                                            last: index == self.items.count - 1
                                    )
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
