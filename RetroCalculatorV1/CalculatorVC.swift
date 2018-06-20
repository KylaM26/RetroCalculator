//
//  ViewController.swift
//  RetroCalculatorV1
//
//  Created by Kyla Wilson on 6/20/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit
import AVFoundation

class CalculatorVC: UIViewController {

    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PrepareSoundEfx();
    }
    
    func PrepareSoundEfx() {
        let path = Bundle.main.path(forResource: "btn", ofType: "wav");
        let soundURL = URL(fileURLWithPath: path!);
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL);
            btnSound.prepareToPlay();
        } catch let error as NSError {
            print(error.description);
        }
    }
    
    func PlayBtnSoundEfx() {
        if btnSound.isPlaying {
            btnSound.stop();
        }
        
        btnSound.play(); // Audio player
    }
    
    @IBAction func NumberPressed(sender: UIButton) {
        PlayBtnSoundEfx();
    }
}
