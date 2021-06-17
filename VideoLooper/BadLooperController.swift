//
//  BadLooperController.swift
//  VideoLooper
//
//  Created by Mikhail Verenich on 17.06.2021.
//

import UIKit
import AVFoundation

class BadLooperController: UIViewController {
    
    private let videoURL = Bundle.main.url(forResource: "video", withExtension: "mp4")!
    
    private var playerLooper: AVPlayerLooper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
    }
    
    private func setupVideo() {
        /*
            This version have lag at each 3 second
        */
        let item = AVPlayerItem(url: videoURL)
        let player = AVQueuePlayer(playerItem: item)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.layer.bounds
        view.layer.addSublayer(playerLayer)
        
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.play()
    }
    
}
