import UIKit
import ThemeKit
import SnapKit

class MainController: ThemeTabBarController {

    init(selectedIndex: Int = 0) {
        super.init()

        App.shared.pinKitDelegate.viewController = self

        let colorsTitle = "Colors"
        let colorsController = ColorsController()
        colorsController.title = colorsTitle
        colorsController.tabBarItem = UITabBarItem(title: colorsTitle, image: UIImage(named: "TabBar Icon"), tag: 0)

        let fontsTitle = "Fonts"
        let fontsController = FontsController()
        fontsController.title = fontsTitle
        fontsController.tabBarItem = UITabBarItem(title: fontsTitle, image: UIImage(named: "TabBar Icon"), tag: 1)

        let cellsTitle = "Cells"
        let cellsController = CellsController()
        cellsController.title = cellsTitle
        cellsController.tabBarItem = UITabBarItem(title: cellsTitle, image: UIImage(named: "TabBar Icon"), tag: 2)

        let pinTitle = "Pin"
        let pinController = PinController()
        pinController.title = pinTitle
        pinController.tabBarItem = UITabBarItem(title: pinTitle, image: UIImage(named: "TabBar Icon"), tag: 3)

        viewControllers = [
            ThemeNavigationController(rootViewController: colorsController),
            ThemeNavigationController(rootViewController: fontsController),
            ThemeNavigationController(rootViewController: cellsController),
            ThemeNavigationController(rootViewController: pinController),
        ]

        self.selectedIndex = selectedIndex
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
