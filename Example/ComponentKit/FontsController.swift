import UIKit
import ThemeKit
import SnapKit

class FontsController: ThemeViewController {

    private let fonts: [Font] = [
        Font(name: "Title1", value: .title1),
        Font(name: "Title2", value: .title2),
        Font(name: "Title2R", value: .title2R),
        Font(name: "Title3", value: .title3),
        Font(name: "Headline1", value: .headline1),
        Font(name: "Headline2", value: .headline2),
        Font(name: "Body", value: .body),
        Font(name: "Subhead1", value: .subhead1),
        Font(name: "Subhead1I", value: .subhead1I),
        Font(name: "Subhead2", value: .subhead2),
        Font(name: "Caption", value: .caption),
        Font(name: "CaptionSB", value: .captionSB),
        Font(name: "Micro", value: .micro),
        Font(name: "MicroSB", value: .microSB),
    ]

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FontCell.self, forCellReuseIdentifier: String(describing: FontCell.self))

        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.separatorColor = .themeSteel20
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }

}

extension FontsController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fonts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FontCell.self)) {
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FontCell else {
            return
        }

        cell.bind(font: fonts[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

}

extension FontsController {

    struct Font {
        let name: String
        let value: UIFont
    }

}
