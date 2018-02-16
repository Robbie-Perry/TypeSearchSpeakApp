//
//  ViewController.swift
//  TypeSearchSpeak
//
//  Created by Robbie Perry on 2018-02-16.
//

import UIKit
import TraceLog
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var textToSpeechSwitch: UISwitch!
    
    let googleQuery = "https://www.google.ca/search?q="
    var myUtterance = AVSpeechUtterance(string: "")
    var synth: AVSpeechSynthesizer!
    
    @IBAction func search(_ sender: Any) {
        let text = searchBar.text
        if searchBar.text!.isEmpty {
            return;
        }
        if textToSpeechSwitch.isOn {
            textToSpeech(text: text!)
        } else {
            search()
        }
    }
    
    func search() {
        let text = searchBar.text
        let urlText = text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if let url = URL(string: googleQuery + urlText!) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        search()
    }
    
    func textToSpeech(text: String) {
        myUtterance = AVSpeechUtterance(string: text)
        myUtterance.rate = 0.5
        synth.speak(myUtterance)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        synth = AVSpeechSynthesizer()
        synth.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

