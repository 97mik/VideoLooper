//
//  BetterLooperController.swift
//  VideoLooper
//
//  Created by Mikhail Verenich on 17.06.2021.
//

import UIKit
import AVFoundation

class BetterLooperController: UIViewController {
    
    private let videoURL = Bundle.main.url(forResource: "video", withExtension: "mp4")!
    
    private var playerLooper: AVPlayerLooper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
    }
    
    private func setupVideo() {
        let asset = AVAsset(url: videoURL)
        
        guard let videoTrack = asset.tracks(withMediaType: .video).first else {
            fatalError("Video has no video track")
        }
        /*
            Use AVMutableComposition to smoothly concantenate videos
            
            This version have lag at each 6 second
        */
        let composition = AVMutableComposition()
        for index in 0..<2 {
            do {
                try composition.insertTimeRange(videoTrack.timeRange, of: asset, at: CMTimeMultiply(asset.duration, multiplier: Int32(index)))
            } catch {
                fatalError("Can't insert video track")
            }
        }
        
        let item = AVPlayerItem(asset: composition)
        let player = AVQueuePlayer(playerItem: item)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.layer.bounds
        view.layer.addSublayer(playerLayer)
        
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.play()
    }
    
}
