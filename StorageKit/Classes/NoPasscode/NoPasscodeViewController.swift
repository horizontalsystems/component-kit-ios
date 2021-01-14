import UIKit
import SnapKit
import ThemeKit

public class NoPasscodeViewController: ThemeViewController {
    public enum Mode {
        case noPasscode
        case jailbreak
    }

    private let mode: Mode

    private let wrapperView = UIView()
    private let iconImageView = UIImageView()
    private let infoLabel = UILabel()

    public init(mode: Mode) {
        self.mode = mode

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(wrapperView)
        wrapperView.addSubview(iconImageView)
        wrapperView.addSubview(infoLabel)

        wrapperView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(72)
        }

        iconImageView.contentMode = .center
        iconImageView.image = StorageKit.image(named: "attention_48")?.tinted(with: .themeGray)

        infoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(42)
            make.top.equalTo(self.iconImageView.snp.bottom).offset(CGFloat.margin8x)
            make.bottom.equalToSuperview()
        }

        infoLabel.textColor = .themeGray
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.font = .body
        switch mode {
        case .jailbreak:
            infoLabel.text = "jailbreak.info_text".localized
        case .noPasscode:
            infoLabel.text = "no_passcode.info_text".localized
        }
    }

}
