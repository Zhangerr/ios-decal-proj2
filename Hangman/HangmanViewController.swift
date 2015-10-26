//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()
    }
    func startNewGame() {
        hangman.start()
        guessesLabel.text = ""
        knownLetters.text = hangman.knownString
        print(hangman.answer)
        wrongCounter = 0
    }
    @IBAction func createNewGame(sender: AnyObject) {
        startNewGame()
        guessButton.enabled = true
    }
    var hangman:Hangman = Hangman()
    var wrongCounter = 0
    @IBOutlet weak var knownLetters: UILabel!
    @IBOutlet weak var newGame: UIBarButtonItem!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessesLabel: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBAction func guessWord(sender: AnyObject) {
        if !guessTextField.text!.isEmpty {
            let guess = guessTextField.text!
            if !hangman.guessLetter(String(guess[guess.startIndex]).uppercaseString) {
                wrongCounter++
                if wrongCounter == 7 {
                    let alert = UIAlertController(title: "You lose!", message:"", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    gameOver()
                }
            }
            knownLetters.text = hangman.knownString
            guessesLabel.text = hangman.guesses()
            if hangman.knownString == hangman.answer {
                let alert = UIAlertController(title: "You win!", message:"", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                gameOver()
            }
        }
    }
    func gameOver() {
        guessButton.enabled = false
        
    }
    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

