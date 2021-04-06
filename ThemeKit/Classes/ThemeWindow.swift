import UIKit
import RxSwift

open class ThemeWindow: UIWindow {
    private let disposeBag = DisposeBag()

    public override init(frame: CGRect) {
        super.init(frame: frame)

        update(themeMode: ThemeManager.shared.themeMode)

        ThemeManager.shared.changeThemeSignal
                .emit(onNext: { [weak self] themeMode in
                    self?.update(themeMode: themeMode)
                })
                .disposed(by: disposeBag)

        backgroundColor = .themeTyler
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func update(themeMode: ThemeMode) {
        UIView.transition (with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            switch themeMode {
            case .system:
                self.overrideUserInterfaceStyle = .unspecified
            case .dark:
                self.overrideUserInterfaceStyle = .dark
            case .light:
                self.overrideUserInterfaceStyle = .light
            }
        }, completion: nil)
    }

}
