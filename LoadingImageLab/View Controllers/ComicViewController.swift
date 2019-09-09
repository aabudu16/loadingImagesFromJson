
import UIKit


class ComicViewController: UIViewController {
    @IBOutlet var comicImage: UIImageView!
    
    @IBOutlet var comicTextField: UITextField!
    @IBOutlet var comicStepper: UIStepper!
    
    var randomNumber = RandomNumberGen.randomNumber(){
        didSet {
            DispatchQueue.main.async {
                self.setImage()
            }
        }
    }
    
    var mostRecent:Comics!
    var comic:Comics!{
        didSet {
            DispatchQueue.main.async {
                
                self.setImage()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureNavigationBar()
        fetchComicData(number: nil)
        comicTextField.keyboardType = .numberPad
    }
    
    private func configureTextField(){
        comicTextField.delegate = self
        comicTextField.borderStyle = .bezel
        comicTextField.adjustsFontSizeToFitWidth = true
    }
    
    private func configureNavigationBar(){
        navigationController?.navigationBar.backgroundColor = .gray
        navigationItem.title = "Comics"
    }
    
    private func setImage(){
        ImageHelper.shared.fetchImage(urlImage: comic.img) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    self.comicImage.image = image
                }
                
            }
        }
    }
    
    private func fetchComicData(number:Int?){
        ComicAPIClient.shared.fetchData(num: number) { (result) in
            switch result{
            case .failure(let error):
                print("Cant retrieve image \(error)")
            case .success(let comic):
                DispatchQueue.main.async {
                    self.comic = comic
                    self.mostRecent = comic
                }
            }
        }
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag{
        case 0:
            comic = mostRecent
        case 1:
            randomNumber = RandomNumberGen.randomNumber()
            fetchComicData(number: randomNumber)
            comicStepper.value = Double(randomNumber)
            comicTextField.text = String(randomNumber)
            navigationItem.title = "\(randomNumber)"
            
        default:
            randomNumber = -1
        }
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        randomNumber = Int(sender.value)
        fetchComicData(number: randomNumber)
        comicTextField.text = String(Int(sender.value))
        if randomNumber == 0{
            navigationItem.title = "No comic available"
        }else{
            navigationItem.title = "\(randomNumber)"
        }
    }
}

extension ComicViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = comicTextField.text, let value = Int(text) else {
            return false
        }
        fetchComicData(number: value)
        return true
    }
}

