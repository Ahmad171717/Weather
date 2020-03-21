//
//  ListCell.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
//    var showAccessoryImage = false {
//        didSet {
//            configureCheckMarkView()
//        }
//    }
    
    var listableItem: Listable? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var labelTitle: UILabel?
    @IBOutlet weak var imageViewCheckMark: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        imageViewCheckMark?.isHidden = !selected
    }
    
    private func configureView() {
        guard let listableItem = listableItem else { return }
        labelTitle?.text = listableItem.listName
//        configureCheckMarkView()
    }
    
//    private func configureCheckMarkView() {
//        imageViewCheckMark?.isHidden = !showAccessoryImage
//    }
}
