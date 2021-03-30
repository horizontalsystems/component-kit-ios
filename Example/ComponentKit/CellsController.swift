import UIKit
import ThemeKit
import SnapKit
import SectionsTableView
import SkeletonView

class CellsController: ThemeViewController {
    private let tableView = SectionsTableView(style: .grouped)

    private let aCell = ACell()
    private let a1Cell = A1Cell()
    private let g14Cell = G14Cell()
    private let g19Cell = G19Cell()

    private var isSkeletoned = false

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onToggleLightMode)),
            UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(onToggleShimmer))
        ]

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionDataSource = self

        configureCells()
        tableView.buildSections()
    }

    private func configureCells() {
        aCell.set(backgroundStyle: .lawrence, isFirst: true)
        aCell.titleImage = UIImage(named: "Cell Icon")?.tinted(with: .themeJacob)
        aCell.title = "A - Title"
        aCell.titleColor = .themeJacob

        a1Cell.set(backgroundStyle: .lawrence)
        a1Cell.titleImage = UIImage(named: "Cell Icon")?.tinted(with: .themeJacob)
        a1Cell.title = "A1 - Title"

        g14Cell.set(backgroundStyle: .lawrence)
        g14Cell.leftImage = UIImage(named: "Cell Icon")?.tinted(with: .themeJacob)
        g14Cell.topText = "G14 - Title"
        g14Cell.bottomText = "Subtitle"
        g14Cell.leftBadgeText = "123"
        g14Cell.rightBadgeText = "456"
        g14Cell.primaryValueText = "Prim"
        g14Cell.secondaryTitleText = "Title"
        g14Cell.secondaryValueText = "Value"

        g19Cell.set(backgroundStyle: .lawrence, isLast: true)
        g19Cell.titleImage = UIImage(named: "Cell Icon")?.tinted(with: .themeJacob)
        g19Cell.title = "G19 - Title"
        g19Cell.subtitle = "Subtitle"
        g19Cell.valueButtonImage = UIImage(named: "icon_20")
        g19Cell.valueImage = UIImage(named: "icon_20")?.tinted(with: .themeLucian)
        g19Cell.onTapValue = { print("Tap G19") }
    }

    @objc func onToggleLightMode() {
        ThemeManager.shared.lightMode = !ThemeManager.shared.lightMode
        UIApplication.shared.keyWindow?.set(newRootController: MainController(selectedIndex: 2))
    }

    @objc func onToggleShimmer() {
        if isSkeletoned {
            g14Cell.hideSkeleton()

            isSkeletoned = false
        } else {
            let gradient = SkeletonGradient(baseColor: .themeJeremy)
            g14Cell.showAnimatedGradientSkeleton(usingGradient: gradient)

            isSkeletoned = true
        }
    }

}

extension CellsController: SectionsDataSource {

    func buildSections() -> [SectionProtocol] {
        [
            Section(
                    id: "main",
                    headerState: .margin(height: .margin12),
                    rows: [
                        StaticRow(
                                cell: aCell,
                                id: "a",
                                height: .heightCell48,
                                autoDeselect: true
                        ),
                        StaticRow(
                                cell: a1Cell,
                                id: "a1",
                                height: .heightCell48,
                                autoDeselect: true
                        ),
                        StaticRow(
                                cell: g14Cell,
                                id: "g14",
                                height: .heightDoubleLineCell,
                                autoDeselect: true
                        ),
                        StaticRow(
                                cell: g19Cell,
                                id: "g19",
                                height: .heightDoubleLineCell,
                                autoDeselect: true
                        ),
                    ]
            )
        ]
    }

}
