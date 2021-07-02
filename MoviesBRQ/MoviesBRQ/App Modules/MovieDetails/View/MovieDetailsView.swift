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
    var GenresArray: NSArray!
    var MoviesArray = NSMutableArray.init()
    var presenter:MovieDetailsViewToPresenterProtocol?
    
    
    //MARK:funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MoviewDetailsTableView.register(UINib(nibName: "SimilarMoviesTableViewCellXib", bundle: nil), forCellReuseIdentifier: "SimilarMovieCell")

        MoviewDetailsTableView.delegate = self
        MoviewDetailsTableView.dataSource = self
        
        print("contentScrollView.frame")
        print(contentScrollView.frame)
        print("imageview.frame")
        print(MoviePoster.frame)

        
        presenter?.view = self;
        presenter?.fetchMovieInfo()
    }
    
    //Changes navigationController back to visible
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //Sets navigationController to Hidden and Status bar to white
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    //btnLike Action (toggles between heart icons filled ou border)
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
        
        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: CGFloat(cellHeight*MoviesArray.count))
        
        contentScrollView.contentSize = CGSize(width: 0, height: Int(tableView.frame.origin.y) + Int(tableView.frame.size.height))
        
        return MoviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarMovieCell", for: indexPath) as! SimilarMoviesTableViewCellXib

        cell.backgroundColor = .black
        
        let movie = MoviesArray.object(at: indexPath.row) as! MovieDetails
        
        cell.MovieTitle.text = movie.title
        
        //Get release year from release_date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:movie.release_date!)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let realeaseYear = components.year
        let realeaseYearString = "\(realeaseYear ?? 0)"
        
        //Get movie genres separeted by ", " in a string from GenresArray
        let tagsArray = NSMutableArray.init()
        for tag in movie.genres! {
            for genre in GenresArray {
                if let genreDict = genre as? NSDictionary{
                    if tag as! Int == genreDict["id"] as! Int {
                        if let genreString = genreDict["name"] as? String{
                            tagsArray.add(genreString)
                            break
                        }
                    }
                }
            }
        }
        let tagsArrayString: [String] = tagsArray as! [String]
        
        let boldText = realeaseYearString
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

        let normalText = "  " + tagsArrayString.joined(separator:", ")
        let normalString = NSMutableAttributedString(string:normalText)

        attributedString.append(normalString)
        
        cell.MovieTags.attributedText = attributedString
        
        if let poster_path = movie.poster_path{
            let url = URL(string: "\(API_MOVIE_IMAGES)\(poster_path)")!
            cell.MoviePoster.af.setImage(withURL: url)
        }

        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(white: 0.2, alpha: 1)
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}


//MARK: presenter callbacks
extension MovieDetailsView :MovieDetailsPresenterToViewProtocol{
    
    func setMovieGenres(MovieGenresArray: NSArray) {
        GenresArray = NSArray.init(array: MovieGenresArray)
        MoviewDetailsTableView.reloadData()
    }
    
    func showInfo(movieInfo: MovieDetails) {
        
        let url = URL(string: API_MOVIE_IMAGES + movieInfo.backdrop_path!)!
        MoviePoster.af.setImage(withURL: url)
        lblMovieTitle.text = movieInfo.title
        lblLikes.text = abreviatedNumber(number: movieInfo.vote_count ?? 0) + " Likes"
        lblPopularity.text = "\(movieInfo.popularity ?? 0) Views"

    }
    
    func showSimilar(movieArray: Array<MovieDetails>) {
        
        MoviesArray.addObjects(from: movieArray)
        presenter?.fetchMovieGenres()
        
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong, please try again later.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


//MARK: usefull funcs
extension MovieDetailsView{
    
    func abreviatedNumber(number: Int) -> String{
        
        var shorterNumber = Float(number);
        var divisionsCounter = 0
        
        let shorterNumberString:String
        
        
        while shorterNumber/1000 > 1 && divisionsCounter < 3 {
            divisionsCounter += 1
            shorterNumber = shorterNumber/1000
        }
        
        switch divisionsCounter {
        case 0:
            shorterNumberString = "\(number)"
        case 1:
            shorterNumberString = String(format: "%.1fK", shorterNumber)
        case 2:
            shorterNumberString = String(format: "%.1fM", shorterNumber)
        case 3:
            shorterNumberString = String(format: "%.1fB", shorterNumber)
        default:
            shorterNumberString = "\(round(shorterNumber))T"
        }
        
        return shorterNumberString
    }
    
}


