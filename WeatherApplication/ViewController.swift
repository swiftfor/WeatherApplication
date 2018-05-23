//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Hamada on 5/23/18.
//  Copyright © 2018 Hamada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var laDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }


    

   
    @IBAction func getWeatherAction(_ sender: Any) {
        if let  url = URL(string: "https://www.weather-forecast.com/locations/"+cityTextField.text!.replacingOccurrences(of: "", with: "-")+"/forecasts/latest"){
            let request = NSMutableURLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                var message = ""
                if error != nil{
                    print(error)
                }else{
                    if let unwrappeddata = data{
                        let dataString = NSString(data: unwrappeddata, encoding: String.Encoding.utf8.rawValue)
                        var stringseparator = "<span class=\"phrase\">"
                        if let contentArray = dataString?.components(separatedBy: stringseparator){
                            if contentArray.count > 1{
                                stringseparator = "</span>"
                                let newcontentArray = contentArray[1].components(separatedBy: stringseparator)
                                if newcontentArray.count > 1{
                                    message = newcontentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    print(message)
                                }
                                
                            }
                        }
                    }
                    
               
                }
                if message == "" {
                    message = "the weather there cannot be found , please try again later..."
                }
                DispatchQueue.main.sync(execute: {
                    self.laDisplay.text = message
                })
            }
            task.resume()
        }else{
            laDisplay.text = "the weather there cannot be found , please try again later..."
        }
}
    

}


