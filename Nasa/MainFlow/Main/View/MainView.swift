//
//  MainView.swift
//  Nasa
//
//  Created by kairzhan on 7/26/21.
//

import UIKit
import SnapKit
import Alamofire
import RealmSwift

class MainView: UIView {
    
    var imageTapped: ((String) -> Void)?
    
    let tableView = UITableView()
    var images: Results<Photo>?
    
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
        tableView.rowHeight = 300
        tableView.showsVerticalScrollIndicator = false
    }
    
}

extension MainView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath) as! PhotoCell
        let image = (images?[indexPath.row].img_src)!
        cell.setImage(image: image)
        cell.selectionStyle = .none
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        cell.addGestureRecognizer(longPress)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let image = (images?[indexPath.row].img_src)!
        imageTapped?(image)
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let image = images![indexPath.row]
                StorageManager.deletePhoto(image)
                tableView.reloadData()
            }
        }
    }
}
