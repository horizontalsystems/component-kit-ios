import UIKit
import ThemeKit
import SnapKit
import SectionsTableView
import SkeletonView

class CellsController: ThemeViewController {
    private let tableView = SectionsTableView(style: .grouped)

    private let aCell = ACell()
    private let a1Cell = A1Cell()
    private let dCell = DCell()
    private let cell9ViewItem = CopyableSecondaryButton.ViewItem(value: "0xa1b2d3c4e5f6a1b2d3c4e5f6a1b2d3c4e5f6a1b2d3c4e5f6a1b2d3c4e5f6")
    private let cell9 = Cell9()
    private let emptyCell = EmptyCell()
    private let g14Cell = G14Cell()
    private let g19Cell = G19Cell()
    private let g21Cell = G21Cell()

    private var themeModeIterator = 0
    private var themeBarButtonItem: UIBarButtonItem?

    private var isSkeletoned = false

    override func viewDidLoad() {
        super.viewDidLoad()
        themeBarButtonItem = UIBarButtonItem(title: ThemeManager.shared.themeMode.rawValue, style: .plain, target: self, action: #selector(onToggleLightMode))

        navigationItem.rightBarButtonItems = [
            themeBarButtonItem!,
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
        aCell.titleImage = UIImage(named: "Cell Icon")?.withRenderingMode(.alwaysTemplate)
        aCell.titleImageTintColor = .themeJacob
        aCell.title = "A - Title"
        aCell.titleColor = .themeJacob

        a1Cell.set(backgroundStyle: .lawrence)
        a1Cell.titleImageTintColor = .themeJacob
        a1Cell.titleImage = UIImage(named: "Cell Icon")?.withRenderingMode(.alwaysTemplate)
        a1Cell.title = "A1 - Title"

        dCell.set(backgroundStyle: .lawrence)
        dCell.title = "D - Title"

        cell9.set(backgroundStyle: .lawrence, isLast: true)
        cell9.viewItem = cell9ViewItem

        g14Cell.set(backgroundStyle: .lawrence, isFirst: true)
        g14Cell.leftImageTintColor = .themeJacob
        g14Cell.leftImage = UIImage(named: "Cell Icon")?.withRenderingMode(.alwaysTemplate)
        g14Cell.topText = "G14 - Title"
        g14Cell.bottomText = "Subtitle"
        g14Cell.leftBadgeText = "123"
        g14Cell.rightBadgeText = "456"
        g14Cell.primaryValueText = "Prim"
        g14Cell.secondaryTitleText = "Title"
        g14Cell.secondaryValueText = "Value"

        g19Cell.set(backgroundStyle: .lawrence)
        g19Cell.titleImage = UIImage(named: "Cell Icon")?.tinted(with: .themeJacob)
        g19Cell.title = "G19 - Title"
        g19Cell.subtitle = "Subtitle"
        g19Cell.valueButtonImage = UIImage(named: "icon_20")
        g19Cell.valueImage = UIImage(named: "icon_20")?.tinted(with: .themeLucian)
        g19Cell.onTapValue = { print("Tap G19") }

        g21Cell.set(backgroundStyle: .lawrence, isLast: true)
        g21Cell.titleImage = UIImage(named: "Cell Icon")?.tinted(with: .themeJacob)
        g21Cell.title = "G21 - Title G21 - Title G21 - Title G21 - Title G21 - Title G21 - Title"
        g21Cell.subtitle = "Subtitle"
        g21Cell.rightButtonImage = UIImage(named: "icon_20")
        g21Cell.onTapRightButton = { print("Tap G21 Button") }
        g21Cell.onToggle = { print("Toggle G21: \($0)") }
    }

    @objc func onToggleLightMode() {
        themeModeIterator += 1
        if themeModeIterator > 2 {
            themeModeIterator = 0
        }

        if themeModeIterator == 0 {
            ThemeManager.shared.themeMode = .system
            UIApplication.shared.windows.first(where: \.isKeyWindow)?.overrideUserInterfaceStyle = .unspecified
        }
        if themeModeIterator == 1 {
            ThemeManager.shared.themeMode = .dark
            UIApplication.shared.windows.first(where: \.isKeyWindow)?.overrideUserInterfaceStyle = .dark
        }
        if themeModeIterator == 2 {
            ThemeManager.shared.themeMode = .light
            UIApplication.shared.windows.first(where: \.isKeyWindow)?.overrideUserInterfaceStyle = .light
        }

        themeBarButtonItem?.title = ThemeManager.shared.themeMode.rawValue
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
                        StaticRow(cell: aCell, id: "a", height: .heightCell48, autoDeselect: true),
                        StaticRow(cell: a1Cell, id: "a1", height: .heightCell48, autoDeselect: true),
                        StaticRow(cell: dCell, id: "d", height: .heightCell48),
                        StaticRow(cell: cell9, id: "9", dynamicHeight: { [unowned self] in
                            Cell9.height(containerWidth: $0, backgroundStyle: .lawrence, viewItem: self.cell9ViewItem)
                        }),
                        StaticRow(cell: emptyCell, id: "empty", height: 12),
                        StaticRow(cell: g14Cell, id: "g14", height: .heightDoubleLineCell, autoDeselect: true),
                        StaticRow(cell: g19Cell, id: "g19", height: .heightDoubleLineCell, autoDeselect: true),
                        StaticRow(cell: g21Cell, id: "g21", height: .heightDoubleLineCell),
                    ]
            )
        ]
    }

}
