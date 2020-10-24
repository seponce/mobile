//
//  ViewController.swift
//  Silly Song
//
//  Created by Sergio Ponce Opazo on 24-10-20.
//

import UIKit

func shortNameFromName(name: String) -> String {
    var name = name.lowercased()
    var short = name.lowercased().unicodeScalars
    let vowels = CharacterSet(charactersIn: "aeiou")
    if name.rangeOfCharacter(from: vowels) != nil {
        while !vowels.contains(short.removeFirst()) {
            name.removeFirst()
        }
    }
    return name
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    return lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortNameFromName(name: fullName))
}

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")

    // MARK: Lifecylce Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        if nameField.text?.count != 0 {
            let lyrics = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
            lyricsView.text = lyrics
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
