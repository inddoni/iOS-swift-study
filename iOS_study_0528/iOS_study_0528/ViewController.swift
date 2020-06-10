//
//  ViewController.swift
//  iOS_study_0528
//
//  Created by 최인정 on 2020/05/28.
//  Copyright © 2020 indoni. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    let MAX_VOLUMN : Float = 15.0
    var progressTimer : Timer!
    
    
    @IBOutlet weak var pvPrograssView: UIProgressView!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var slVolumn: UISlider!
    
 
    @IBOutlet weak var swtRecord: UISwitch!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var recordTime: UILabel!
    
    let timePlayerSelector : Selector = #selector(ViewController.updatePlayTime)
    
    @objc func updatePlayTime(){
        lblCurrentTime.text = convertNSTtimeInterval2String(audioPlayer.currentTime)
        
        pvPrograssView.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    @IBAction func btnPlayAudio(_ sender: Any) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    @IBAction func btnPauseAudio(_ sender: Any) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: Any) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTtimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioFile = Bundle.main.url(forResource: "fragile", withExtension: "mp3")
        
        initPlay()
        // Do any additional setup after loading the view.
    }

    func initPlay(){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error - initplay : \(error)")
        }
        
        slVolumn.maximumValue = MAX_VOLUMN
        slVolumn.value = 1.0
        pvPrograssView.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolumn.value
        lblEndTime.text = convertNSTtimeInterval2String(audioPlayer.duration) //.duration = mp3파일의 총 시간
        lblCurrentTime.text = convertNSTtimeInterval2String(0)
        
        setPlayButtons(true, pause: false, stop: false)
    }
    
    func setPlayButtons(_ play:Bool, pause:Bool, stop: Bool){
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
        
    }
    
    func convertNSTtimeInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60)) //60으로 나누고 나머지(정수값) 저장
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    @IBAction func slChangeVolumn(_ sender: Any) {
        
        audioPlayer.volume = slVolumn.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
}

