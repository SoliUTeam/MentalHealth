//
//  MyDiaryViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/15/24.
//

import UIKit

class MyDiaryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: DiarcyCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DiarcyCell.reuseIdentifier)
        setCustomBackNavigationButton()
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
extension MyDiaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiarcyCell.reuseIdentifier) as? DiarcyCell else {
            return UITableViewCell()
        }
        cell.populate()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
}

