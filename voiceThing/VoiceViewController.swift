//
//  ViewController.swift
//  voiceThing
//
//  Created by Alma Maria Livingston on 5/19/15.
//  Copyright (c) 2015 Alma Livingston. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceViewController: UIViewController, AVSpeechSynthesizerDelegate, UIPickerViewDelegate {
    
    @IBOutlet weak var textField: UITextView!
    var paused = false
    var pitchSelected: Float = 1.0
    var rateSelected: Float = 0.3
    
    // Tap out of text
    @IBOutlet weak var onTapOut: UITapGestureRecognizer!
    @IBAction func onTapOutOfText(sender: AnyObject) {
        view.endEditing(true)
    }
    
    // Speech Synthesizer
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    //Play button functionality
    @IBAction func playBarButtonPressed(sender: UIBarButtonItem) {
        //set myUtterance to text inside text field
        myUtterance = AVSpeechUtterance(string: textField.text)
        
        //set language and locale voice
        myUtterance.voice = AVSpeechSynthesisVoice(language: accentChoice)
        
        //set speech rate
        myUtterance.rate = rateSelected
        
        //set speech pitch
        myUtterance.pitchMultiplier = pitchSelected
        
        //read text
        if paused == false {
            synth.speakUtterance(myUtterance)
        } else {
            synth.continueSpeaking()
            paused = false
        }

    }
    
    //Paused button functionality
    @IBAction func pauseBarButtonPressed(sender: UIBarButtonItem) {
        paused = true
        speechSynthesizer(synth, didPauseSpeechUtterance: myUtterance)
    }
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didPauseSpeechUtterance utterance: AVSpeechUtterance!) {
        synth.pauseSpeakingAtBoundary(.Word)
    }
    
    //Stop button functionality
    @IBAction func stopBarButtonPressed(sender: UIBarButtonItem) {
        speechSynthesizer(synth, didCancelSpeechUtterance: myUtterance)
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didCancelSpeechUtterance utterance: AVSpeechUtterance!) {
        synth.stopSpeakingAtBoundary(.Immediate)
    }
    //when entire utterance has been read, reset paused so that playback will begin at beginning of utterance
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        paused = false
    }


    ////// Picker
    var accentChoice = ""
    var languages = ["English - America", "English - Australia", "English - Britain", "English - South Africa", "French - Canada", "French - France", "German", "Japanese", "Korean", "Spanish - Mexico", "Spanish - Spain"]
    
    @IBOutlet weak var languagePicker: UIPickerView!
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return languages[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chooseAccent()
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        let titleData = languages[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 17.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.textAlignment = .Center
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }

    func chooseAccent() {
        let accent = languages[languagePicker.selectedRowInComponent(0)]
        languageSelect(accent)
    }
    func languageSelect(accent: String){
        if accent == "English - America" {
            accentChoice = "en-US"
        } else if accent == "English - Australia" {
            accentChoice = "en-AU"
        } else if accent == "English - Britain" {
            accentChoice = "en-GB"
        } else if accent == "English - South Africa" {
            accentChoice = "en-ZA"
        } else if accent == "French - Canada" {
            accentChoice = "fr-CA"
        } else if accent == "French - France" {
            accentChoice = "fr-FR"
        } else if accent == "German" {
            accentChoice = "de-DE"
        } else if accent == "Japanese" {
            accentChoice = "ja-JP"
        } else if accent == "Korean" {
            accentChoice = "ko-KR"
        } else if accent == "Spanish - Mexico" {
            accentChoice = "es-MX"
        } else if accent == "Spanish - Spain" {
            accentChoice = "es-ES"
        }
        
    }
    ////// End Picker
    
    ///// Pitch Slider
    @IBOutlet weak var pitchSlider: UISlider!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBAction func pitchSliderValueChanged(sender: UISlider) {
        var pitchValue = String(format: "%.1f", sender.value)
        pitchLabel.text = pitchValue
        pitchSelected = (pitchValue as NSString).floatValue
    }
    ///// End Pitch Slider
    
    
    ///// Rate Slider
    @IBOutlet weak var rateLabel: UILabel!
    @IBAction func rateSliderValueChanged(sender: UISlider) {
        var rateValue = String(format: "%.1f", sender.value)
        rateLabel.text = rateValue
        rateSelected = (rateValue as NSString).floatValue
    }
    
    ///// End Rate Slider
    
    // Lock portrait orientation
    override func shouldAutorotate() -> Bool {
        return false
    }
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

