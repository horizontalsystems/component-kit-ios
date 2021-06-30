import UIKit
import SnapKit
import ThemeKit
import ComponentKit

class PinViewController: ThemeViewController {
    private let keyboardSideMargin: CGFloat = UIScreen.main.bounds.width <= 320 ? 32 : 48 // decrease margin only for small screen

    let delegate: IPinViewDelegate

    private let holderView = UIScrollView()
    private let numPad = NumPad()

    private var pages = [PinPage]()
    private var pinViews = [PinView]()

    private let lockoutView = LockoutView()

    private var currentPage = 0

    private let insets: UIEdgeInsets

    init(delegate: IPinViewDelegate, insets: UIEdgeInsets = .zero) {
        self.delegate = delegate
        self.insets = insets

        super.init()

        numPad.append(style: .letters)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let insets = UIEdgeInsets(top: self.insets.top, left: self.insets.left, bottom: CGFloat.margin8x + self.insets.bottom, right: self.insets.right)

        view.addSubview(holderView)
        holderView.isScrollEnabled = false
        holderView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide).offset(insets.top)
            maker.leading.equalToSuperview().offset(insets.left)
            maker.trailing.equalToSuperview().inset(insets.right)
        }
        holderView.backgroundColor = .clear

        view.addSubview(numPad)
        numPad.snp.makeConstraints { maker in
            maker.top.equalTo(holderView.snp.bottom)
            maker.bottom.equalTo(view.safeAreaLayoutGuide).inset(insets.bottom)
            maker.leading.equalToSuperview().offset(keyboardSideMargin + insets.left)
            maker.trailing.equalToSuperview().inset(keyboardSideMargin + insets.right)
            maker.height.equalTo(numPad.height(for: view.bounds.width - 2 * keyboardSideMargin - insets.width))
        }

        numPad.numPadDelegate = self

        view.addSubview(lockoutView)
        lockoutView.hide()
        lockoutView.snp.makeConstraints { maker in
            maker.edges.equalTo(self.holderView)
        }

        delegate.viewDidLoad()
    }

    @objc func onCancelTap() {
        delegate.onCancel()
    }

    func reload(at index: Int) {
        pinViews[index].bind(page: pages[index]) { [weak self] pin in
            self?.delegate.onEnter(pin: pin, forPage: index)
        }
    }

}

extension PinViewController: NumPadDelegate {

    func numPadDidClick(digit: String) {
        pinViews[currentPage].pinDotsView.append(digit: digit)
    }

    func numPadDidClickBackspace() {
        pinViews[currentPage].pinDotsView.removeLastDigit()
    }

    func numPadDidClickBiometry() {
        delegate.onTapBiometric()
    }

}

extension PinViewController: IPinView {

    func set(title: String) {
        self.title = title.localized
    }

    func set(biometryUnlockMode: BiometryUnlockMode, biometryType: BiometryType?, biometryEnabled: Bool) {
        if biometryUnlockMode != .disabled, biometryEnabled {
            numPad.append(style: .biometry)
        }
        numPad.set(biometryType: biometryType)
    }

    func addPage(withDescription description: String) {
        let isTitle = navigationController?.isNavigationBarHidden ?? true
        let page = PinPage(description: description, isTitle: isTitle)
        pages.append(page)

        let pinView = PinView()
        pinViews.append(pinView)

        reload(at: pinViews.count - 1)

        holderView.addSubview(pinView)
        var previousView: UIView?
        for view in holderView.subviews {
            view.snp.remakeConstraints { maker in
                maker.width.height.equalToSuperview()
                maker.top.bottom.equalTo(self.holderView)

                if view == holderView.subviews.first {
                    maker.leading.equalToSuperview()
                } else if view == holderView.subviews.last {
                    maker.trailing.equalToSuperview()
                }
                if let previousView = previousView {
                    maker.leading.equalTo(previousView.snp.trailing)
                }
            }
            previousView = view
        }
    }

    func show(page index: Int) {
        currentPage = index

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.holderView.setContentOffset(CGPoint(x: index * Int(UIScreen.main.bounds.width), y: 0), animated: true)
            self.reload(at: index)
        }
    }

    func show(error: String, forPage index: Int) {
        pages[index].error = error.localized
        reload(at: index)
    }

    func show(error: String) {
        HudHelper.instance.showError(title: error.localized)
    }

    func showPinWrong(page index: Int) {
        pinViews[index].shakeAndClear()
    }

    func showCancel() {
        if navigationController?.isNavigationBarHidden ?? true {
            pinViews[currentPage].showCancelButton(target: self, action: #selector(onCancelTap))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "pin.button.cancel".localized, style: .plain, target: self, action: #selector(onCancelTap))
        }
    }

    func showSuccess() {
        HudHelper.instance.showSuccess()
    }

    func showLockView(till date: Date) {
        lockoutView.show(expirationDate: date)
        holderView.isHidden = true
        numPad.disable()
    }

    func show(attemptsLeft: Int?, forPage index: Int) {
        lockoutView.hide()
        holderView.isHidden = false
        numPad.enable()
    }

}

struct PinPage {
    var description: String?
    var error: String?
    var isTitle: Bool

    init(description: String, isTitle: Bool) {
        self.description = description
        self.isTitle = isTitle
    }

}
