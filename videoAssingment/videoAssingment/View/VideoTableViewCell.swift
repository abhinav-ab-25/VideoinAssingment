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
    var playerItem: AVPlayerItem?
    
    var video:VideoDatum?
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var controlView: UIView!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnRetry: UIButton!
    @IBOutlet weak var lblError: UILabel!
    var isPlaying = false
    weak var delegate:HandleDetailsProtocol?
    
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
//        playerLayer?.removeFromSuperlayer()
    }
    
    func configure() {
        let link = video?.videoURL ?? ""
        print("link",link)
        guard let url = URL(string: link) else {return}
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = contentView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
//        playerLayer?.player?.volume = .zero
        /*
        player?.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
        playerItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: [.new, .initial], context: nil)
        playerItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: [.new, .initial], context: nil)
        */
        if let playerLayer = playerLayer {
              videoView.layer.addSublayer(playerLayer)
        }
        videoView.bringSubviewToFront(controlView)
    }
    
    /*
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let playerItem = object as? AVPlayerItem else { return }
        if keyPath == "status" {
            if player?.status == .readyToPlay {
                print("Video is ready to play")
            } else if player?.status == .failed {
                print("Failed to load video")
            }
            else if player?.status == .unknown {
                print("Unknown error")
            }
        }
        
        if keyPath == "playbackLikelyToKeepUp" {
               DispatchQueue.main.async {
                   if playerItem.isPlaybackLikelyToKeepUp {
//                       self.errorLabel.isHidden = true
//                       self.player?.play() // Start playback if buffering is enough
                   } else {
                       print("error eror playbackLikelyToKeepUp")
                   }
               }
           }
        if keyPath == "playbackBufferEmpty" {
              DispatchQueue.main.async {
                  if playerItem.isPlaybackBufferEmpty {
                      print("keypath playbackBufferEmpty")
                  }
              }
          }

          
          if keyPath == "error" {
              DispatchQueue.main.async {
                  if let error = playerItem.error {
                      print("keypath error")
                  }
              }
          }
    }
    */
    
    func setUPData(){
        lblName.text = video?.author ?? "Author Name"
        lblTitle.text = video?.title ?? "Video Title"
        profilePicture.image = UIImage(systemName: "person.crop.circle.fill")
    }
    
    func setupUI(){
        controlView.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(actionControlVideo))
        controlView.addGestureRecognizer(tapgesture)
        btnPlay.backgroundColor = .black.withAlphaComponent(0.6)
        btnPlay.layer.cornerRadius = btnPlay.bounds.size.height/2
        btnPlay.isHidden = true
        btnRetry.setUnderlinedTitle("Retry")
        lblError.isHidden = true
        btnRetry.isHidden = true
        lblTitle.isUserInteractionEnabled = true
        let titleTap = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        lblTitle.addGestureRecognizer(titleTap)
        
    }
    
    func playVideo() {
        player?.play()
    }
    
    func pauseVideo() {
        player?.pause()
    }
    
    @IBAction func actionControlVideo(_ sender:UIButton) {
        if !isPlaying {
            pauseVideo()
            isPlaying = true
            hideShowPlayButton(play: isPlaying)
        }
        else {
            playVideo()
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
    
    @objc func actionTap(){
        delegate?.titleTap(in: self)
    }

}
