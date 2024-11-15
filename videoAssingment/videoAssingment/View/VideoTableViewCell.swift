//
//  VideoTableViewCell.swift
//  videoAssingment
//
//  Created by Netprophets on 13/11/24.
//

import UIKit
import AVKit

class VideoTableViewCell: UITableViewCell {

    var player:AVPlayer?
    var playerLayer: AVPlayerLayer?
    var video:VideoDatum?
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var controlView: UIView!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var isPlaying = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
        playerLayer?.removeFromSuperlayer()
    }
    
    func configure() {
        let link = video?.videoURL ?? ""
        print("link",link)
        guard let url = URL(string: link) else {return}
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = contentView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
//        playerLayer?.player?.volume = .zero
        player?.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)

        if let playerLayer = playerLayer {
                videoView.layer.addSublayer(playerLayer)
        }
        videoView.bringSubviewToFront(controlView)
        
        print("Hello")
         
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if player?.status == .readyToPlay {
                print("Video is ready to play")
            } else if player?.status == .failed {
                print("Failed to load video")
                
            }
        }
    }
    
    func setUPData(){
        lblName.text = video?.author ?? "Author Name"
        lblTitle.text = video?.title ?? "Video Title"
        profilePicture.image = UIImage(systemName: "person.crop.circle.fill")
    }
    
    func setupUI(){
        controlView.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(actionControlVideo))
        controlView.addGestureRecognizer(tapgesture)
//        btnPlay.isHidden = true
        btnPlay.backgroundColor = .black.withAlphaComponent(0.6)
        btnPlay.layer.cornerRadius = btnPlay.bounds.size.height/2
       
    }
    
    
    func playVideo() {
        player?.play()
    }
    
    func pauseVideo() {
        player?.pause()
    }
    
    @IBAction func actionControlVideo(_ sender:UIButton) {
        if !isPlaying {
            playVideo()
            isPlaying = true
            hideShowPlayButton(play: isPlaying)
        }
        else {
            pauseVideo()
            isPlaying = false
            hideShowPlayButton(play: isPlaying)
        }
    }
    
    func hideShowPlayButton(play:Bool) {
        if play{
            btnPlay.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            btnPlay.showAndHide()
        }
        else {
            btnPlay.setImage(UIImage(systemName: "play.circle"), for: .normal)
            btnPlay.showAndHide()
        }
    }
    
    

}
