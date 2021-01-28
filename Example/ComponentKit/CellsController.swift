import UIKit
import ThemeKit
import SnapKit

class CellsController: ThemeViewController {
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onToggleLightMode))

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(forClass: A1Cell.self)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }

    @objc func onToggleLightMode() {
        ThemeManager.shared.lightMode = !ThemeManager.shared.lightMode
        UIApplication.shared.keyWindow?.set(newRootController: MainController(selectedIndex: 2))
    }

}

extension CellsController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: A1Cell.self)) {
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? A1Cell else {
            return
        }

        cell.set(backgroundStyle: .lawrence)
        cell.title = "A1"
        cell.titleImage = UIImage(named: "Cell Icon")?.tinted(with: .themeJacob)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .heightCell48
    }

}
