//
//  ViewController.swift
//  videoAssingment
//
//  Created by Abhinav on 13/11/24.
//

protocol HandleDetailsProtocol:AnyObject {
    func titleTap(in cell:VideoTableViewCell)
}

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var videoTblView:UITableView!
    var data:VideoData?
    var currentIndex = 0
    let viewModel = VideoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        getData()
        setupTableView()
        videoTblView.rowHeight = videoTblView.bounds.height
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVisibleVideo()
        
    }
    
    func setupTableView() {
        let cell = UINib(nibName: "VideoTableViewCell", bundle: nil)
        videoTblView.register(cell, forCellReuseIdentifier: "VideoTableViewCell")
        videoTblView.delegate = self
        videoTblView.dataSource = self
        videoTblView.backgroundColor = .purple
        videoTblView.contentInsetAdjustmentBehavior = .never
        videoTblView.decelerationRate = .fast
    }
    
    func getData() {
        viewModel.parseData { [weak self] videoData in
            guard let video = videoData else {return}
            self?.data = video
            DispatchQueue.main.async {
                self?.videoTblView.reloadData()
            }
        }
    }
}

extension ViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        cell.video = data?[indexPath.row]
        cell.backgroundColor = .brown
        cell.configure()
        cell.setUPData()
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.maxY
    }
    func playVisibleVideo() {
        
        pauseAllVideos()
        
        if let indexPath = videoTblView.indexPathsForVisibleRows?.first {
            let cell = videoTblView.cellForRow(at: indexPath) as? VideoTableViewCell
            cell?.player?.play()
            currentIndex = indexPath.row
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        pauseAllVideos()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        playVisibleVideo()
    }
   
    
 /*   
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      playVisibleVideo()
    print("msnlakn")
      
  }
  func playVisibleVideo() {
        let visibleCells = videoTblView.visibleCells.compactMap { $0 as? VideoTableViewCell }
        visibleCells.forEach { $0.player?.pause() }
        
        if let firstVisibleCell = visibleCells.first {
            firstVisibleCell.player?.play()
        }
    } */
    
    func pauseAllVideos() {
           let visibleCells = videoTblView.visibleCells.compactMap { $0 as? VideoTableViewCell }
           visibleCells.forEach { $0.player?.pause() }
       }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellHeight = videoTblView.rowHeight
        
        if velocity.y > 0 {
            
            currentIndex += 1
        } else if velocity.y < 0 {
            
            currentIndex -= 1
        }
        
        
        currentIndex = max(0, min(currentIndex, videoTblView.numberOfRows(inSection: 0) - 1))
        
        
        let newOffsetY = CGFloat(currentIndex) * cellHeight
        targetContentOffset.pointee = CGPoint(x: 0, y: newOffsetY)
        videoTblView.rowHeight = videoTblView.bounds.height
        
    }
}


extension ViewController:HandleDetailsProtocol{
    func titleTap(in cell: VideoTableViewCell) {
        if let indexPath = videoTblView.indexPath(for: cell) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
            if let sheet = vc.sheetPresentationController{
                sheet.detents = [.medium(),.large()]
            }
            if let videoData = data?[indexPath.row]{
                vc.video = videoData
            }
            present(vc, animated: true)
            
        }
    }
}
