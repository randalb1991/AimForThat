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
        //self.startNewRound() ahora esta en completion handler del metodo reset
        //self.updateLabels()

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
        
        let action = UIAlertAction(title: "Ok!", style: .default,
            /*fragemento de código que se ejcutará cuando pulse ok*/
            handler: {
                //Porque lo llama la propia acción.
                action in
                // Ambos metodos son de la clase UIViewController, mientras que aqui estamos ejecutando algo que esta en el contexto de action, por lo que debemos usar self.
                self.score += point
                self.startNewRound()
                self.updateLabels()
            })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startNewRound()
        self.updateLabels()
        self.setupSlider()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setupSlider(){
        let thumImageNormal = UIImage(named:"SliderThumb-Normal")
        let thumImageHighlighted = UIImage(named:"SliderThumb-Highlighted")
        let trackLeftImage = UIImage(named:"SliderTrackLeft")
        /*La forma de debajo es igual, solo que nombrando directamente
         la imagen swift ya te crea el el objeto
         */
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
    
        //Configuramos los 2 estados del slider(normal y highlighted)
        self.slider.setThumbImage(thumImageNormal, for: .normal)
        self.slider.setThumbImage(thumImageHighlighted, for: .highlighted)

        //Configuramos los colores de la barra
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0 , right: 14)
        //Creamos el track redimensionable con los bordes que se ha indicad en la variable anterior
        
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        
        self.slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        self.slider.setMaximumTrackImage(trackRightResizable, for: .normal)
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
        let action = UIAlertAction(title: "OK", style: .default ,
           handler: {
                action in
                self.round = 0
                self.startNewRound()
                self.currentValue = 0
                self.score = 0
                self.updateLabels()
            })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        /* metido ahora como clausura
        self.currentValue = 0
        self.score = 0
        self.round = 0*/
    }
}

