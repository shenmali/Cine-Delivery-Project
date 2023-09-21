//
//  HomeVC.swift
//  Cinx-Delivery
//
//  Created by Ali on 18/08/2023.
//  This is Home Screen

import UIKit
import RxCocoa
import RxSwift

class HomeVC: UIViewController {
    // MARK: - @IBOutlet
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    private let bag = DisposeBag()
    var viewModel: HomeViewModel
    
    // MARK: - Init
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: HomeVC.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNibFileTableView()
        setNavigationController(true)
        subscribeToSegmentedControl()
        segmentedControl.setOldLayout(tintColor: UIColor(named: "#004F62") ?? .red )
        configureNibFileTableView()
        tableViewSubscription()
        viewModel.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        userNameLabel.text = userName
    }
    
    // MARK: - set Navigation Bar Hidden
    private func setNavigationController(_ isHidden: Bool ) {
        navigationController?.setNavigationBarHidden(isHidden, animated: true)
    }
    // MARK: - configure Nib File TableView
    private func configureNibFileTableView() {
        tableView.register(UINib(nibName: String(describing: OrderDetailsTableViewCell.self), bundle: nil),
                                  forCellReuseIdentifier: String(describing: OrderDetailsTableViewCell.self))
    }
    // MARK: - table View Subscription
    private func tableViewSubscription() {
        viewModel.deliveryBill.bind(to: tableView.rx.items(cellIdentifier: String(describing: OrderDetailsTableViewCell.self), cellType: OrderDetailsTableViewCell.self)) { (_ , element , cell ) in
            cell.selectionStyle = .none
            cell.setupCell(element)
        }.disposed(by: bag)
    }
    
    // MARK: - subscribe To Segmented Control
    private func subscribeToSegmentedControl() {
        segmentedControl.rx.selectedSegmentIndex.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self]selectedIndex in
            guard let self = self else {return}
            switch selectedIndex {
            case 0:
                self.viewModel.tag = 1
                self.viewModel.GetDeliveryBillsItems()
            case 1:
                self.viewModel.tag = 2
                self.viewModel.GetDeliveryBillsItems()
            default:
                break
            }
        }).disposed(by: bag)
    }
}
