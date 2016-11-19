class MainViewController: UIViewController {
    
    private var mainButton = UIButton(type: UIButtonType.custom)
    
    private var forkImageView = UIImageView(image:UIImage(named: "fork-1"))
    private var knifeImageView = UIImageView(image:UIImage(named: "knife-1"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Today's lunch?"
        self.setComponents()
    }
    
    func setComponents() {
        // main button
        let btnWidth  = 100 * self.view.bounds.width  / 320
        let btnHeight = 40  * self.view.bounds.height / 568
        let btnX      = self.view.bounds.width / 2 - btnWidth / 2
        let btnY      = self.view.bounds.height / 2 + 50
        mainButton.frame = CGRect(x: btnX, y: btnY, width: btnWidth, height: btnHeight)
        mainButton.layer.masksToBounds = true
        mainButton.backgroundColor     = UIColor.blue
        mainButton.layer.cornerRadius  = 20.0
        mainButton.setTitle("ガチャる", for: UIControlState.normal)
        mainButton.setTitleColor(UIColor.white,  for: UIControlState.normal)
        mainButton.setTitleColor(UIColor.gray,  for: UIControlState.disabled)
        mainButton.addTarget(self, action: #selector(self.exec(_:)), for: .touchUpInside)
        self.view.addSubview(mainButton)
        
        // animationImages
        let forkWidth  = 80  * self.view.bounds.width  / 320
        let forkHeight = 80  * self.view.bounds.height / 568
        let forkX      = self.view.bounds.width / 2 - forkWidth / 2 + 120
        let forkY      = self.view.bounds.height / 2 - 100
        forkImageView.frame = CGRect(x: forkX, y: forkY, width: forkWidth, height: forkHeight)
        var forks :Array<UIImage> = []
        forks.append(UIImage(named: "fork-1")!)
        forks.append(UIImage(named: "fork-2")!)
        forkImageView.animationImages = forks
        forkImageView.animationDuration = 0.5
        self.view.addSubview(forkImageView)
        
        let knifeWidth  = 80  * self.view.bounds.width  / 320
        let knifeHeight = 80  * self.view.bounds.height / 568
        let knifeX      = self.view.bounds.width / 2 - knifeWidth / 2 - 120
        let knifeY      = self.view.bounds.height / 2 - 100
        knifeImageView.frame = CGRect(x: knifeX, y: knifeY, width: knifeWidth, height: knifeHeight)
        var knives :Array<UIImage> = []
        knives.append(UIImage(named: "knife-1")!)
        knives.append(UIImage(named: "knife-2")!)
        knifeImageView.animationImages = knives
        knifeImageView.animationDuration = 0.5
        self.view.addSubview(knifeImageView)
    }
    
    func exec(_ sender: UIButton) {
        self.mainButton.isEnabled = false
        forkImageView.startAnimating()
        knifeImageView.startAnimating()
        FoodItem.fetchRundomItem { (item) in
            let resultViewController  = ResultViewController()
            resultViewController.item = item
            self.navigationController?.pushViewController(resultViewController, animated: true)
            self.forkImageView.stopAnimating()
            self.knifeImageView.stopAnimating()
            self.mainButton.isEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

