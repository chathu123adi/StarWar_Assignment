//
//  DetailScreen.swift
//  StarWar
//
//  Created by Chathuranga Adikari on 2023-09-16.
//

import Foundation
import UIKit

class DetailScreen: UIViewController {
    
    @IBOutlet weak var gravityLbl: UILabel!
    @IBOutlet weak var orbitPeriodLbl: UILabel!
    @IBOutlet weak var planetNamelbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var starDetails: Result?
    let url = URL(string: "https://picsum.photos/221/128" )
    
    override func viewDidLoad() {
        print(starDetails)
        loadUIdata()
    }
    
    func loadUIdata() {
        planetNamelbl.text = ": " + (starDetails?.name ?? "")
        orbitPeriodLbl.text = ": " + (starDetails?.orbitalPeriod ?? "")
        gravityLbl.text = ": " + (starDetails?.gravity ?? "")
        
        DispatchQueue.global().async { [weak self] in
        if let data = try? Data(contentsOf: (self?.url)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView?.image = image
                    }
                }
            }
        }
        
    }
    
    
}
