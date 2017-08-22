//
//  ViewController.swift
//  AimForThat
//
//  Created by Randall Dani Barrientos Alva on 22/8/17.
//  Copyright © 2017 Randall Dani Barrientos Alva. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    var currentValue: Int = 0
    var targetValue: Int = 0
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        //Solo puede ser llamado desde un UISlider
        self.currentValue = Int(sender.value)
        print("el valor del slider es \(Int(sender.value))")
        
    }
    
    @IBAction func showAlert() {
        let message = """
        El valor del slider es: \(self.currentValue)
        El valor del objetivo es \(self.targetValue)
        """
        let alert = UIAlertController(title: "Puntuación", message: message, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "Genial", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        self.startNewRound()
        self.updateLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startNewRound()
        self.updateLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func startNewRound(){
        self.targetValue = 1 + Int(arc4random_uniform(UInt32(self.slider.maximumValue)))
        self.currentValue = Int(self.slider.maximumValue)/2
        self.slider.value = Float(self.currentValue)
        //setValue(Float(self.currentValue), animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateLabels(){
        self.targetLabel.text = "\(self.targetValue)"
    }
}

