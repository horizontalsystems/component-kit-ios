import UIKit
import ThemeKit
import SnapKit
import ComponentKit
import SectionsTableView

class ButtonsController: ThemeViewController {
    private let tableView = SectionsTableView(style: .grouped)

    private let primaryYellowCell = BaseThemeCell()
    private let primaryRedCell = BaseThemeCell()
    private let primaryGrayCell = BaseThemeCell()
    private let primaryTransparentCell = BaseThemeCell()
    private let primaryCircleCell = BaseThemeCell()
    private let secondaryCell = BaseThemeCell()
    private let secondaryFullCell = BaseThemeCell()
    private let secondaryTransparentCell = BaseThemeCell()
    private let secondaryCircleCell = BaseThemeCell()
    private let transparentIconCell = BaseThemeCell()

    override func viewDidLoad() {
        super.viewDidLoad()

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
        primaryYellowCell.set(backgroundStyle: .transparent)
        CellBuilder.build(cell: primaryYellowCell, elements: [.text, .primaryButton, .margin8, .primaryButton])
        primaryYellowCell.bind(index: 0, block: { (component: TextComponent) in
            component.font = .subhead1
            component.textColor = .themeLeah
            component.text = "Primary"
        })
        primaryYellowCell.bind(index: 1, block: { (component: PrimaryButtonComponent) in
            component.button.set(style: .yellow)
            component.button.setTitle("Yellow", for: .normal)
            component.button.setContentHuggingPriority(.required, for: .horizontal)
        })
        primaryYellowCell.bind(index: 2, block: { (component: PrimaryButtonComponent) in
            component.button.set(style: .yellow)
            component.button.isEnabled = false
            component.button.setTitle("Disabled", for: .normal)
            component.button.setContentHuggingPriority(.required, for: .horizontal)
        })

        primaryRedCell.set(backgroundStyle: .transparent)
        CellBuilder.build(cell: primaryRedCell, elements: [.text, .primaryButton, .margin8, .primaryButton])
        primaryRedCell.bind(index: 0, block: { (component: TextComponent) in
            component.font = .subhead1
            component.textColor = .themeLeah
            component.text = "Primary"
        })
        primaryRedCell.bind(index: 1, block: { (component: PrimaryButtonComponent) in
            component.button.set(style: .red)
            component.button.setTitle("Red", for: .normal)
            component.button.setContentHuggingPriority(.required, for: .horizontal)
        })
        primaryRedCell.bind(index: 2, block: { (component: PrimaryButtonComponent) in
            component.button.set(style: .red)
            component.button.isEnabled = false
            component.button.setTitle("Disabled", for: .normal)
            component.button.setContentHuggingPriority(.required, for: .horizontal)
        })

        primaryGrayCell.set(backgroundStyle: .transparent)
        CellBuilder.build(cell: primaryGrayCell, elements: [.text, .primaryButton, .margin8, .primaryButton])
        primaryGrayCell.bind(index: 0, block: { (component: TextComponent) in
            component.font = .subhead1
            component.textColor = .themeLeah
            component.text = "Primary"
        })
        primaryGrayCell.bind(index: 1, block: { (component: PrimaryButtonComponent) in
            component.button.set(style: .gray)
            component.button.setTitle("Gray", for: .normal)
            component.button.setContentHuggingPriority(.required, for: .horizontal)
        })
        primaryGrayCell.bind(index: 2, block: { (component: PrimaryButtonComponent) in
            component.button.set(style: .gray)
            component.button.isEnabled = false
            component.button.setTitle("Disabled", for: .normal)
            component.button.setContentHuggingPriority(.required, for: .horizontal)
        })

        primaryTransparentCell.set(backgroundStyle: .transparent)
        CellBuilder.build(cell: primaryTransparentCell, elements: [.text, .primaryButton, .margin8, .primaryButton])
        primaryTransparentCell.bind(index: 0, block: { (component: TextComponent) in
            component.font = .subhead1
            component.textColor = .themeLeah
            component.text = "Primary"
        })
        primaryTransparentCell.bind(index: 1, block: { (component: PrimaryButtonComponent) in
            component.button.set(style: .transparent)
            component.button.setTitle("Transparent", for: .normal)
            component.button.setContentHuggingPriority(.required, for: .horizontal)
        })
        primaryTransparentCell.bind(index: 2, block: { (component: PrimaryButtonComponent) in
            component.button.set(style: .transparent)
            component.button.isEnabled = false
            component.button.setTitle("Disabled", for: .normal)
            component.button.setContentHuggingPriority(.required, for: .horizontal)
        })

        primaryCircleCell.set(backgroundStyle: .transparent)
        CellBuilder.build(cell: primaryCircleCell, elements: [.text, .primaryCircleButton, .margin4, .primaryCircleButton, .margin4, .primaryCircleButton, .margin4, .primaryCircleButton])
        primaryCircleCell.bind(index: 0, block: { (component: TextComponent) in
            component.font = .subhead1
            component.textColor = .themeLeah
            component.text = "Primary Circle"
        })
        primaryCircleCell.bind(index: 1, block: { (component: PrimaryCircleButtonComponent) in
            component.button.set(style: .yellow)
            component.button.set(image: UIImage(named: "arrow_swap_2_24"))
        })
        primaryCircleCell.bind(index: 2, block: { (component: PrimaryCircleButtonComponent) in
            component.button.set(style: .red)
            component.button.set(image: UIImage(named: "arrow_swap_2_24"))
        })
        primaryCircleCell.bind(index: 3, block: { (component: PrimaryCircleButtonComponent) in
            component.button.set(style: .gray)
            component.button.set(image: UIImage(named: "arrow_swap_2_24"))
        })
        primaryCircleCell.bind(index: 4, block: { (component: PrimaryCircleButtonComponent) in
            component.button.set(style: .yellow)
            component.button.isEnabled = false
            component.button.set(image: UIImage(named: "arrow_swap_2_24"))
        })

        secondaryCell.set(backgroundStyle: .transparent)
        CellBuilder.build(cell: secondaryCell, elements: [.text, .secondaryButton, .margin4, .secondaryButton, .margin4, .secondaryButton])
        secondaryCell.bind(index: 0, block: { (component: TextComponent) in
            component.font = .subhead1
            component.textColor = .themeLeah
            component.text = "Secondary"
        })
        secondaryCell.bind(index: 1, block: { (component: SecondaryButtonComponent) in
            component.button.isSelected = true
            component.button.set(style: .default)
            component.button.setTitle("Selected", for: .normal)
        })
        secondaryCell.bind(index: 2, block: { (component: SecondaryButtonComponent) in
            component.button.set(style: .default)
            component.button.setTitle("Default", for: .normal)
        })
        secondaryCell.bind(index: 3, block: { (component: SecondaryButtonComponent) in
            component.button.isEnabled = false
            component.button.set(style: .default)
            component.button.setTitle("Disabled", for: .normal)
        })

        secondaryTransparentCell.set(backgroundStyle: .transparent)
        CellBuilder.build(cell: secondaryTransparentCell, elements: [.text, .secondaryButton, .margin4, .secondaryButton, .margin4, .secondaryButton])
        secondaryTransparentCell.bind(index: 0, block: { (component: TextComponent) in
            component.font = .subhead1
            component.textColor = .themeLeah
            component.text = "Transparent"
        })
        secondaryTransparentCell.bind(index: 1, block: { (component: SecondaryButtonComponent) in
            component.button.isSelected = true
            component.button.set(style: .transparent)
            component.button.setTitle("Copy", for: .normal)
        })
        secondaryTransparentCell.bind(index: 2, block: { (component: SecondaryButtonComponent) in
            component.button.set(style: .transparent)
            component.button.setTitle("Copy", for: .normal)
        })
        secondaryTransparentCell.bind(index: 3, block: { (component: SecondaryButtonComponent) in
            component.button.isEnabled = false
            component.button.set(style: .transparent)
            component.button.setTitle("Copy", for: .normal)
        })

        secondaryFullCell.set(backgroundStyle: .transparent)
        CellBuilder.build(cell: secondaryFullCell, elements: [.text, .secondaryButton, .margin4, .secondaryButton, .margin4, .secondaryButton])
        secondaryFullCell.bind(index: 0, block: { (component: TextComponent) in
            component.font = .subhead1
            component.textColor = .themeLeah
            component.text = "Full"
        })
        secondaryFullCell.bind(index: 1, block: { (component: SecondaryButtonComponent) in
            component.button.isSelected = true
            component.button.set(style: .default)
            component.button.setTitle("Copy", for: .normal)
            component.button.set(image: UIImage(named: "icon_20"))
        })
        secondaryFullCell.bind(index: 2, block: { (component: SecondaryButtonComponent) in
            component.button.set(style: .default)
            component.button.setTitle("Copy", for: .normal)
            component.button.set(image: UIImage(named: "icon_20"))
        })
        secondaryFullCell.bind(index: 3, block: { (component: SecondaryButtonComponent) in
            component.button.isEnabled = false
            component.button.set(style: .default)
            component.button.setTitle("Copy", for: .normal)
            component.button.set(image: UIImage(named: "icon_20"))
        })

        secondaryCircleCell.set(backgroundStyle: .transparent)
        CellBuilder.build(cell: secondaryCircleCell, elements: [.text, .secondaryCircleButton, .margin4, .secondaryCircleButton, .margin4, .secondaryCircleButton, .margin4, .secondaryCircleButton])
        secondaryCircleCell.bind(index: 0, block: { (component: TextComponent) in
            component.font = .subhead1
            component.textColor = .themeLeah
            component.text = "Secondary Circle"
        })
        secondaryCircleCell.bind(index: 1, block: { (component: SecondaryCircleButtonComponent) in
            component.button.isSelected = true
            component.button.set(image: UIImage(named: "icon_20"))
        })
        secondaryCircleCell.bind(index: 2, block: { (component: SecondaryCircleButtonComponent) in
            component.button.set(image: UIImage(named: "icon_20"))
        })
        secondaryCircleCell.bind(index: 3, block: { (component: SecondaryCircleButtonComponent) in
            component.button.set(image: UIImage(named: "icon_20"), style: .red)
        })
        secondaryCircleCell.bind(index: 4, block: { (component: SecondaryCircleButtonComponent) in
            component.button.isEnabled = false
            component.button.set(image: UIImage(named: "icon_20"))
        })

        transparentIconCell.set(backgroundStyle: .transparent, isLast: true)
        CellBuilder.build(cell: transparentIconCell, elements: [.text, .margin4, .transparentIconButton, .margin4, .transparentIconButton, .margin4, .transparentIconButton])
        transparentIconCell.bind(index: 0, block: { (component: TextComponent) in
            component.font = .subhead1
            component.textColor = .themeLeah
            component.text = "Transparent Icon"
        })
        transparentIconCell.bind(index: 1, block: { (component: TransparentIconButtonComponent) in
            component.button.isSelected = true
            component.button.set(image: UIImage(named: "icon_20"))
        })
        transparentIconCell.bind(index: 2, block: { (component: TransparentIconButtonComponent) in
            component.button.set(image: UIImage(named: "icon_20"))
        })
        transparentIconCell.bind(index: 3, block: { (component: TransparentIconButtonComponent) in
            component.button.isEnabled = false
            component.button.set(image: UIImage(named: "icon_20"))
        })
    }

}

extension ButtonsController: SectionsDataSource {

    func buildSections() -> [SectionProtocol] {
        [
            Section(
                    id: "main",
                    headerState: .margin(height: .margin12),
                    footerState: .margin(height: .margin32),
                    rows: [
                        StaticRow(cell: primaryYellowCell, id: "primary-yellow", height: .heightDoubleLineCell),
                        StaticRow(cell: primaryRedCell, id: "primary-red", height: .heightDoubleLineCell),
                        StaticRow(cell: primaryGrayCell, id: "primary-gray", height: .heightDoubleLineCell),
                        StaticRow(cell: primaryTransparentCell, id: "primary-transparent", height: .heightDoubleLineCell),
                        StaticRow(cell: primaryCircleCell, id: "primary-icon", height: .heightDoubleLineCell),
                        StaticRow(cell: secondaryCell, id: "secondary", height: .heightSingleLineCell),
                        StaticRow(cell: secondaryTransparentCell, id: "secondary-transparent", height: .heightSingleLineCell),
                        StaticRow(cell: secondaryFullCell, id: "secondary-full", height: .heightSingleLineCell),
                        StaticRow(cell: secondaryCircleCell, id: "secondary-circle", height: .heightSingleLineCell),
                        StaticRow(cell: transparentIconCell, id: "transparent-icon", height: .heightSingleLineCell),
                    ]
            )
        ]
    }

}
