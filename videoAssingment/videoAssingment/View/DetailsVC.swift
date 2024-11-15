//
//  DetailsVC.swift
//  videoAssingment
//
//  Created by Netprophets on 15/11/24.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var lblLikes:UILabel!
    @IBOutlet weak var lblViews:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblYear:UILabel!
    @IBOutlet weak var lblDiscription:UILabel!
    var video:VideoDatum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    func setupData(){
        let result = (video?.uploadTime ?? "").formattedDateComponents()
        lblLikes.text = "N/A"
        lblViews.text = video?.views ?? "N/A"
        lblDate.text = result?.dayMonth ?? "N/A"
        lblYear.text = result?.year ?? "N/A"
        lblDiscription.text = video?.description ?? "N/A"
        
        
    }

}
