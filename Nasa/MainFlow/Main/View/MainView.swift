//
//  MainView.swift
//  Nasa
//
//  Created by kairzhan on 7/26/21.
//

import UIKit
import SnapKit
import Alamofire

class MainView: UIView {
    
    private let tableView = UITableView()
    var images = [Photo]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoCell.self, forCellReuseIdentifier: "image")
        tableView.rowHeight = 100
    }}

extension MainView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath) as! PhotoCell
        let image = images[indexPath.row].img_src
        cell.setImage(image: image)
        return cell
    }
}
