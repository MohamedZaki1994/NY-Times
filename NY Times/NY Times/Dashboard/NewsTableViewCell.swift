//
//  NewsTableViewCell.swift
//  NY Times
//
//  Created by Mohamed Zaki on 11/08/2022.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var section: UILabel!

    func configure(imageName: String, title: String?, publishedDate: String?, section: String?) {
        self.title.text = title
        self.publishedDate.text = publishedDate
        self.section.text = section
        let url = URL(string: imageName)
        newsImageView.kf.setImage(with: url)
    }
}
