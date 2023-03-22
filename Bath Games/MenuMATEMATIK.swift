//
//  MenuMATEMATIK.swift
//  Bath Games
//
//  Created by Diego Juárez on 22/03/23.
//

import Cocoa

class MenuMATEMATIK: NSViewController {
    
    var nivel : String?
    
    @IBOutlet weak var botonNivel: NSButton!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = "INICIO"
        self.view.window?.backgroundColor = NSColor (red: 0.0941, green: 0.1137, blue: 0.1921, alpha: 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //efew
    


    @IBAction func seleccionNivel(_ sender: NSButton) {
        nivel = sender.title
        performSegue(withIdentifier: "irMatematik", sender: self)
    }
    
    
    
        
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "irMatematik" {
            let destinationVC = segue.destinationController as! MATEMATIK
            destinationVC.receivedString = nivel
        }
    }
    
    
    
    
    
}

