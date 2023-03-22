//
//  MenuINICIAL.swift
//  Bath Games
//
//  Created by Diego Juárez on 22/03/23.
//

import Cocoa

class MenuINICIAL: NSViewController {
    
    override func viewDidAppear(){
        
        super.viewDidAppear()
        self.view.window?.title="BATH GAMES"
        
    }
    
    override func viewDidDisappear() {
   
        if(!isMenuJuegoActive){
            
            self.view.window?.cancelOperation(self)
            
        }
    
   }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var btnPREGUNTA2: NSButton!
    @IBOutlet weak var btnMATEMATIK: NSButton!
   
    var isMenuJuegoActive:Bool = false
    
    @IBAction func irAPregunta2(_ sender: NSButton) {
        isMenuJuegoActive=true
        performSegue(withIdentifier: "pregunta2", sender: self)
    }
    
    
    @IBAction func irAMatematik(_ sender: NSButton) {
        isMenuJuegoActive=true
        performSegue(withIdentifier: "matematik", sender: self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        self.view.window?.close()
        
    }


}
