//
//  PhotoCell.swift
//  Nasa
//
//  Created by kairzhan on 7/26/21.
//

import UIKit

class PhotoCell: UITableViewCell {
    
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
        }
    }
    
    private func configureView() {
        
    }
    
    func setImage(image: UIImage) {
        photoView.image = image
    }
}
