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
        tableView.register(ImageDoubleLineCheckmarkCell.self, forCellReuseIdentifier: String(describing: ImageDoubleLineCheckmarkCell.self))

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
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImageDoubleLineCheckmarkCell.self)) {
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ImageDoubleLineCheckmarkCell else {
            return
        }

        cell.bind(
                image: UIImage(named: "Cell Icon")?.tinted(with: .themeJacob),
                title: "Image Double Line Checkmark",
                subtitle: "Image Double Line Checkmark",
                checkmarkVisible: true,
                last: true
        )
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .heightDoubleLineCell
    }

}
