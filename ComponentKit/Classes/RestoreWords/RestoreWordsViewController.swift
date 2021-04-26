import UIKit
import SnapKit
import ThemeKit

open class RestoreWordsViewController: ThemeViewController {
    private let minimalTextViewHeight: CGFloat = 88
    private let textViewInset: CGFloat = .margin3x
    private let textViewFont: UIFont = .body

    private let containerView = UIView()
    private let textView = UITextView()

    open var descriptionText: String? { nil }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        view.addSubview(containerView)
        containerView.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.leading.trailing.bottom.equalToSuperview()
        }

        textView.keyboardAppearance = .themeDefault
        textView.backgroundColor = .themeLawrence
        textView.layer.cornerRadius = .cornerRadius2x
        textView.layer.borderWidth = .heightOnePixel
        textView.layer.borderColor = UIColor.themeSteel20.cgColor
        textView.textColor = .themeOz
        textView.font = textViewFont
        textView.tintColor = .themeJacob
        textView.textContainerInset = UIEdgeInsets(top: textViewInset, left: textViewInset, bottom: textViewInset, right: textViewInset)
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no

        textView.delegate = self

        containerView.addSubview(textView)
        textView.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(view).inset(CGFloat.margin4x)
            maker.top.equalToSuperview().offset(CGFloat.margin3x)
            maker.height.greaterThanOrEqualTo(minimalTextViewHeight).priority(.required)
            maker.height.equalTo(0).priority(.low)
        }

        let descriptionView = BottomDescriptionView()
        descriptionView.bind(text: descriptionText)

        containerView.addSubview(descriptionView)
        descriptionView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        descriptionView.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(view)
            maker.top.equalTo(textView.snp.bottom)
            maker.bottom.lessThanOrEqualToSuperview()
        }

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        view.layoutIfNeeded()
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.async  {
            self.textView.becomeFirstResponder()
        }
    }

    public func show(defaultWords: [String]) {
        let words = defaultWords.joined(separator: " ")
        textView.text = words

        DispatchQueue.main.async {
            self.updateTextViewConstraints(for: words, animated: false)
        }
    }

    public func show(error: Error) {
        HudHelper.instance.showError(title: error.localizedDescription)
    }

    public var words: [String] {
        let text = textView.text ?? ""
        let components = text.components(separatedBy: .whitespacesAndNewlines)

        return components.filter { !$0.isEmpty }.map { $0.lowercased() }
    }

    @objc private func keyboardWillChangeFrame(notification: Notification) {
        if let info = notification.userInfo,
           let endFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
           let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
                guard let superview = containerView.superview else {
                    return
                }
                let inset = endFrame.origin.y >= view.height ? 0 : endFrame.height
                containerView.snp.updateConstraints { maker in
                    maker.bottom.equalTo(self.view).inset(inset)
                }
                UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
                    superview.layoutIfNeeded()
                })
        }
    }

    private func height(text: String) -> CGFloat {
        let containerWidth = textView.bounds.width - 2 * textViewInset - 2 * textView.textContainer.lineFragmentPadding
        let textHeight = text.height(forContainerWidth: containerWidth, font: textViewFont)
        return textHeight + 2 * textViewInset
    }

    private func updateTextViewConstraints(for text: String, animated: Bool = true) {
        textView.snp.updateConstraints { maker in
            maker.height.equalTo(height(text: text)).priority(.low)
        }

        if animated {
            UIView.animate(withDuration: .themeAnimationDuration) {
                self.view.layoutIfNeeded()
            }
        } else {
            view.layoutIfNeeded()
        }
    }

}

extension RestoreWordsViewController: UITextViewDelegate {

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        updateTextViewConstraints(for: newText)

        return true
    }

}
