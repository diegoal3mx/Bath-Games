//
//  MenuPREGUNTA2.swift
//  Bath Games
//
//  Created by Diego Juárez on 22/02/23.
//

import Cocoa

class MenuPREGUNTA2: NSViewController {
    
    
    class GradientView: NSView {
        var gradient: NSGradient?

        override func draw(_ dirtyRect: NSRect) {
            guard let gradient = gradient else { return }

            gradient.draw(in: bounds, angle: 45.0)
        }
    }

   
   
    
        override func viewDidAppear(){
        
            super.viewDidAppear()
            self.view.window?.title="PREGUNTA2 Menú"
            let gradientView = GradientView(frame: self.view.frame)
            gradientView.gradient = NSGradient(starting: NSColor.red, ending: NSColor.blue)
            
            self.view.addSubview(gradientView, positioned: NSWindow.OrderingMode.below, relativeTo: self.view)
        
        }
    
    override func viewDidDisappear() {
   
        if(!isJuegoActive){
            
            performSegue(withIdentifier: "regresarDesdePregunta2", sender: self)
            
        }
    
   }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    @IBOutlet weak var btnPrincipiante: NSButton!
    @IBOutlet weak var btnIntermedio: NSButton!
    @IBOutlet weak var btnAvanzado: NSButton!
    
    @IBOutlet weak var btnRegresar: NSButton!
    
    
    var botonDificultad:NSButton!
    var isJuegoActive:Bool = false
    
    @IBAction func regresar(_ sender: NSButton) {
        
        isJuegoActive=false
        let menu = self
        dismiss(menu)
        
    }
    
   
    
    @IBAction func mandarDificultad(_ sender: NSButton) {
        
        isJuegoActive=true
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

