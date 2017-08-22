//
//  ViewController.swift
//  AimForThat
//
//  Created by Randall Dani Barrientos Alva on 22/8/17.
//  Copyright © 2017 Randall Dani Barrientos Alva. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBAction func resetGame(_ sender: UIButton) {
        self.reset()
        self.startNewRound()
        self.updateLabels()

    }
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    var currentValue: Int = 0
    var targetValue: Int = 0
    var round: Int = 0
    var score: Int = 0
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        //Solo puede ser llamado desde un UISlider
        self.currentValue = Int(sender.value)        
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(self.targetValue - self.currentValue)
        /*
        lineal
        let points = 100 - difference
        */
        
        let point = (difference > 0) ? 100 - difference : 1000
        let message = """
        Has marcado \(point) puntos!
        """
        
        let title: String
        
        switch difference {
        case 0:
            title = "Puntuación Perfecta!"
        case 1...5:
            title = "Puntuación casi perfecta!"
        case 6...12:
            title = "No está mal!"
        default:
            title = "Afina tu punteria"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Genial", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        self.score += point
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
        self.round += 1
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
        self.scoreLabel.text = "\(self.score)"
        self.roundLabel.text = "\(self.round)"
    }
    
    func reset(){
        let alert =  UIAlertController(title: "Juego Reseteado", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default , handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        self.currentValue = 0
        self.score = 0
        self.round = 0
    }
}

