import UIKit

open class ThemeNavigationController: UINavigationController {

    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    private func commonInit() {
        navigationBar.prefersLargeTitles = true
        modalPresentationStyle = .fullScreen
        navigationBar.tintColor = .themeJacob
        // set navigation theme for iOS less than 13
        guard #available(iOS 13.0, *) else {
            navigationBar.barStyle = Theme.current.navigationBarStyle
            let colorImage = UIImage(color: .themeNavigationBarBackground)
            navigationBar.setBackgroundImage(colorImage, for: .default)
            navigationBar.shadowImage = UIImage()
            return
        }
    }

    override open var childForStatusBarStyle: UIViewController? {
        self.topViewController
    }

    override open var childForStatusBarHidden: UIViewController? {
        self.topViewController
    }

}

open class ThemeTabBarController: UITabBarController {

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        tabBar.shadowImage = UIImage()
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: 10000, height: 1 / UIScreen.main.scale))
        separator.backgroundColor = .themeSteel20
        tabBar.addSubview(separator)

        tabBar.barTintColor = .clear
        tabBar.backgroundImage = UIImage(color: .themeNavigationBarBackground)

        tabBar.tintColor = .themeJacob
        tabBar.unselectedItemTintColor = .themeGray
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBar.superview?.setNeedsLayout()
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        .themeDefault
    }

}

open class ThemeViewController: UIViewController {
    private let gradient: Bool

    public init(gradient: Bool = true) {
        self.gradient = gradient

        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .fullScreen
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        guard gradient else {
            return
        }

        let bounds = view.bounds
        let gradientStartY = 160 / bounds.height
        let image = UIImage(
                fromColor: .themeTyler,
                toColor: .themeHelsing,
                size: CGSize(width: view.bounds.size.width, height: view.bounds.size.height),
                startPoint: CGPoint(x: 0.5, y: gradientStartY)
        )
        let gradientImageView = UIImageView(image: image)

        view = gradientImageView
        gradientImageView.isUserInteractionEnabled = true
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        .themeDefault
    }

}
