import UIKit
import ThemeKit
import SnapKit
import PinKit
import StorageKit
import RxSwift

class PinController: ThemeViewController {
    private let disposeBag = DisposeBag()

    private let pinLabel = UILabel()

    private let clearPinButton = UIButton.appRed
    private let setPinButton = UIButton.appGreen
    private let editPinButton = UIButton.appGray

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onToggleLightMode))

        view.addSubview(pinLabel)
        pinLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(CGFloat.margin4x)
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(CGFloat.margin4x)
        }
        pinLabel.font = .headline2
        pinLabel.textColor = .themeJacob
        pinLabel.textAlignment = .center

        App.shared.pinKit.isPinSetObservable
                .subscribe { isPinSet in
                    self.updateUI()
                }
                .disposed(by: disposeBag)

        view.addSubview(clearPinButton)
        view.addSubview(setPinButton)
        view.addSubview(editPinButton)

        clearPinButton.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(CGFloat.margin4x)
            maker.top.equalTo(pinLabel.snp.bottom).offset(CGFloat.margin4x)
            maker.height.equalTo(CGFloat.heightButton)
        }
        setPinButton.snp.makeConstraints { maker in
            maker.leading.equalTo(clearPinButton.snp.trailing).offset(CGFloat.margin4x)
            maker.top.equalTo(pinLabel.snp.bottom).offset(CGFloat.margin4x)
            maker.width.equalTo(clearPinButton.snp.width)
            maker.height.equalTo(CGFloat.heightButton)

        }
        editPinButton.snp.makeConstraints { maker in
            maker.leading.equalTo(setPinButton.snp.trailing).offset(CGFloat.margin4x)
            maker.trailing.equalToSuperview().inset(CGFloat.margin4x)
            maker.top.equalTo(pinLabel.snp.bottom).offset(CGFloat.margin4x)
            maker.width.equalTo(clearPinButton.snp.width)
            maker.height.equalTo(CGFloat.heightButton)
        }

        clearPinButton.setTitle("Clear Pin", for: .normal)
        setPinButton.setTitle("Set Pin", for: .normal)
        editPinButton.setTitle("Edit Pin", for: .normal)

        clearPinButton.addTarget(self, action: #selector(onClearPin), for: .touchUpInside)
        setPinButton.addTarget(self, action: #selector(onSetPin), for: .touchUpInside)
        editPinButton.addTarget(self, action: #selector(onEditPin), for: .touchUpInside)

        updateUI()

        App.shared.pinKit.lock()
    }

    private func updateUI() {
        let isPinSet = App.shared.pinKit.isPinSet

        pinLabel.text = "Pin \(isPinSet ? "was set" : "not set!")"

        clearPinButton.isEnabled = isPinSet
        setPinButton.isEnabled = !isPinSet
        editPinButton.isEnabled = isPinSet
    }

    @objc func onToggleLightMode() {
        ThemeManager.shared.lightMode = !ThemeManager.shared.lightMode
        UIApplication.shared.keyWindow?.set(newRootController: MainController(selectedIndex: 3))
    }

    @objc func onClearPin() {
        do {
            try App.shared.pinKit.clear()

            updateUI()
        } catch {
            print("Can't clear pin \(error)")
        }
    }

    @objc func onSetPin() {
        present(App.shared.pinKit.setPinModule(delegate: self), animated: true)
    }

    @objc func onEditPin() {
        present(App.shared.pinKit.editPinModule, animated: true)
    }

}

extension PinController: ISetPinDelegate {

    public func didCancelSetPin() {
        print("Cancel Set Pin!")
    }

}
