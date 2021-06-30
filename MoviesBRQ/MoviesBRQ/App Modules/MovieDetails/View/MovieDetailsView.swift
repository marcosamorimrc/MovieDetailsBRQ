//
//  MovieDetailsView.swift
//  MoviesBRQ
//
//  Created by Marcos Amorim Rossi de Carvalho on 29/06/21.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailsView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK:outlets
    @IBOutlet weak var MoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var MoviewDetailsTableView: UITableView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    //MARK:globals
    let cellHeight = 100
    var MoviesArray: NSMutableArray!
    
    
    //MARK:funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        MoviewDetailsTableView.register(UINib(nibName: "SimilarMoviesTableViewCellXib", bundle: nil), forCellReuseIdentifier: "SimilarMovieCell")
        
        MoviewDetailsTableView.delegate = self
        MoviewDetailsTableView.dataSource = self
        
        self.test()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func test() {
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/6SP1bFfoXhW7Ni7fPw5GjY7ACBS.jpg")!
        MoviePoster.af.setImage(withURL: url)
        lblMovieTitle.text = "Movie 01"
        lblLikes.text = "10000 likes"
        lblPopularity.text = "10000 views"
    }
    
    @IBAction func btnToggleLiked(_ sender: Any) {
        
        let button = sender as! UIButton
        
        if let myButtonImage = button.image(for: .normal),
            let buttonImageCompare = UIImage(named: "outline_favorite_border_white_24pt_1x.png"),
            myButtonImage.pngData() == buttonImageCompare.pngData()
        {
            btnLike.setImage(UIImage(named: "outline_favorite_white_24pt_1x"), for: .normal)
        } else {
            btnLike.setImage(UIImage(named: "outline_favorite_border_white_24pt_1x.png"), for: .normal)
        }
        
    }
    
    
    //MARK:tableView delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: CGFloat(cellHeight*5))
        
        contentScrollView.contentSize = CGSize(width: 0, height: Int(tableView.frame.origin.y) + Int(tableView.frame.size.height))
        
        print("contentScrollView \(contentScrollView.contentSize)")
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell: SimilarMoviesTableViewCellXib = SimilarMoviesTableViewCellXib.init()
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarMovieCell", for: indexPath) as! SimilarMoviesTableViewCellXib

        cell.backgroundColor = .black
        
        cell.MovieTitle.text = "Title \(indexPath.row)"
        cell.MovieTags.text = "Title \(indexPath.row)"
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/pr3bEQ517uMb5loLvjFQi8uLAsp.jpg")!
        cell.MoviePoster.af.setImage(withURL: url)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

