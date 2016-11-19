class Script: NSObject, XMLParserDelegate {
    
    var endpoint: URL
    var version: String
    var credentialsProvider: AWSStaticCredentialsProvider
    
    var currentElementName = ""
    var responseData       = ""
    
    init(endpoint: String, version: String, accessKey: String, secretKey: String){
        self.endpoint = URL(string: String(format: "%@/%@",endpoint,version))!
        self.version = version
        self.credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey,secretKey: secretKey)
    }
    
    func executeScript(scriptIdentifier: String, method: String, query: String = "null", body: String  = "null", header: String = "null", callback: @escaping (String, String?) -> Void) {
        let action   = "ExecuteScript"
        let httpBody = String(format: "ScriptIdentifier=%@&Method=%@&Query=%@&Header=%@&Body=%@",scriptIdentifier,method,query,header,body)
        let req = makeReqest(body: httpBody, action: action)
        let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {data, response, error in
            if error == nil {
                let parser = XMLParser(data: data! as Data)
                parser.delegate = self
                parser.parse()
                callback(self.responseData as String, nil)
            } else {
                callback("", error!.localizedDescription)
            }
        })
        task.resume()
    }
    
    func makeReqest(body: String, action: String) -> NSMutableURLRequest {
        let req: NSMutableURLRequest = NSMutableURLRequest(url: self.endpoint)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = AWSDateISO8601DateFormat2
        
        req.httpMethod = "POST"
        req.httpBody = body.data(using: String.Encoding.utf8)
        req.setValue(formatter.string(from: date), forHTTPHeaderField:"X-Amz-Date")
        req.addValue(String(format: "%@.%@",self.version,action), forHTTPHeaderField: "X-Amz-Target")
        req.addValue("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", forHTTPHeaderField: "Accept")
        req.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let signer: AWSSignatureV4Signer = AWSSignatureV4Signer(
            credentialsProvider: self.credentialsProvider,
            endpoint: AWSEndpoint.init(region: AWSRegionType.usEast1, service: AWSServiceType.lambda, url: self.endpoint))
        signer.interceptRequest(req)
        return req
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElementName = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElementName == "ResponseData" {
            responseData = string
        }
    }
}
