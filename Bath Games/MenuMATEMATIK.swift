//
//  MenuMATEMATIK.swift
//  Bath Games
//
//  Created by Diego Juárez on 22/03/23.
//

import Cocoa

class MenuMATEMATIK: NSViewController {
    
    var nivel : String?
    var isJuegoActive:Bool = false
    
    @IBOutlet weak var botonNivel: NSButton!
    @IBOutlet weak var botonRegresar: NSButton!
    
    override func viewDidAppear() {
        
        super.viewDidAppear()
        self.view.window?.title = "MATEMATIK Menú"
        self.view.window?.backgroundColor = NSColor (red: 0.0941, green: 0.1137, blue: 0.1921, alpha: 100)
        
    }
    
    override func viewDidDisappear() {
   
        if(!isJuegoActive){
            
            performSegue(withIdentifier: "regresarDesdeMatematik", sender: self)
            
        }
    
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func regresar(_ sender: NSButton) {
        
        isJuegoActive=false
        let menu = self
        dismiss(menu)
    }
    
    @IBAction func seleccionNivel(_ sender: NSButton) {
        
        isJuegoActive=true
        nivel = sender.title
        performSegue(withIdentifier: "irMatematik", sender: self)
        
    }
    
        
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        self.view.window?.close()
        
        if segue.identifier == "irMatematik" {
            let destinationVC = segue.destinationController as! MATEMATIK
            destinationVC.receivedString = nivel
        }
    }
    
    
    
    
    
}

