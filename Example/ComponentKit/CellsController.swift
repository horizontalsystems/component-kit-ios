import UIKit
import ThemeKit
import SnapKit
import SectionsTableView
import SkeletonView
import ComponentKit

class CellsController: ThemeViewController {
    private let tableView = SectionsTableView(style: .grouped)

    private let aCell = ACell()
    private let a1Cell = A1Cell()
    private let a5Cell = A5Cell()
    private let a9Cell = A9Cell()
    private let b5Cell = B5Cell()
    private let c5Cell = C5Cell()
    private let c6Cell = C6Cell()
    private let c9Cell = C9Cell()
    private let dCell = DCell()
    private let d20Cell = D20Cell()
    private let cell9ViewItem = CopyableSecondaryButton.ViewItem(value: "0xa1b2d3c4e5f6a1b2d3c4e5f6a1b2d3c4e5f6a1b2d3c4e5f6a1b2d3c4e5f6")
    private let cell9 = Cell9()
    private let emptyCell = EmptyCell()
    private let g12Cell = G12Cell()
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
        aCell.set(titleImageSize: .iconSize24)

        a1Cell.set(backgroundStyle: .lawrence)
        a1Cell.titleImageTintColor = .themeJacob
        a1Cell.titleImage = UIImage(named: "Cell Icon")?.withRenderingMode(.alwaysTemplate)
        a1Cell.title = "A1 - Title"

        a5Cell.set(backgroundStyle: .lawrence)
        a5Cell.titleImage = UIImage(named: "Cell Icon")?.withRenderingMode(.alwaysTemplate)
        a5Cell.titleImageTintColor = .themeJacob
        a5Cell.title = "A5 - Title A5 - Title A5 - Title"
        a5Cell.value = "Some Value"

        a9Cell.set(backgroundStyle: .lawrence)
        a9Cell.titleImage = UIImage(named: "Cell Icon")?.withRenderingMode(.alwaysTemplate)
        a9Cell.titleImageTintColor = .themeGray
        a9Cell.title = "A9 - Title"
        a9Cell.viewItem = .init(value: "this-is-value")

        b5Cell.set(backgroundStyle: .lawrence)
        b5Cell.title = "B5 - Title"
        b5Cell.value = "Some Value"
        b5Cell.valueAction = { print("On Tap B5") }
        b5Cell.selectionStyle = .none

        c5Cell.set(backgroundStyle: .lawrence)
        c5Cell.titleImage = UIImage(named: "Cell Icon")?.withRenderingMode(.alwaysTemplate)
        c5Cell.titleImageTintColor = .themeGray
        c5Cell.title = "C5 - Title"
        c5Cell.titleImageAction = { print("C5 - Title Image Tap") }
        c5Cell.value = "Some Value"
        c5Cell.valueAction = { print("On Tap C5") }
        c5Cell.selectionStyle = .none

        c6Cell.set(backgroundStyle: .lawrence)
        c6Cell.titleImage = UIImage(named: "Cell Icon")?.withRenderingMode(.alwaysTemplate)
        c6Cell.titleImageTintColor = .themeJacob
        c6Cell.title = "C6 - Title"
        c6Cell.titleImageAction = { print("C6 - Title Image Tap") }
        c6Cell.value = "Some Value"
        c6Cell.valueImage = UIImage(named: "icon_20")?.withRenderingMode(.alwaysTemplate)
        c6Cell.valueImageTintColor = .themeLucian
        c6Cell.selectionStyle = .none

        c9Cell.set(backgroundStyle: .lawrence)
        c9Cell.titleImageTintColor = .themeGray
        c9Cell.titleImage = UIImage(named: "Cell Icon")?.withRenderingMode(.alwaysTemplate)
        c9Cell.title = "C9 - Title"
        c9Cell.titleImageAction = { print("C9 - Title Image Tap") }
        c9Cell.viewItem = .init(value: "this-is-value")

        dCell.set(backgroundStyle: .lawrence)
        dCell.title = "D - Title"

        d20Cell.set(backgroundStyle: .lawrence)
        d20Cell.title = "D 20 - Title"
        d20Cell.value = "BADGE"
        d20Cell.valueBackground = .themeRemus
        d20Cell.image = UIImage(named: "icon_20")

        cell9.set(backgroundStyle: .lawrence, isLast: true)
        cell9.viewItem = cell9ViewItem

        g12Cell.set(backgroundStyle: .lawrence, isFirst: true)
        g12Cell.leftImage = UIImage(named: "Cell Icon")?.withRenderingMode(.alwaysTemplate)
        g12Cell.leftImageTintColor = .themeJacob
        g12Cell.topText = "G12 - Title"
        g12Cell.bottomText = "Subtitle"
        g12Cell.leftBadgeText = "123"
        g12Cell.rightBadgeText = "456"
        g12Cell.valueTopText = "Top"
        g12Cell.valueBottomText = "Bottom"

        g14Cell.set(backgroundStyle: .lawrence)
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
                        StaticRow(cell: a5Cell, id: "a5", height: .heightCell48, autoDeselect: true, action: { print("On Tap A5") }),
                        StaticRow(cell: a9Cell, id: "a9", height: .heightCell48),
                        StaticRow(cell: b5Cell, id: "b5", height: .heightCell48),
                        StaticRow(cell: c5Cell, id: "c5", height: .heightCell48),
                        StaticRow(cell: c6Cell, id: "c6", height: .heightCell48),
                        StaticRow(cell: c9Cell, id: "c9", height: .heightCell48),
                        StaticRow(cell: dCell, id: "d", height: .heightCell48),
                        StaticRow(cell: d20Cell, id: "d20", height: .heightCell48, autoDeselect: true),
                        StaticRow(cell: cell9, id: "9", dynamicHeight: { [unowned self] in
                            Cell9.height(containerWidth: $0, backgroundStyle: .lawrence, viewItem: cell9ViewItem)
                        }),
                        StaticRow(cell: emptyCell, id: "empty", height: 12),
                        StaticRow(cell: g12Cell, id: "g12", height: .heightDoubleLineCell, autoDeselect: true),
                        StaticRow(cell: g14Cell, id: "g14", height: .heightDoubleLineCell, autoDeselect: true),
                        StaticRow(cell: g19Cell, id: "g19", height: .heightDoubleLineCell, autoDeselect: true),
                        StaticRow(cell: g21Cell, id: "g21", height: .heightDoubleLineCell),
                    ]
            )
        ]
    }

}
