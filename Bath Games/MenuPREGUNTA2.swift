//
//  MenuPREGUNTA2.swift
//  Bath Games
//
//  Created by Diego Juárez on 22/02/23.
//

import Cocoa

class MenuPREGUNTA2: NSViewController {
    
    override func viewDidAppear(){
        
        super.viewDidAppear()
        self.view.window?.title="PREGUNTA2 Menú"
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    var botonDificultad:NSButton!
    
    
    @IBAction func mandarDificultad(_ sender: NSButton) {
        
        botonDificultad=sender.self
        performSegue(withIdentifier: "juego", sender: self)

    }
  
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
       self.view.window?.close()
        
        if segue.identifier == "juego" {
            
            let destinoVC=segue.destinationController as! PREGUNTA2
            
            destinoVC.dificultad = String(botonDificultad.title)
            
        }
    }
    
}

