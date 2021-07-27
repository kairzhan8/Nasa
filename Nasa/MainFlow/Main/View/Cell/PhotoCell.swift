//
//  PhotoCell.swift
//  Nasa
//
//  Created by kairzhan on 7/26/21.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    let label = UILabel()
    
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(photoView)
        photoView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.size.equalTo(200)
        }
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
        }
    }
    
    private func configureView() {
        backgroundColor = .blue
        label.text = "Kalskjf;jasl;k"
    }
    
    func setImage(image: String) {
        photoView.image = UIImage(named: image)
        photoView.kf.setImage(with: URL(string: image), completionHandler:  { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
}
