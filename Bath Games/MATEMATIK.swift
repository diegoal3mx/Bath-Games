//
//  MATEMATIK.swift
//  Bath games
//
//  Created by Saul Ivàn Campos Solìs on 19/03/23.
//

import Cocoa

class MATEMATIK: NSViewController {
    
    @IBOutlet weak var operando1: NSTextField!
    @IBOutlet weak var operando2: NSTextField!
    @IBOutlet weak var operador: NSTextField!
    @IBOutlet weak var respuestaUsuario: NSTextField!
    @IBOutlet weak var imageViewResultado: NSImageView!
    @IBOutlet weak var imageVida1: NSImageView!
    @IBOutlet weak var imageVida2: NSImageView!
    @IBOutlet weak var imageVida3: NSImageView!
    @IBOutlet weak var labelFinDelJuego: NSTextField!
    @IBOutlet weak var labelRacha: NSTextField!
    @IBOutlet weak var imageViewFinDelJuego: NSImageView!
    @IBOutlet weak var labelPuntaje: NSTextField!
    @IBOutlet weak var btnValidar: NSButton!
    @IBOutlet weak var labelPuntajeResumen: NSTextField!
    @IBOutlet weak var labelMayorRacha: NSTextField!
    @IBOutlet weak var btnJugarDeNuevo: NSButton!
    @IBOutlet weak var labelJugadas: NSTextField!
    @IBOutlet weak var labelPuntosParaGanar: NSTextField!
    
    var receivedString:String?
    let operadores = ["+", "-", "*"]
    var operandos = [Int]()
    var resultado = 0
    var contadorRespuestasCorrectas = 0
    var contadorRespuestasIncorrectas = 0
    var correctasParaGanar = 0
    var contadorRachas = 0
    var vidasSegunNivel = 0
    var contadorVidas = 0
    var contadorDePuntos = 0
    var mayorRacha = 0
    var contJugadas = 0
    var puntosParaGanarSegunNivel = 0
    
    @IBOutlet weak var nivelLabel: NSTextField!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = "MATEMATIK"
        self.view.window?.backgroundColor = NSColor (red: 0.0941, green: 0.1137, blue: 0.1921, alpha: 100)
    }
    
    override func viewDidDisappear() {
   
        performSegue(withIdentifier: "irInicio", sender: self)
    
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        btnJugarDeNuevo.isHidden = true
        labelMayorRacha.isHidden = true
        labelPuntajeResumen.isHidden = true
        imageViewFinDelJuego.isHidden = true
        respuestaUsuario.isEditable = true
        labelJugadas.isHidden = true
        nivelLabel.stringValue = receivedString!
        establecerDificultad()
        operando1.isEditable = false
        operando2.isEditable = false
        operador.isEditable = false
        operandos = [Int.random(in: 1...100), Int.random(in: 1...100)]
        operando1.stringValue = String(operandos[0])
        operando2.stringValue = String(operandos[1])
        operador.stringValue = operadores.randomElement()!
       
    }
    
    func verificarNivel() -> String {
        let nivelElegido = nivelLabel.stringValue
        return nivelElegido
    }
    
    func contarPuntos() {
        contadorDePuntos += 1
        
        labelPuntaje.stringValue = "PUNTAJE: \(contadorDePuntos)"
        labelPuntajeResumen.stringValue = "PUNTAJE: \(contadorDePuntos)"
    }
    
    func establecerDificultad() {
        if (verificarNivel() == "Facil"){
            vidasSegunNivel = 3
            contadorVidas = 3
            correctasParaGanar = 5
            puntosParaGanarSegunNivel = 5
            labelPuntosParaGanar.stringValue = "PUNTOS PARA GANAR : \(puntosParaGanarSegunNivel)"
            imageVida1.isHidden = false
            imageVida2.isHidden = false
            imageVida3.isHidden = false
        }else if (verificarNivel() == "Medio"){
            vidasSegunNivel = 2
            contadorVidas = 2
            correctasParaGanar = 7
            puntosParaGanarSegunNivel = 7
            labelPuntosParaGanar.stringValue = "PUNTOS PARA GANAR : \(puntosParaGanarSegunNivel)"
            imageVida1.isHidden = false
            imageVida2.isHidden = false
            imageVida3.isHidden = true
        }else {
            vidasSegunNivel = 1
            contadorVidas = 1
            correctasParaGanar = 10
            puntosParaGanarSegunNivel = 10
            labelPuntosParaGanar.stringValue = "PUNTOS PARA GANAR : \(puntosParaGanarSegunNivel)"
            imageVida1.isHidden = false
            imageVida3.isHidden = true
            imageVida2.isHidden = true
        }
    }
    
    func actualizarImagenVidas(){
        if(vidasSegunNivel == 3) {
            if (contadorVidas >= 3){
                
            }
            else if (contadorVidas == 2){
                imageVida3.isHidden = true
            }
            else if (contadorVidas == 1){
                imageVida2.isHidden = true
            }
            else if (contadorVidas == 0){
                imageVida1.isHidden = true
            }
        }
        else if (vidasSegunNivel == 2){
            if (contadorVidas >= 2){
                
            }
            else if (contadorVidas == 1){
                imageVida2.isHidden = true
            }
            else {
                imageVida1.isHidden = true
            }
        }
        else {
            if (contadorVidas >= 1){
                
            }
            else {
                imageVida1.isHidden = true
            }
        }
    }
    
    func calcularResultado() -> Int {
        if (operador.stringValue == "+") {
            resultado = operandos[0] + operandos[1]
        }
        else if (operador.stringValue == "-") {
            resultado = operandos[0] - operandos[1]
        }
        else {
            resultado = operandos[0] * operandos[1]
        }
        return resultado
    }
    
    func obtenerRespuestaUsuario() -> Int {
        var respuesta: Int

            respuesta = Int(respuestaUsuario.stringValue) ?? 0
        
        
        return respuesta
    }
    
    @IBAction func validarRespuesta(_ sender: NSButton) {
        if(vidasSegunNivel == 1) {
            handleCalificarRespuestasUnaVida()
        } else{
            calificarRespuestas()
        }
    }
    
    func guardarRacha() {
        if (contadorRachas > mayorRacha) {
            mayorRacha = contadorRachas
        }
        labelMayorRacha.stringValue = "MAYOR RACHA: \(mayorRacha)"
    }
    
    func generarPregunta() {
        if(contadorRespuestasCorrectas == correctasParaGanar){
            ganaste()
        }
        else {
            operandos = [Int.random(in: 1...100), Int.random(in: 1...100)]
            operando1.stringValue = String(operandos[0])
            operando2.stringValue = String(operandos[1])
            operador.stringValue = operadores.randomElement()!
        }
        contJugadas += 1
    }
    
    func calificarRespuestas() {
            if (contadorRespuestasIncorrectas < contadorVidas){
                if (calcularResultado() == obtenerRespuestaUsuario()) {
                    puntosParaGanarSegunNivel -= 1
                    labelPuntosParaGanar.stringValue = "PUNTOS PARA GANAR : \(puntosParaGanarSegunNivel)"
                    imageViewResultado.image = NSImage(imageLiteralResourceName: "cheque" )
                    contadorRespuestasCorrectas += 1
                    contadorRachas += 1
                    generarPregunta()
                   
                    labelRacha.stringValue = "Racha: \(contadorRachas)"
                    respuestaUsuario.stringValue = ""
                    contarPuntos()
                    guardarRacha()
                }
                else{
                    imageViewResultado.image = NSImage(imageLiteralResourceName: "cancelar" )
                    contadorVidas -= 1
                    contadorRespuestasIncorrectas += 1
                    generarPregunta()
                   
                    actualizarImagenVidas()
                    contadorRachas = 0
                    labelRacha.stringValue = "Racha: \(contadorRachas)"
                    respuestaUsuario.stringValue = ""
                }
            }
            else{
                contadorRachas = 0
                contadorVidas -= 1
                contJugadas += 1
                contadorRespuestasIncorrectas += 1
                actualizarImagenVidas()
                labelFinDelJuego.stringValue = "PERDISTE"
                respuestaUsuario.isEditable = false
                respuestaUsuario.stringValue = ""
                perdiste()
            }
        }
    
    func ganaste() {
        nivelLabel.isHidden = true
        imageVida1.isHidden = true
        imageVida2.isHidden = true
        imageVida3.isHidden = true
        labelRacha.isHidden = true
        operando1.isHidden = true
        operando2.isHidden = true
        operador.isHidden = true
        respuestaUsuario.isHidden = true
        btnValidar.isHidden = true
        imageViewResultado.isHidden = true
        imageViewFinDelJuego.isHidden = false
        imageViewFinDelJuego.image = NSImage(imageLiteralResourceName: "insignia")
        labelPuntaje.isHidden = true
        labelPuntajeResumen.isHidden = false
        labelMayorRacha.isHidden = false
        btnJugarDeNuevo.isHidden = false
        labelFinDelJuego.isHidden = false
        contJugadas += 1
        labelJugadas.isHidden = false
        labelFinDelJuego.stringValue = "GANASTE"
        labelJugadas.stringValue = "JUGADAS: \(contJugadas)"
        labelPuntosParaGanar.isHidden = true
    }
        
        func perdiste()  {
            nivelLabel.isHidden = true
            imageVida1.isHidden = true
            imageVida2.isHidden = true
            imageVida3.isHidden = true
            labelRacha.isHidden = true
            operando1.isHidden = true
            operando2.isHidden = true
            operador.isHidden = true
            respuestaUsuario.isHidden = true
            btnValidar.isHidden = true
            imageViewResultado.isHidden = true
            imageViewFinDelJuego.isHidden = false
            imageViewFinDelJuego.image = NSImage(imageLiteralResourceName: "triste")
            contadorDePuntos = 0
            labelPuntaje.isHidden = true
            labelPuntajeResumen.isHidden = false
            labelMayorRacha.isHidden = false
            btnJugarDeNuevo.isHidden = false
            labelJugadas.isHidden = false
            labelJugadas.stringValue = "JUGADAS: \(contJugadas)"
            labelPuntosParaGanar.isHidden = true
        }
    
    
    
    @IBAction func JugarDeNuevo(_ sender: NSButton) {
        let juego = self
        dismiss(juego)
    }
    
    
        func handleCalificarRespuestasUnaVida() {
            if (calcularResultado() == obtenerRespuestaUsuario()) {
                puntosParaGanarSegunNivel -= 1
                labelPuntosParaGanar.stringValue = "PUNTOS PARA GANAR : \(puntosParaGanarSegunNivel)"
                imageViewResultado.image = NSImage(imageLiteralResourceName: "cheque" )
                contadorRespuestasCorrectas += 1
                contadorRachas += 1
                generarPregunta()
                
                labelRacha.stringValue = "Racha: \(contadorRachas)"
                respuestaUsuario.stringValue = ""
                contarPuntos()
                guardarRacha()
            }
            else {
                imageViewResultado.image = NSImage(imageLiteralResourceName: "cancelar" )
                contadorVidas -= 1
                contadorRespuestasIncorrectas += 1
                contadorRachas = 0
                generarPregunta()
             
                actualizarImagenVidas()
                labelFinDelJuego.stringValue = "PERDISTE"
                labelRacha.stringValue = "Racha: \(contadorRachas)"
                respuestaUsuario.isEditable = false
                respuestaUsuario.stringValue = ""
                perdiste()
            }
        }
    }



