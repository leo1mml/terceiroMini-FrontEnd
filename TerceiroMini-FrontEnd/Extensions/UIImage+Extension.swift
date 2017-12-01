//
//  UIImage+Extension.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 01/12/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit
import Alamofire

extension UIImage {
    static func fetch(with url: String, completion: @escaping (_ image : UIImage) -> ()){
        Alamofire.request(url).responseData { (data) in
            guard let data = data.data else { return }
            completion(UIImage(data: data)!)
            
        }
    }
}
