//
//  SimilarMoviesTableViewCellXib.swift
//  MoviesBRQ
//
//  Created by Marcos Amorim Rossi de Carvalho on 29/06/21.
//

import Foundation
import UIKit

class SimilarMoviesTableViewCellXib: UITableViewCell {
    
    //MARK: outlets
    @IBOutlet weak var MoviePoster: UIImageView!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieTags: UILabel!
    
    
    //MARK: funcs
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

