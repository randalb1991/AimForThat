//
//  AboutUsViewController.swift
//  AimForThat
//
//  Created by Randall Dani Barrientos Alva on 28/8/17.
//  Copyright © 2017 Randall Dani Barrientos Alva. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
         Bundle es todo el paquete(singleton compartido por toda la aplicacion). y con el metodo main.url pido una url */
        
        
        if let url = Bundle.main.url(forResource: "AimForThat", withExtension: "html"){
            print(url)

            if let htmlData = try? Data(contentsOf: url) {
                /*URL Base de donde sale el archivo*/
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                self.webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
         
        }else{
            print("url no encontrada")
        }
        /*
        if let url = URL(string: "https://apple.com"){
            let request = URLRequest(url: url)
            self.webView.loadRequest(request)
        }*/
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(){
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}
