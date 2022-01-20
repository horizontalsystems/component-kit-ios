import UIKit
import ThemeKit
import SnapKit
import SectionsTableView
import ComponentKit

class CellsController: ThemeViewController {
    private let tableView = SectionsTableView(style: .grouped)

    private let staticCell = BaseThemeCell()
    private var hiddenMode = false

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onChange))

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionDataSource = self

        staticCell.set(backgroundStyle: .lawrence)
        CellBuilder.build(cell: staticCell, elements: [.image20, .text])

        staticCell.bind(index: 0) { (component: ImageComponent) in
            component.imageView.image = UIImage(systemName: "airplane")
            component.imageView.tintColor = .themeGray
            component.imageView.contentMode = .scaleAspectFit
        }
        staticCell.bind(index: 1) { (component: TextComponent) in
            component.set(style: .b2)
            component.text = "Static Airplane Cell"
        }

        tableView.buildSections()
    }

    @objc private func onChange() {
        hiddenMode = !hiddenMode
        tableView.reload()
    }

}

extension CellsController: SectionsDataSource {

    private func rowWallet(style: MultiTextComponent.Style, long: Bool, subtitleLong: Bool = false) -> RowProtocol {
        CellBuilder.row(
                elements: [.multiText, .image20, .margin4, .transparentIconButton, .margin4],
                layoutMargins: UIEdgeInsets(top: 0, left: CellBuilder.defaultMargin, bottom: 0, right: .margin4),
                tableView: tableView,
                id: "row-wallet-\(style)-\(long)-\(subtitleLong)",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: MultiTextComponent) in
                        component.set(style: style)
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)
                        component.subtitleLeft.set(style: .d3)

                        component.title.text = "\(style) " + (long ? "Wallet One Wallet One Wallet One Wallet One Wallet One Wallet One Wallet One" : "Wallet")
                        component.titleBadge.text = "ERC20"
                        component.titleImageLeft.imageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
                        component.titleImageLeft.imageView.contentMode = .scaleAspectFit
                        component.titleImageRight.imageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
                        component.titleImageRight.imageView.contentMode = .scaleAspectFit
                        component.subtitle.text = subtitleLong ? "Right words of sword and game of thrones by Arslan Corporation" : "Right"
                        component.subtitleLeft.text = subtitleLong ? "Left Nizhurin" : "Left"
                        component.subtitleBadge.text = "123"
                    }
                    cell.bind(index: 1) { [unowned self] (component: ImageComponent) in
                        component.isHidden = hiddenMode
                        component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                        component.imageView.tintColor = .themeLucian
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 2) { (component: TransparentIconButtonComponent) in
                        component.button.set(image: UIImage(named: "icon_20"))
                        component.onTap = { print("Did tap edit wallet") }
                    }
                }
        )
    }

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
                elements: [.image20, .text, .secondaryCircleButton, .secondaryCircleButton],
                tableView: tableView,
                id: "row-contract",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "bitcoinsign.square.fill")
                        component.imageView.tintColor = .themeJacob
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: .d1)
                        component.text = "0xai9823nfw2873dmn3498cm3498jf938hdfh98hwe8"
                        component.lineBreakMode = .byTruncatingMiddle
                    }
                    cell.bind(index: 2) { [unowned self] (component: SecondaryCircleButtonComponent) in
                        component.isHidden = self.hiddenMode
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
                elements: [.image20, .multiText, .multiText],
                tableView: tableView,
                id: "row-market-1",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "bitcoinsign.circle")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 1) { (component: MultiTextComponent) in
                        component.set(style: .m3)
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)

                        component.title.text = "Bitcoin"
                        component.title.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                        component.subtitle.text = "BTC"
                        component.subtitleBadge.text = "123"
                    }
                    cell.bind(index: 2) { (component: MultiTextComponent) in
                        component.set(style: .m1)
                        component.titleSpacingView.isHidden = true
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
                elements: [.image20, .multiText, .multiText],
                tableView: tableView,
                id: "row-market-2",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 1) { (component: MultiTextComponent) in
                        component.set(style: .m3)
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)

                        component.title.text = "Ethereum"
                        component.subtitle.text = "ETH"
                        component.subtitleBadge.text = "2"
                    }
                    cell.bind(index: 2) { (component: MultiTextComponent) in
                        component.set(style: .m2)
                        component.titleSpacingView.isHidden = true
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
                elements: [.image20, .text],
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
                        component.imageView.contentMode = .scaleAspectFit
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
                elements: [.image20, .text, .image16],
                tableView: tableView,
                id: "row-settings-1",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "book")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: .b2)
                        component.text = "Academy"
                    }
                    cell.bind(index: 2) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "chevron.forward")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
                    }
                }
        )
    }

    private func rowSettings2() -> RowProtocol {
        CellBuilder.row(
                elements: [.image20, .text, .image20, .margin12, .image16],
                tableView: tableView,
                id: "row-settings-2",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "shield")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: .b2)
                        component.text = "Security Center"
                    }
                    cell.bind(index: 2) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                        component.imageView.tintColor = .themeLucian
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 3) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "chevron.forward")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
                    }
                }
        )
    }

    private func rowSettings3() -> RowProtocol {
        CellBuilder.row(
                elements: [.image20, .text, .text, .margin8, .image16],
                tableView: tableView,
                id: "row-settings-3",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "globe")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
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
                        component.imageView.contentMode = .scaleAspectFit
                    }
                }
        )
    }

    private func rowSettings4() -> RowProtocol {
        CellBuilder.row(
                elements: [.image20, .multiText, .image16],
                tableView: tableView,
                id: "row-settings-4",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "circle")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 1) { (component: MultiTextComponent) in
                        component.set(style: .m1)
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)
                        component.title.text = "Wallet 1"
                        component.subtitle.text = "12 words"
                    }
                    cell.bind(index: 2) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "pencil")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
                    }
                }
        )
    }

    private func rowSettings5() -> RowProtocol {
        CellBuilder.row(
                elements: [.image20, .multiText, .image20, .image16],
                tableView: tableView,
                id: "row-settings-5",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "circle.inset.filled")
                        component.imageView.tintColor = .themeJacob
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 1) { (component: MultiTextComponent) in
                        component.set(style: .m1)
                        component.title.set(style: .b2)
                        component.subtitle.set(style: .d1)
                        component.title.text = "Wallet 2"
                        component.subtitle.text = "24 words"
                    }
                    cell.bind(index: 2) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                        component.imageView.tintColor = .themeLucian
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 3) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "pencil")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
                    }
                }
        )
    }

    private func rowSettings6() -> RowProtocol {
        CellBuilder.row(
                elements: [.image20, .text, .image20, .switch],
                tableView: tableView,
                id: "row-settings-6",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence)

                    cell.bind(index: 0) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "suit.spade")
                        component.imageView.tintColor = .themeGray
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 1) { (component: TextComponent) in
                        component.set(style: .b2)
                        component.text = "Passcode "
                    }
                    cell.bind(index: 2) { (component: ImageComponent) in
                        component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                        component.imageView.tintColor = .themeLucian
                        component.imageView.contentMode = .scaleAspectFit
                    }
                    cell.bind(index: 3) { (component: SwitchComponent) in
                        component.switchView.isOn = true
                        component.onSwitch = { print("Did toggle switch: \($0)") }
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
                        rowWallet(style: .m1, long: true),
                        rowWallet(style: .m1, long: false),
                        rowWallet(style: .m1, long: false, subtitleLong: true),
                        rowWallet(style: .m2, long: true),
                        rowWallet(style: .m2, long: false),
                        rowWallet(style: .m2, long: false, subtitleLong: true),
                        rowWallet(style: .m3, long: true),
                        rowWallet(style: .m3, long: false),
                        rowWallet(style: .m3, long: false, subtitleLong: true),
                        rowWallet(style: .m4, long: true),
                        rowWallet(style: .m4, long: false),
                        rowWallet(style: .m4, long: false, subtitleLong: true),
                        rowWallet(style: .m5, long: true),
                        rowWallet(style: .m5, long: false),
                        rowWallet(style: .m5, long: false, subtitleLong: true),
                        rowWallet(style: .m6, long: true),
                        rowWallet(style: .m6, long: false),
                        rowWallet(style: .m6, long: false, subtitleLong: true),
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
                    ]
            )
        ]
    }

}
