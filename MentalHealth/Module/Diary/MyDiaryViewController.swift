//
//  MyDiaryViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/15/24.
//

import UIKit

class MyDiaryViewController: UIViewController {
    
    @IBOutlet weak var startButton: AllSubmitButton!
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    var datasource: [MyDiaryItem] = [MyDiaryItem(date: "6/17/2024",
                                                 myDiaryMood: .bad,
                                                 answerOne: "Answer One",
                                                 answerTwo: "Answer Two",
                                                 answerThree: "Ansower Three"),
                                     MyDiaryItem(date: "6/18/2024",
                                                myDiaryMood: .good,
                                                answerOne: "Answer One",
                                                 answerTwo: "Answer Two",
                                                answerThree: "Ansower Three")]
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: DiarcyCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DiarcyCell.reuseIdentifier)
        setCustomBackNavigationButton()
        startButton.isEnabled = true
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
extension MyDiaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myDiaryItem = datasource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiarcyCell.reuseIdentifier) as? DiarcyCell else {
            return UITableViewCell()
        }
        cell.populate(myDiary: myDiaryItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

