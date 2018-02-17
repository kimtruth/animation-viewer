//
//  EpiListViewController.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 17..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import AVKit
import UIKit

final class EpiListViewController: UIViewController {

  // MARK: Properties
  
  var info: AniInfo?
  private var episodes: [String] = []
  
  // MARK: UI
  
  private let tableView = UITableView().then {
    $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.view.addSubview(self.tableView)
    
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    if let key = self.info?.key {
      EpiService.info(key: key) { response in
        switch response.result {
        case .failure(let error):
          print("Episode load error..")
          print(error)
        case .success(let value):
          guard let JSON = value as? [String: Any] else { return }
          guard let data = Episode(JSON: JSON)?.data else { return }
          self.episodes = data
          self.tableView.reloadData()
        }
      }
    }
  }
  
  func playVideo(url: String, vtt: String) {
    guard let myURL = URL(string: url) else { return }
    guard let mySubtitleURL = URL(string: vtt) else { return }
    let videoAsset = AVAsset(url: myURL)
    let subtitleAsset = AVAsset(url: mySubtitleURL)
    let mixComposition = AVMutableComposition()
    let videoTrack = mixComposition.addMutableTrack(withMediaType: .video,
                                                    preferredTrackID: kCMPersistentTrackID_Invalid)
    let subtitleTrack = mixComposition.addMutableTrack(withMediaType: .text,
                                                       preferredTrackID: kCMPersistentTrackID_Invalid)
    let videoDuration = CMTimeRange(start: kCMTimeZero, end: videoAsset.duration)
    try! videoTrack?.insertTimeRange(videoDuration,
                                     of: videoAsset.tracks(withMediaType: .video)[0],
                                     at: kCMTimeZero)
    try! subtitleTrack?.insertTimeRange(videoDuration,
                                        of: subtitleAsset.tracks(withMediaType: .text)[0],
                                        at: kCMTimeZero)
    let player = AVPlayer(playerItem: AVPlayerItem(asset: mixComposition))
    let playerViewController = AVPlayerViewController()
    playerViewController.player = player
    self.present(playerViewController, animated: true) {
      playerViewController.player!.play()
    }
  }
  
}

// MARK: - UITableViewDelegate

extension EpiListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let urlString = self.episodes[indexPath.row]
    guard var urlEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    guard let key = info?.key else { return }
    let vtt = "http://very.secret.url/subs/\(key)/\(indexPath.row + 1).vtt"
    
    urlEncoded = "http://very.secret.url/\(key)/\(urlEncoded)"
    print(urlEncoded)
    print(vtt)
    
    playVideo(url: urlEncoded, vtt: vtt)
    
  }
}

// MARK: - UITableViewDataSource

extension EpiListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return episodes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    cell.textLabel?.text = "\(indexPath.item + 1) 화"
    
    return cell
  }
}
