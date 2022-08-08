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

                        return CellBuilderNew.row(
                                rootElement: .hStack([
                                    .image24 { component in
                                        component.imageView.image = ModuleKit.image(named: item.language)
                                    },
                                    .vStackCentered([
                                        .text { component in
                                            component.font = .body
                                            component.textColor = .themeLeah
                                            component.text = item.name
                                        },
                                        .margin(3),
                                        .text { component in
                                            component.font = .subhead2
                                            component.textColor = .themeGray
                                            component.text = item.nativeName
                                        }
                                    ]),
                                    .image20 { component in
                                        component.isHidden = !item.selected
                                        component.imageView.image = ComponentKit.image(named: "check_1_20")?.withTintColor(.themeJacob)
                                    }
                                ]),
                                tableView: tableView,
                                id: item.language,
                                height: .heightDoubleLineCell,
                                bind: { cell in
                                    cell.set(backgroundStyle: .lawrence, isFirst: isFirst, isLast: isLast)
                                },
                                action: { [weak self] in
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
