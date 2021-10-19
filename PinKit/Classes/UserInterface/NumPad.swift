import UIKit
import SnapKit
import ComponentKit

class NumPad: UICollectionView {
    private var enabled = true
    private let columnCount: CGFloat = 3
    private let rowCount: CGFloat = 4

    private let itemSizeRatio: CGFloat = 1.26
    private let itemLineSpacingRatio: CGFloat = 5

    private enum Cell {
        case number(number: String, letters: String?, filled: Bool, action: () -> ())
        case image(image: UIImage?, pressedTintColor: UIColor, enabled: Bool, action: (() -> ())?)
    }

    public struct Style: OptionSet {
        let rawValue: Int

        public static let decimal = Style(rawValue: 1 << 1)
        public static let letters = Style(rawValue: 1 << 2)
        public static let biometry = Style(rawValue: 1 << 3)
    }

    weak var numPadDelegate: NumPadDelegate?
    private let layout = UICollectionViewFlowLayout()

    private let formatter = NumberFormatter()

    private var cells = [Cell]()
    private var style = Style()

    private var biometryType: BiometryType?

    init() {
        super.init(frame: .zero, collectionViewLayout: layout)

        dataSource = self
        delegate = self

        formatter.numberStyle = .decimal

        register(NumPadNumberCell.self, forCellWithReuseIdentifier: String(describing: NumPadNumberCell.self))
        register(NumPadImageCell.self, forCellWithReuseIdentifier: String(describing: NumPadImageCell.self))

        backgroundColor = .clear

        isScrollEnabled = false

        buildItems()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        reloadData()
    }

    private func buildItems() {
        cells = [Cell]()

        let localizedOne = format(number: 1)
        cells.append(.number(number: localizedOne, letters: style.contains(.letters) ? " " : nil, filled: true, action: { [weak self] in self?.numPadDidClick(digit: localizedOne) }))
        for i in 2...9 {
            let localizedNumber = format(number: i)
            cells.append(.number(number: localizedNumber, letters: letters(for: i), filled: true, action: { [weak self] in self?.numPadDidClick(digit: localizedNumber) }))
        }
        if style.contains(.decimal), let decimalSeparator = formatter.decimalSeparator {
            cells.append(.number(number: decimalSeparator, letters: nil, filled: false, action: { [weak self] in self?.numPadDidClick(digit: decimalSeparator) }))
        } else if style.contains(.biometry) {
            let image: UIImage? = biometryType.flatMap {
                switch $0 {
                case .faceId: return PinKit.image(named: "Face Id")
                case .touchId: return PinKit.image(named: "Touch Id")
                case .none: return nil
                }
            }
            cells.append(.image(image: image, pressedTintColor: .themeGray50, enabled: true, action: { [weak self] in self?.numPadDelegate?.numPadDidClickBiometry() }))
        } else {
            cells.append(.image(image: nil, pressedTintColor: .white, enabled: false, action: nil))
        }
        let localizedZero = format(number: 0)
        cells.append(.number(number: localizedZero, letters: nil, filled: true, action: { [weak self] in self?.numPadDidClick(digit: localizedZero) }))
        cells.append(.image(image: PinKit.image(named: "Backspace Medium"), pressedTintColor: .themeGray50, enabled: enabled, action: { [weak self] in self?.numPadDidClickBackspace() }))
    }

    private var itemWidth: CGFloat {
        floor(bounds.width / (columnCount * itemSizeRatio))      // Width for column count digit items
    }

    private var interitemSpacing: CGFloat {
        floor((bounds.width - columnCount * bounds.width / (columnCount * itemSizeRatio)) / (columnCount - 1)) // width witout items divided on interitem spacing count
    }

    private var lineSpacing: CGFloat {
        floor(bounds.width / (columnCount * itemSizeRatio) / itemLineSpacingRatio)   // height for line spacing
    }

    private func letters(for index: Int) -> String? {
        style.contains(.letters) ? "numpad_\(index)".localized : nil
    }

    private func format(number: Int) -> String {
        formatter.string(from: number as NSNumber) ?? ""
    }

    private func numPadDidClick(digit: String) {
        guard enabled else {
            return
        }

        numPadDelegate?.numPadDidClick(digit: digit)
    }

    private func numPadDidClickBackspace() {
        guard enabled else {
            return
        }

        numPadDelegate?.numPadDidClickBackspace()
    }

    public func height(for width: CGFloat) -> CGFloat {
        ceil(rowCount * width / (columnCount * itemSizeRatio) + (rowCount - 1) * width / (columnCount * itemSizeRatio) /  itemLineSpacingRatio) // sum of item heights and line spacing between them
    }

    public func append(style: Style) {
        self.style.insert(style)

        buildItems()
        reloadData()
    }

    public func set(biometryType: BiometryType?) {
        self.biometryType = biometryType

        buildItems()
        reloadData()
    }

    func disable() {
        enabled = false

        buildItems()
        reloadData()
    }

    func enable() {
        enabled = true

        buildItems()
        reloadData()
    }
}

extension NumPad: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String

        switch cells[indexPath.item] {
        case .number: identifier = String(describing: NumPadNumberCell.self)
        case .image: identifier = String(describing: NumPadImageCell.self)
        }

        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }

}

extension NumPad: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch cells[indexPath.item] {
        case .number(let number, let letters, let filled, let action):
            if let cell = cell as? NumPadNumberCell {
                cell.bind(number: number, letters: letters, filled: filled, enabled: enabled, cornerRadius: ceil(itemWidth / 2), onTap: action)
            }
        case .image(let image, let pressedTintColor, let disabled, let action):
            if let cell = cell as? NumPadImageCell {
                cell.bind(image: image, pressedTintColor: pressedTintColor, enabled: disabled, onTap: action)
            }
        }
    }

}

extension NumPad: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: itemWidth, height: itemWidth)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        interitemSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing
    }

}

class NumPadNumberCell: UICollectionViewCell {

    private let button = UIButton()
    private let textHolderView = UIView()
    private let numberLabel = UILabel()
    private let lettersLabel = UILabel()
    private var onTap: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(button)
        button.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        button.borderWidth = .heightOneDp
        button.cornerRadius = 36

        button.addSubview(textHolderView)
        textHolderView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.leading.greaterThanOrEqualToSuperview()
            maker.trailing.lessThanOrEqualToSuperview()
        }

        textHolderView.addSubview(numberLabel)
        numberLabel.font = .title2R
        numberLabel.textColor = .themeOz

        textHolderView.addSubview(lettersLabel)
        lettersLabel.font = .micro
        lettersLabel.textColor = .themeGray50

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(number: String, letters: String?, filled: Bool, enabled: Bool, cornerRadius: CGFloat, onTap: @escaping () -> ()) {
        button.isEnabled = enabled
        button.cornerRadius = cornerRadius
        button.setBackgroundColor(color: .clear, forState: .normal)

        if filled {
            button.borderColor = .themeSteel20
            button.setBackgroundColor(color: .themeJeremy, forState: .highlighted)
        } else {
            button.borderColor = .clear
            button.setBackgroundColor(color: .clear, forState: .highlighted)
        }

        numberLabel.text = number
        lettersLabel.text = letters
        if enabled {
            numberLabel.textColor = .themeOz
            lettersLabel.textColor = .themeGray50
        } else {
            numberLabel.textColor = .themeSteel10
            lettersLabel.textColor = .themeSteel20
        }

        self.onTap = onTap

        lettersLabel.isHidden = letters == nil

        numberLabel.snp.remakeConstraints { maker in
            maker.centerX.equalToSuperview()

            if letters == nil {
                maker.centerY.equalToSuperview()
            } else {
                maker.top.equalToSuperview()
            }
        }
        lettersLabel.snp.remakeConstraints { maker in
            maker.centerX.equalToSuperview()

            if letters != nil {
                maker.top.equalTo(numberLabel.snp.bottom).offset(-3)
                maker.bottom.equalToSuperview()
            }
        }
    }

    @objc func didTapButton() {
        onTap?()
    }

}

class NumPadImageCell: UICollectionViewCell {

    private let button = ThemeButton()
    private var onTap: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(button)
        button.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(image: UIImage?, pressedTintColor: UIColor, enabled: Bool, onTap: (() -> ())?) {
        self.onTap = onTap
        button.isEnabled = enabled
        button.setImage(image?.withTintColor(.themeGray), for: .normal)
        button.setImage(image?.withTintColor(.themeSteel20), for: .disabled)
        button.setImage(image?.withTintColor(pressedTintColor), for: .highlighted)
    }

    @objc func didTapButton() {
        onTap?()
    }

}

protocol NumPadDelegate: AnyObject {
    func numPadDidClick(digit: String)
    func numPadDidClickBackspace()
    func numPadDidClickBiometry()
}
