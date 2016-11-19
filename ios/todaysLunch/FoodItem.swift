
class FoodItem: NSObject {
    
    var name:   String
    var rarity: String
    var imgURL: String
    
    init(name: String, rarity: String, imgURL: String) {
        self.name = name
        self.rarity = rarity
        self.imgURL = imgURL
    }
    
    
    static func fetchRundomItem(callback: @escaping (FoodItem) -> Void) {
        let script = Script(endpoint:  Const.SCRIPT_ENDPOINT,
                            version:   Const.SCRIPT_APIVERSION,
                            accessKey: Const.NIFTY_CLOUD_ACCESS_KEY,
                            secretKey: Const.NIFTY_CLOUD_SECRET_KEY)
        
        script.executeScript(scriptIdentifier: Const.SCRIPT_NAME, method: "GET") { (response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            let json = try! JSONSerialization.jsonObject(with: response.data(using: String.Encoding.utf8)!) as! [String: AnyObject]
            
            callback(FoodItem(name: (json["name"] as? String)!, rarity: (json["star"] as? String)!, imgURL: (json["imageURL"] as! String)))
        }
    }
}
