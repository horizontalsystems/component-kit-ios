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

        staticCell.set(backgroundStyle: .bordered)
        CellBuilderNew.build(cell: staticCell, rootElement: .hStack([.image20, .text]))

        staticCell.bindRoot { (stack: StackComponent) in
            stack.bind(index: 0) { (component: ImageComponent) in
                component.imageView.image = UIImage(systemName: "airplane")
                component.imageView.tintColor = .themeGray
                component.imageView.contentMode = .scaleAspectFit
            }
            stack.bind(index: 1) { (component: TextComponent) in
                component.set(style: .b2)
                component.text = "Static Airplane Cell"
            }
        }

        tableView.buildSections()
    }

    @objc private func onChange() {
        hiddenMode = !hiddenMode
        tableView.reload()
    }

}

extension CellsController: SectionsDataSource {

    private func rowSpinner() -> RowProtocol {
        CellBuilderNew.selectableRow(
                rootElement: .hStack([
                    .text,
                    .spinner20
                ]),
                tableView: tableView,
                id: "row-spinner",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered, isFirst: true)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: TextComponent) in
                            component.set(style: .d2)
                            component.text = "Spinner"
                        }
                    }
                }
        )
    }

    private func rowDeterminiteSpinner() -> RowProtocol {
        CellBuilderNew.selectableRow(
                rootElement: .hStack([
                    .text,
                    .determiniteSpinner20
                ]),
                tableView: tableView,
                id: "row-determinite-spinner",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: TextComponent) in
                            component.set(style: .d2)
                            component.text = "Determinite Spinner"
                        }
                        stack.bind(index: 1) { (component: DeterminiteSpinnerComponent) in
                            component.set(progress: 0.75)
                        }
                    }
                }
        )
    }

    private func rowWallet1New() -> RowProtocol {
        CellBuilderNew.row(
                rootElement: .hStack([
                    .vStackCentered([
                        .text,
                        .margin(3),
                        .text,
                    ]),
                    .image20, .margin4,
                    .transparentIconButton
                ]),
                layoutMargins: UIEdgeInsets(top: 0, left: CellBuilder.defaultMargin, bottom: 0, right: .margin4),
                tableView: tableView,
                id: "row-wallet-1",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (stack: StackComponent) in
                            stack.bind(index: 0) { (component: TextComponent) in
                                component.set(style: .b2)
                                component.text = "Wallet One"
                            }
                            stack.bind(index: 1) { (component: TextComponent) in
                                component.set(style: .d1)
                                component.text = "Subtitle"
                            }
                        }
                        stack.bind(index: 1) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                            component.imageView.tintColor = .themeLucian
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 2) { (component: TransparentIconButtonComponent) in
                            component.button.set(image: UIImage(named: "icon_20"))
                            component.onTap = { print("Did tap edit wallet") }
                        }
                    }
                }
        )
    }

    private func rowMarketCap() -> RowProtocol {
        CellBuilderNew.row(
                rootElement: .hStack([
                    .text, .margin8,
                    .badge,
                    .text
                ]),
                tableView: tableView,
                id: "row-market-cap",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: TextComponent) in
                            component.set(style: .d1)
                            component.text = "Market Cap"
                            component.setContentHuggingPriority(.required, for: .horizontal)
                        }
                        stack.bind(index: 1) { (component: BadgeComponent) in
                            component.badgeView.set(style: .small)
                            component.badgeView.text = "12"
                        }
                        stack.bind(index: 2) { (component: TextComponent) in
                            component.set(style: .c2)
                            component.text = "$74.7 B"
                            component.textAlignment = .right
                        }
                    }
                }
        )
    }

    private func rowContract() -> RowProtocol {
        CellBuilderNew.row(
                rootElement: .hStack([
                    .image20,
                    .text,
                    .secondaryCircleButton,
                    .secondaryCircleButton
                ]),
                tableView: tableView,
                id: "row-contract",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "bitcoinsign.square.fill")
                            component.imageView.tintColor = .themeJacob
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 1) { (component: TextComponent) in
                            component.set(style: .d1)
                            component.text = "0xai9823nfw2873dmn3498cm3498jf938hdfh98hwe8"
                            component.lineBreakMode = .byTruncatingMiddle
                        }
                        stack.bind(index: 2) { [unowned self] (component: SecondaryCircleButtonComponent) in
                            component.isHidden = self.hiddenMode
                            component.button.set(image: UIImage(systemName: "shippingbox"))
                            component.onTap = { print("Did tap copy") }
                        }
                        stack.bind(index: 3) { (component: SecondaryCircleButtonComponent) in
                            component.button.set(image: UIImage(systemName: "globe"))
                            component.onTap = { print("Did tap globe") }
                        }
                    }
                }
        )
    }

    private func rowMarket1() -> RowProtocol {
        CellBuilderNew.row(
                rootElement: .hStack([
                    .image20,
                    .vStackCentered([
                        .text, .margin(3),
                        .hStack([
                            .badge, .margin8,
                            .text
                        ])
                    ]),
                    .vStackCentered([
                        .text, .margin(3),
                        .text
                    ]),
                ]),
                tableView: tableView,
                id: "row-market-1",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "bitcoinsign.circle")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 1) { (stack: StackComponent) in
                            stack.bind(index: 0) { (component: TextComponent) in
                                component.set(style: .b2)
                                component.text = "Bitcoin"
                            }
                            stack.bind(index: 1) { (stack: StackComponent) in
                                stack.bind(index: 0) { (component: BadgeComponent) in
                                    component.badgeView.set(style: .small)
                                    component.badgeView.text = "123"
                                }
                                stack.bind(index: 1) { (component: TextComponent) in
                                    component.set(style: .d1)
                                    component.text = "BTC"
                                }
                            }
                        }
                        stack.bind(index: 2) { (stack: StackComponent) in
                            stack.bind(index: 0) { (component: TextComponent) in
                                component.set(style: .b2)
                                component.textAlignment = .right
                                component.text = "$65,145"
                            }
                            stack.bind(index: 1) { (component: TextComponent) in
                                component.set(style: .d4)
                                component.textAlignment = .right
                                component.text = "+2.35%"
                            }
                        }
                    }
                }
        )
    }

    private func rowMarket2() -> RowProtocol {
        CellBuilderNew.row(
                rootElement: .hStack([
                    .image20,
                    .vStackCentered([
                        .hStack([
                            .text,
                            .text
                        ]),
                        .margin(3),
                        .hStack([
                            .badge, .margin8,
                            .text,
                            .text
                        ]),
                    ]),
                ]),
                tableView: tableView,
                id: "row-market-2",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "bitcoinsign.circle")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 1) { (stack: StackComponent) in
                            stack.bind(index: 0) { (stack: StackComponent) in
                                stack.bind(index: 0) { (component: TextComponent) in
                                    component.set(style: .b2)
                                    component.text = "Ethereum"
                                }
                                stack.bind(index: 1) { (component: TextComponent) in
                                    component.set(style: .b2)
                                    component.textAlignment = .right
                                    component.text = "$12,153"
                                }
                            }
                            stack.bind(index: 1) { (stack: StackComponent) in
                                stack.bind(index: 0) { (component: BadgeComponent) in
                                    component.badgeView.set(style: .small)
                                    component.badgeView.text = "12"
                                }
                                stack.bind(index: 1) { (component: TextComponent) in
                                    component.set(style: .d1)
                                    component.text = "ETH"
                                }
                                stack.bind(index: 2) { (component: TextComponent) in
                                    component.set(style: .d4)
                                    component.textAlignment = .right
                                    component.text = "-1.53%"
                                }
                            }
                        }
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
        let backgroundStyle: BaseThemeCell.BackgroundStyle = .bordered
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        let textStyle: TextComponent.Style = .d2

        return CellBuilderNew.row(
                rootElement: .hStack([.image20, .text]),
                tableView: tableView,
                id: "row-multiline",
                dynamicHeight: { containerWidth in
                    CellBuilderNew.height(
                            containerWidth: containerWidth,
                            backgroundStyle: backgroundStyle,
                            text: text,
                            textStyle: textStyle,
                            elements: [.fixed(width: 20), .multiline]
                    )
                },
                bind: { cell in
                    cell.set(backgroundStyle: backgroundStyle)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "square")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 1) { (component: TextComponent) in
                            component.set(style: textStyle)
                            component.text = text
                            component.numberOfLines = 0
                        }
                    }
                }
        )
    }

    private func rowMultiline2() -> RowProtocol {
        let backgroundStyle: BaseThemeCell.BackgroundStyle = .bordered
        let titleTextStyle: TextComponent.Style = .d1
        let titleText = "Title"
        let textStyle: TextComponent.Style = .g2
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."

        return CellBuilderNew.row(
                rootElement: .hStack([.text, .text]),
                tableView: tableView,
                id: "row-multiline-2",
                dynamicHeight: { containerWidth in
                    CellBuilderNew.height(
                            containerWidth: containerWidth,
                            backgroundStyle: backgroundStyle,
                            text: text,
                            textStyle: textStyle,
                            elements: [.fixed(width: TextComponent.width(style: titleTextStyle, text: titleText)), .multiline]
                    )
                },
                bind: { cell in
                    cell.set(backgroundStyle: backgroundStyle)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: TextComponent) in
                            component.set(style: titleTextStyle)
                            component.text = titleText
                        }
                        stack.bind(index: 1) { (component: TextComponent) in
                            component.set(style: textStyle)
                            component.text = text
                            component.numberOfLines = 0
                        }
                    }
                }
        )
    }

    private func rowSettings1() -> RowProtocol {
        CellBuilderNew.row(
                rootElement: .hStack([.image20, .text, .image16]),
                tableView: tableView,
                id: "row-settings-1",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "book")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 1) { (component: TextComponent) in
                            component.set(style: .b2)
                            component.text = "Academy"
                        }
                        stack.bind(index: 2) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "chevron.forward")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                    }
                }
        )
    }

    private func rowSettings2() -> RowProtocol {
        CellBuilderNew.row(
                rootElement: .hStack([.image20, .text, .image20, .margin12, .image16]),
                tableView: tableView,
                id: "row-settings-2",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "shield")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 1) { (component: TextComponent) in
                            component.set(style: .b2)
                            component.text = "Security Center"
                        }
                        stack.bind(index: 2) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                            component.imageView.tintColor = .themeLucian
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 3) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "chevron.forward")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                    }
                }
        )
    }

    private func rowSettings3() -> RowProtocol {
        CellBuilderNew.row(
                rootElement: .hStack([.image20, .text, .text, .margin8, .image16]),
                tableView: tableView,
                id: "row-settings-3",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "globe")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 1) { (component: TextComponent) in
                            component.set(style: .b2)
                            component.text = "Language"
                        }
                        stack.bind(index: 2) { (component: TextComponent) in
                            component.set(style: .c1)
                            component.text = "English"
                            component.setContentCompressionResistancePriority(.required, for: .horizontal)
                            component.setContentHuggingPriority(.required, for: .horizontal)
                        }
                        stack.bind(index: 3) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "chevron.forward")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                    }
                }
        )
    }

    private func rowSettings4() -> RowProtocol {
        CellBuilderNew.row(
                rootElement: .hStack([.image20, .vStackCentered([.text, .margin(3), .text]), .image16]),
                tableView: tableView,
                id: "row-settings-4",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "circle")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 1) { (stack: StackComponent) in
                            stack.bind(index: 0) { (component: TextComponent) in
                                component.set(style: .b2)
                                component.text = "Wallet 1"
                            }
                            stack.bind(index: 1) { (component: TextComponent) in
                                component.set(style: .d1)
                                component.text = "12 words"
                            }
                        }
                        stack.bind(index: 2) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "pencil")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                    }
                }
        )
    }

    private func rowSettings5() -> RowProtocol {
        CellBuilderNew.row(
                rootElement: .hStack([.image20, .vStackCentered([.text, .margin(3), .text]), .image20, .image16]),
                tableView: tableView,
                id: "row-settings-5",
                height: .heightDoubleLineCell,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "circle.inset.filled")
                            component.imageView.tintColor = .themeJacob
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 1) { (stack: StackComponent) in
                            stack.bind(index: 0) { (component: TextComponent) in
                                component.set(style: .b2)
                                component.text = "Wallet 2"
                            }
                            stack.bind(index: 1) { (component: TextComponent) in
                                component.set(style: .d1)
                                component.text = "24 words"
                            }
                        }
                        stack.bind(index: 2) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                            component.imageView.tintColor = .themeLucian
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 3) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "pencil")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                    }
                }
        )
    }

    private func rowSettings6() -> RowProtocol {
        CellBuilderNew.selectableRow(
                rootElement: .hStack([.image20, .text, .image20, .switch]),
                tableView: tableView,
                id: "row-settings-6",
                height: .heightCell48,
                bind: { cell in
                    cell.set(backgroundStyle: .bordered, isLast: true)

                    cell.bindRoot { (stack: StackComponent) in
                        stack.bind(index: 0) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "suit.spade")
                            component.imageView.tintColor = .themeGray
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 1) { (component: TextComponent) in
                            component.set(style: .b2)
                            component.text = "Passcode "
                        }
                        stack.bind(index: 2) { (component: ImageComponent) in
                            component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                            component.imageView.tintColor = .themeLucian
                            component.imageView.contentMode = .scaleAspectFit
                        }
                        stack.bind(index: 3) { (component: SwitchComponent) in
                            component.switchView.isOn = true
                            component.onSwitch = {
                                print("Did toggle switch: \($0)")
                            }
                        }
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
                        rowSpinner(),
                        rowDeterminiteSpinner(),
                        rowWallet1New(),
                        rowMarketCap(),
                        rowContract(),
                        rowMarket1(),
                        rowMarket2(),
                        rowStatic(),
                        rowMultiline(),
                        rowMultiline2(),
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
