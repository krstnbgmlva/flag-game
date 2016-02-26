//
//  ViewController.swift
//  Flag game
//
//  Created by Kristina Bogomolova on 1/18/16.
//  Copyright © 2016 FoxyLabs. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var country: UILabel!
    
    @IBOutlet weak var flag1: UIButton!
    @IBOutlet weak var flag2: UIButton!
    @IBOutlet weak var flag3: UIButton!
    @IBOutlet weak var flag4: UIButton!
    
 
    var countriesDict = [String: String]()
    var countriesShuffled = [String] ()
    var correctAnswerIndex = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Read the file
        let bundle = NSBundle.mainBundle()
        let flagsFilePath = bundle.pathForResource("flags", ofType: "json")!
        let data = NSData(contentsOfFile: flagsFilePath)!
        
        // JSON
        do {
            if let json  =  try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: String] {
                
                self.countriesDict = json
            }
        
        } catch let error as NSError {
            
            print("Failed to read json: \(error)")
        }
        
        self.askCountry(nil)
        
    }

    
    func askCountry(action: UIAlertAction!){
        
        self.countriesShuffled = Array(self.countriesDict.keys)
        
        // Randomize the elements in the array
        self.countriesShuffled = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countriesShuffled) as! [String]
        
        // Set the buttons' names
        self.flag1.setTitle(countriesDict[countriesShuffled[0]], forState: .Normal)
        self.flag2.setTitle(countriesDict[countriesShuffled[1]], forState: .Normal)
        self.flag3.setTitle(countriesDict[countriesShuffled[2]], forState: .Normal)
        self.flag4.setTitle(countriesDict[countriesShuffled[3]], forState: .Normal)
    
        // Generate random index for a correct answer
        self.correctAnswerIndex = GKRandomSource.sharedRandom().nextIntWithUpperBound(4)
        
        // Set the label text
        self.country.text = countriesShuffled[correctAnswerIndex];
        
        
    }
    
    
    @IBAction func buttonTapped(sender: UIButton!) {
        
        var title : String
        
        if sender.tag == self.correctAnswerIndex {
            
            title = "Correct!"
            
        } else {
            
            title = "Wrong!"
        }
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askCountry))
        
        self.presentViewController(ac, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

