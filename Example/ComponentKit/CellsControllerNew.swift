import UIKit
import ThemeKit
import SnapKit
import SectionsTableView
import ComponentKit

class CellsControllerNew: ThemeViewController {
    private let tableView = SectionsTableView(style: .grouped)

    private let staticCell = BaseThemeCell()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionDataSource = self

        staticCell.set(backgroundStyle: .lawrence)
        CellBuilder.build(cell: staticCell, elements: [.image, .text])

        staticCell.bind(index: 0) { (component: ImageComponent) in
            component.imageView.image = UIImage(systemName: "airplane")
            component.imageView.tintColor = .themeGray
        }
        staticCell.bind(index: 1) { (component: TextComponent) in
            component.set(style: .b2)
            component.text = "Static Airplane Cell"
        }

        tableView.buildSections()
    }

}

extension CellsControllerNew: SectionsDataSource {

    private func rowMarketCap() -> RowProtocol {
        CellBuilder.row(
                elements: [.text, .margin8, .badge, .text],
                tableView: tableView,
                id: "row-market-cap",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: TextComponent) in
                        component.set(style: .d1)
                        component.text = "Market Cap"
                        component.setContentHuggingPriority(.required, for: .horizontal)
                    }
                    cell.bind(index: 1) { (component: BadgeComponent) in
                        component.badgeView.text = "12"
                    }
                    cell.bind(index: 2) { (component: TextComponent) in
                        component.set(style: .c2)
                        component.text = "$74.7 B"
                        component.textAlignment = .right
                    }
                }
        )
    }

    private func rowContract() -> RowProtocol {
        CellBuilder.row(
                elements: [.image, .text, .secondaryCircleButton, .secondaryCircleButton],
                tableView: tableView,
                id: "row-contract",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "bitcoinsign.square.fill")
                        component.imageView.tintColor = .themeJacob
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: .d1)
                        component.text = "0xai9823nfw2873dmn3498cm3498jf938hdfh98hwe8"
                        component.lineBreakMode = .byTruncatingMiddle
                    }
                    cell.bind(index: 2) { (component: SecondaryCircleButtonComponent) in
                        component.button.set(image: UIImage(systemName: "shippingbox"))
                        component.onTap = { print("Did tap copy") }
                    }
                    cell.bind(index: 3) { (component: SecondaryCircleButtonComponent) in
                        component.button.set(image: UIImage(systemName: "globe"))
                        component.onTap = { print("Did tap globe") }
                    }
                }
        )
    }

    private func rowMarket1() -> RowProtocol {
        CellBuilder.row(
                elements: [.image, .multiText3, .multiText1],
                tableView: tableView,
                id: "row-market-1",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "bitcoinsign.circle")
                        component.imageView.tintColor = .themeGray
                    }
                    cell.bind(index: 1) { (component: MultiText3Component) in
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)

                        component.title.text = "Bitcoin"
                        component.subtitle.text = "BTC"
                        component.badge.text = "123"
                    }
                    cell.bind(index: 2) { (component: MultiText1Component) in
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d4)

                        component.title.textAlignment = .right
                        component.title.setContentCompressionResistancePriority(.required, for: .horizontal)
                        component.title.text = "$65,145"

                        component.subtitle.textAlignment = .right
                        component.subtitle.setContentCompressionResistancePriority(.required, for: .horizontal)
                        component.subtitle.text = "+2.35%"
                    }
                }
        )
    }

    private func rowMarket2() -> RowProtocol {
        CellBuilder.row(
                elements: [.image, .multiText3, .multiText2],
                tableView: tableView,
                id: "row-market-2",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
                        component.imageView.tintColor = .themeGray
                    }
                    cell.bind(index: 1) { (component: MultiText3Component) in
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)

                        component.title.text = "Ethereum"
                        component.subtitle.text = "ETH"
                        component.badge.text = "2"
                    }
                    cell.bind(index: 2) { (component: MultiText2Component) in
                        component.title.set(style: .b2)
                        component.subtitleLeft.set(style: .d3)
                        component.subtitleRight.set(style: .d1)

                        component.title.textAlignment = .right
                        component.title.setContentCompressionResistancePriority(.required, for: .horizontal)
                        component.title.text = "$4,635"

                        component.subtitleLeft.textAlignment = .right
                        component.subtitleLeft.setContentCompressionResistancePriority(.required, for: .horizontal)
                        component.subtitleLeft.text = "MCap"

                        component.subtitleRight.setContentCompressionResistancePriority(.required, for: .horizontal)
                        component.subtitleRight.setContentHuggingPriority(.required, for: .horizontal)
                        component.subtitleRight.text = "$495.1B"
                    }
                }
        )
    }

    private func rowStatic() -> RowProtocol {
        StaticRow(
                cell: staticCell,
                id: "row-text",
                height: .heightCell48
        )
    }

    private func rowMultiline() -> RowProtocol {
        let backgroundStyle: BaseThemeCell.BackgroundStyle = .lawrence
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        let textStyle: TextComponent.Style = .d2

        return CellBuilder.row(
                elements: [.image, .text],
                tableView: tableView,
                id: "row-multiline",
                dynamicHeight: { containerWidth in
                    CellBuilder.height(
                            containerWidth: containerWidth,
                            backgroundStyle: backgroundStyle,
                            text: text,
                            textStyle: textStyle,
                            elements: [.fixed(width: 20), .multiline]
                    )
                },
                bind: { cell in
                    cell.set(backgroundStyle: backgroundStyle)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "square")
                        component.imageView.tintColor = .themeGray
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: textStyle)
                        component.text = text
                        component.numberOfLines = 0
                    }
                }
        )
    }

    private func rowSettings1() -> RowProtocol {
        CellBuilder.row(
                elements: [.image, .text, .image],
                tableView: tableView,
                id: "row-settings-1",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "book")
                        component.imageView.tintColor = .themeGray
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: .b2)
                        component.text = "Academy"
                    }
                    cell.bind(index: 2) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "chevron.forward")
                        component.imageView.tintColor = .themeGray
                    }
                }
        )
    }

    private func rowSettings2() -> RowProtocol {
        CellBuilder.row(
                elements: [.image, .text, .image, .margin12, .image],
                tableView: tableView,
                id: "row-settings-2",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "shield")
                        component.imageView.tintColor = .themeGray
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: .b2)
                        component.text = "Security Center"
                    }
                    cell.bind(index: 2) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                        component.imageView.tintColor = .themeLucian
                    }
                    cell.bind(index: 3) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "chevron.forward")
                        component.imageView.tintColor = .themeGray
                    }
                }
        )
    }

    private func rowSettings3() -> RowProtocol {
        CellBuilder.row(
                elements: [.image, .text, .text, .margin8, .image],
                tableView: tableView,
                id: "row-settings-3",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "globe")
                        component.imageView.tintColor = .themeGray
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: .b2)
                        component.text = "Language"
                    }
                    cell.bind(index: 2) { (component: TextComponent) in
                        component.set(style: .c1)
                        component.text = "English"
                        component.setContentCompressionResistancePriority(.required, for: .horizontal)
                        component.setContentHuggingPriority(.required, for: .horizontal)
                    }
                    cell.bind(index: 3) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "chevron.forward")
                        component.imageView.tintColor = .themeGray
                    }
                }
        )
    }

    private func rowSettings4() -> RowProtocol {
        CellBuilder.row(
                elements: [.image, .multiText1, .image],
                tableView: tableView,
                id: "row-settings-4",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "circle")
                        component.imageView.tintColor = .themeGray
                    }
                    cell.bind(index: 1) { (component: MultiText1Component) in
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)
                        component.title.text = "Wallet 1"
                        component.subtitle.text = "12 words"
                    }
                    cell.bind(index: 2) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "pencil")
                        component.imageView.tintColor = .themeGray
                    }
                }
        )
    }

    private func rowSettings5() -> RowProtocol {
        CellBuilder.row(
                elements: [.image, .multiText1, .image, .image],
                tableView: tableView,
                id: "row-settings-5",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "circle.inset.filled")
                        component.imageView.tintColor = .themeJacob
                    }
                    cell.bind(index: 1) { (component: MultiText1Component) in
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)
                        component.title.text = "Wallet 2"
                        component.subtitle.text = "24 words"
                    }
                    cell.bind(index: 2) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                        component.imageView.tintColor = .themeLucian
                    }
                    cell.bind(index: 3) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "pencil")
                        component.imageView.tintColor = .themeGray
                    }
                }
        )
    }

    private func rowSettings6() -> RowProtocol {
        CellBuilder.row(
                elements: [.image, .text, .image, .switch],
                tableView: tableView,
                id: "row-settings-6",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "suit.spade")
                        component.imageView.tintColor = .themeGray
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: .b2)
                        component.text = "Passcode "
                    }
                    cell.bind(index: 2) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                        component.imageView.tintColor = .themeLucian
                    }
                    cell.bind(index: 3) { (component: SwitchComponent) in
                        component.switchView.isOn = true
                        component.onSwitch = { print("Did toggle switch: \($0)") }
                    }
                }
        )
    }

    private func rowText() -> RowProtocol {
        CellBuilder.row(
                elements: [.image, .text],
                tableView: tableView,
                id: "row-text",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "pencil.circle")
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: .c3)
                        component.text = "I am TextComponent"
                    }
                }
        )
    }

    private func rowMultiText1() -> RowProtocol {
        CellBuilder.row(
                elements: [.multiText1, .image],
                tableView: tableView,
                id: "row-multi-text-1",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: MultiText1Component) in
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)
                        component.title.text = "MultiText1Component"
                        component.subtitle.text = "Subtitle"
                    }

                    cell.bind(index: 1) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "pencil.circle")
                    }
                }
        )
    }

    private func rowMultiText2() -> RowProtocol {
        CellBuilder.row(
                elements: [.multiText2],
                tableView: tableView,
                id: "row-multi-text-2",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: MultiText2Component) in
                        component.title.set(style: .b2)
                        component.subtitleLeft.set(style: .d1)
                        component.subtitleRight.set(style: .d1)

                        component.title.text = "MultiText2Component"
                        component.subtitleLeft.text = "Left"
                        component.subtitleRight.text = "Right"
                    }
                }
        )
    }

    private func rowMultiText3() -> RowProtocol {
        CellBuilder.row(
                elements: [.multiText3],
                tableView: tableView,
                id: "row-multi-text-3",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: MultiText3Component) in
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)

                        component.title.text = "MultiText3Component"
                        component.badge.text = "1"
                        component.subtitle.text = "Subtitle"
                    }
                }
        )
    }

    private func rowMultiText4() -> RowProtocol {
        CellBuilder.row(
                elements: [.multiText4, .image],
                tableView: tableView,
                id: "row-multi-text-4",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: MultiText4Component) in
                        component.title.set(style: .b2)
                        component.subtitleLeft.set(style: .d1)
                        component.subtitleRight.set(style: .d1)

                        component.title.text = "MultiText4Component"
                        component.badge.text = "ERC20"
                        component.subtitleLeft.text = "Subtitle Left"
                        component.subtitleRight.text = "Subtitle Right"
                    }

                    cell.bind(index: 1) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "pencil.circle")
                    }
                }
        )
    }

    private func rowMultiText5() -> RowProtocol {
        CellBuilder.row(
                elements: [.multiText5],
                tableView: tableView,
                id: "row-multi-text-5",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: MultiText5Component) in
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)

                        component.title.text = "MultiText5Component"
                        component.image.imageView.image = UIImage(systemName: "bag.badge.plus")
                        component.subtitle.text = "Subtitle"
                    }
                }
        )
    }

    private func rowMultiText6() -> RowProtocol {
        CellBuilder.row(
                elements: [.multiText6],
                tableView: tableView,
                id: "row-multi-text-6",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: MultiText6Component) in
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)

                        component.title.text = "MultiText6Component"
                        component.imageLeft.imageView.image = UIImage(systemName: "lock")
                        component.imageRight.imageView.image = UIImage(systemName: "arrow.down.left")
                        component.subtitle.text = "Subtitle"
                    }
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
                        rowMarketCap(),
                        rowContract(),
                        rowMarket1(),
                        rowMarket2(),
                        rowStatic(),
                        rowMultiline(),
                        rowSettings1(),
                        rowSettings2(),
                        rowSettings3(),
                        rowSettings4(),
                        rowSettings5(),
                        rowSettings6(),
                        rowText(),
                        rowMultiText1(),
                        rowMultiText2(),
                        rowMultiText3(),
                        rowMultiText4(),
                        rowMultiText5(),
                        rowMultiText6(),
                    ]
            )
        ]
    }

}
