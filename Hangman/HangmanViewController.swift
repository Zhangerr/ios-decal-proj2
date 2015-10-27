//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!;
    var bottom:CGFloat?;
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil);
        bottom = bottomLayout?.constant
    }
    func keyboardWillShow(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.bottomLayout?.constant = bottom! + keyboardSize.height
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.bottomLayout?.constant = bottom!
        }
    }
    func startNewGame() {
        hangman.start()
        guessesLabel.text = ""
        knownLetters.text = hangman.knownString
        wrongCounter = 0
        hangmanImage.image = UIImage(named:"hangman\(wrongCounter+1).gif")
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
                hangmanImage.image = UIImage(named:"hangman\(wrongCounter+1).gif")
                if wrongCounter == 6 {
                    let alert = UIAlertController(title: "You lose!", message:"The phrase was \"\(hangman.answer!)\".", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    knownLetters.text = hangman.answer
                    gameOver()
                    return
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
            guessTextField.text = ""
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

