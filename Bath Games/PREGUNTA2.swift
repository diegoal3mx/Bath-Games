//
//  PREGUNTA2.swift
//  Bath Games
//
//  Created by Diego Juárez on 20/03/23.
//

import Cocoa

class PREGUNTA2: NSViewController {

    var preguntas: [String] =
    ["La caja negra de un avión es negra",
     "Marrakech es la capital de Marruecos",
     "El unicornio es el animal nacional de Escocia",
     "Cenicienta fue la primera princesa de Disney",
     "Australia es más ancha que la Luna",
     "Alexander Fleming descubrió la penicilina",
     "Mercurio es el planeta más caliente del sistema solar",
     "Los plátanos son curvos porque crecen hacia el sol",
     "Hay cuatro sabores básicos",
     "El cerebro es el órgano más pesado del cuerpo humano",
     "El rugido de un león puede oírse hasta a ocho kilómetros de distancia",
     "Estambul es la capital de Turquía",
     "El francés es el idioma oficial de Andorra",
     "El Nilo es el río más largo del mundo",
     "H&M son las siglas de Hennes & Mauritz",
     "Ra era el dios egipcio del Sol",
     "Google iba a llamarse BackRub",
     "La casa de Ana Frank está en Berlín",
     "Mónaco es el país más pequeño del mundo",
     "La Orden de los Caballeros Templarios se disolvió en 1312"
    ]
    
    var respuestas: [String] =
    ["Falso","Falso","Verdadero","Falso","Verdadero","Verdadero","Falso","Verdadero","Falso","Falso","Verdadero","Falso","Falso","Verdadero","Verdadero","Verdadero","Verdadero","Falso","Falso","Verdadero"]
    
    var contador:Int = 0
    var correctas:Int = 0
    var puntajeParaGanar:Int = 5
    var racha:Int = 0
    var rachaMaxima:Int = 0
    var vidas:Int = 5
    var juegoTerminado:Bool = false
    var dificultad:String = "Principiante"
    var numbers:[Int] = []
    var imgsPreguntas:[NSImage]=[]
    var corazones:[NSImageView]=[]

    
        func inicializarJuego(){
        
            txtVidas.isHidden=true
            txtCorrectas.isHidden=true
           
            btnCambiarDificultad.isHidden=true
            btnFalso.isHidden=true
            btnVerdadero.isHidden=true
            btnReiniciar.isHidden=true
            pregunta.isHidden=true
            imgConfeti.isHidden=true
            imgCopa.isHidden=true
    
                cargarNumerosDePreguntas()
                prepararCorazones()
               
            for contador in 0...4 {
                corazones[contador].isHidden=true
            }
        }
    
    
    
    class GradientView: NSView {
        var gradient: NSGradient?

        override func draw(_ dirtyRect: NSRect) {
            guard let gradient = gradient else { return }

            gradient.draw(in: bounds, angle: 45.0)
        }
    }

   
   
    
        override func viewDidAppear(){
        
            super.viewDidAppear()
            self.view.window?.title="PREGUNTA2"
            let gradientView = GradientView(frame: self.view.frame)
            gradientView.gradient = NSGradient(starting: NSColor.red, ending: NSColor.blue)
            
            self.view.addSubview(gradientView, positioned: NSWindow.OrderingMode.below, relativeTo: self.view)
        
        }
    
        override func viewDidDisappear() {
       
            performSegue(withIdentifier: "dificultad", sender: self)
        
       }
    
        override func viewDidLoad() {
        
            super.viewDidLoad()
            
            inicializarJuego()
            recargarJuego(_String:dificultad)
        
        }
    
    
       
    
    
    @IBOutlet weak var corazon5: NSImageView!
    @IBOutlet weak var corazon4: NSImageView!
    @IBOutlet weak var corazon3: NSImageView!
    @IBOutlet weak var corazon2:NSImageView!
    @IBOutlet weak var corazon1:NSImageView!
  
    @IBOutlet weak var imgCopa: NSImageView!
    @IBOutlet weak var imgConfeti: NSImageView!

    @IBOutlet weak var imgPregunta: NSImageView!
    
    @IBOutlet weak var pregunta: NSTextField!
    @IBOutlet weak var txtCorrectas: NSTextField!
    @IBOutlet weak var txtPuntosParaGanar: NSTextField!
    @IBOutlet weak var txtRacha: NSTextField!
    @IBOutlet weak var txtRachaMaxima:NSTextField!
    @IBOutlet weak var txtJugadas: NSTextField!
    @IBOutlet weak var txtVidas: NSTextField!

    
   
    @IBOutlet weak var btnReiniciar: NSButton!
    @IBOutlet weak var btnCambiarDificultad: NSButton!
    @IBOutlet weak var btnVerdadero: NSButton!
    @IBOutlet weak var btnFalso: NSButton!
 
    
        @IBAction func cambiarDificultad(_ sender: NSButton) {
            let juego = self
            dismiss(juego)
            
        }
    
   
    
        @IBAction func reiniciarJuego(_ sender: NSButton) {
            
            recargarJuego(_String: dificultad)
            
        }
        @IBAction func botones(_ sender: NSButton) {
        
            validarRespuesta(sender)
            actualizarRacha()
            checarPuntaje()
        
                if vidas>0 && !juegoTerminado{
            
                    mostrarSiguientePregunta()
            
                }
        }
          
        
        
    
    func validarRespuesta(_ sender:NSButton){
          
          if sender.title != respuestas[numbers[contador]] && vidas>0{
              
              actualizarRespuestaIncorrecta()
              
          }
          
            else{
              
              actualizarRespuestaCorrecta()
                
          }
      }

    func actualizarRacha(){
        
        if racha>rachaMaxima{
                
            rachaMaxima=racha
            
        }
        
        txtRacha.stringValue="RACHA: " + String(racha)
    }

    func checarPuntaje (){
    
      if vidas<1{
          
          perderJuego()
         
      }
    
        else if correctas==puntajeParaGanar {
                                    
                    ganarJuego()
          
            }
    }

    func mostrarSiguientePregunta(){
        
        contador+=1
        pregunta.stringValue=preguntas[numbers[contador]]
        imgPregunta.image = NSImage(named: "pregunta\(numbers[contador])")!
        
    }


    func actualizarRespuestaCorrecta(){
        
        correctas=correctas+1
        racha=racha+1
        txtCorrectas.stringValue="CORRECTAS: " + String(correctas)
        txtPuntosParaGanar.stringValue=String((puntajeParaGanar-correctas)) + " PUNTOS PARA GANAR"
      
    }

    func actualizarRespuestaIncorrecta(){
        
        vidas=vidas-1
        racha=0
        corazones[vidas].isHidden=true
        txtVidas.stringValue="VIDAS: " + String(vidas)
        
    }
      
    
    func cargarNumerosDePreguntas(){
        
        for contador in 0...preguntas.count-1 {
            numbers.append(contador)
        }
        
    }

    func prepararCorazones(){
        
        corazones.append(corazon1)
        corazones.append(corazon2)
        corazones.append(corazon3)
        corazones.append(corazon4)
        corazones.append(corazon5)
    
    }

    func randomizarPreguntas(){
     
        numbers.shuffle();

      }
      
      
    func recargarJuego(_String dificultad:String){
        
        switch dificultad {
            
            case "Intermedio":
            
                puntajeParaGanar = 7
                vidas = 2
                for contador in 0...vidas-1 {
                    corazones[contador].isHidden=false
                }
            
            case "Avanzado":
            
                puntajeParaGanar = 10
                vidas = 1
                for contador in 0...vidas-1 {
                    corazones[contador].isHidden=false
                }
            
            default:
            
                puntajeParaGanar = 5
                vidas = 3
                for contador in 0...vidas-1 {
                    corazones[contador].isHidden=false
                }
            
            
            
        }
    
        contador=0
        correctas=0
        racha=0
        rachaMaxima=0
        juegoTerminado=false
        randomizarPreguntas()
        
        txtVidas.isHidden=false
        txtCorrectas.isHidden=false
        txtRachaMaxima.isHidden=true
        txtJugadas.isHidden=true
        txtPuntosParaGanar.isHidden=false
        
        txtVidas.stringValue="VIDAS: " + String(vidas)
        txtCorrectas.stringValue="CORRECTAS: " + String(correctas)
        txtPuntosParaGanar.stringValue=String((puntajeParaGanar-correctas)) + " PUNTOS PARA GANAR"
        txtRacha.stringValue="RACHA: " + String(racha)
        pregunta.stringValue=preguntas[numbers[contador]]
        imgPregunta.image = NSImage(named: "pregunta\(numbers[contador])")!
        
        btnCambiarDificultad.isHidden=true
        btnFalso.isHidden=false
        btnVerdadero.isHidden=false
       
        pregunta.isHidden=false
        imgPregunta.isHidden=false
        btnReiniciar.setFrameOrigin(NSPoint(x: 392, y: 18))
        btnReiniciar.isHidden=false
        imgConfeti.isHidden=true
        imgCopa.isHidden=true
        
    
            

    }

    func terminarJuego(){
    
        btnReiniciar.setFrameOrigin(NSPoint(x: 151, y: 81))
        btnReiniciar.isHidden=false
        btnCambiarDificultad.isHidden=false
        imgPregunta.isHidden=true
        btnFalso.isHidden=true
        btnVerdadero.isHidden=true
        txtCorrectas.stringValue="CORRECTAS: " + String(correctas)
        txtRachaMaxima.stringValue="RACHA MÁXIMA: " + String(rachaMaxima)
        txtJugadas.stringValue="JUGADAS: " + String(contador+1)
        txtJugadas.isHidden=false
        txtRachaMaxima.isHidden=false
        juegoTerminado=true
        
    }

    func perderJuego(){
        
        pregunta.stringValue="PERDISTE"
        
            terminarJuego()
        
    }

    func ganarJuego(){
        
        pregunta.stringValue="GANASTE"
        imgConfeti.isHidden=false
        imgCopa.isHidden=false
        txtPuntosParaGanar.isHidden=true
        
            terminarJuego()
        
    }

  
}


