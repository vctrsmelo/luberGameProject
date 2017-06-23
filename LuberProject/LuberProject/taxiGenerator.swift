////
////  taxiGenerator.swift
////  LuberProject
////
////  Created by Bruno da Silva Dorneles on 22/06/17.
////  Copyright © 2017 Victor S Melo. All rights reserved.
////
//
//import UIKit
//
//  Created by Bruno da Silva Dorneles on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import UIKit

class taxiGenerator: NSObject {
   var gameScene  : GameManagerScene
    var present_difficulty : difficulty = .easy
    var maxNumberOfTaxi = 8
    init(scene:GameManagerScene ) {
        gameScene = scene
    }
    func trytoGenerate(){
        verifyCurrentDifficulty() // VERIFICA SE PASSOU DOS NUMEROS DE KM AVALIADOS E MUDA A DIFICULDADE SE PASSOU
       
        
        if (checkIfCrowded()){ // VERIFICA SE TEM MUITOS CARROS NA TELA
            switch present_difficulty {
            case .easy:
                generateEasyTaxi()
            case .regular:
                generateRegularTaxi()
            case .hard:
                generateHardTaxi()
            case .superhard:
                generateSuperhardTaxi()
            }
        }
        
        
    }

    //funcao que gera taxis de forma facil
    func generateEasyTaxi(){
        
        geraUmTaxi(speed: 3)
        
        
    }
    //funcao que gera taxis de forma media
    func generateRegularTaxi(){
        let random = Int(arc4random_uniform(3))
        
        if random==1{geraDoisTaxi(speed: 3)}
        else {geraUmTaxi(speed: 3)}
        
    }
    //funcao que gera taxis de forma dificil
    func generateHardTaxi(){
        let random = Int(arc4random_uniform(4))
        
        switch random {
        case 1:
                geraDoisTaxi(speed: 3)
        case 2:
                geraCompostoTaxi(speed: 2.5)
        case 3:
            geraCompostoTriplo(speed: 2.5)
        default:
            geraCompostoTaxi(speed: 2.5)
}


    }
    func generateSuperhardTaxi(){
        let random = Int(arc4random_uniform(4))
        
        switch random {
        case 1:
            geraImpossivel(speed: 2.25)
        case 2:
            geraCompostoQuadruplo(speed: 2.25)
        case 3:
            geraCompostoTriplo(speed: 2.25)
        default:
            geraCompostoTaxi(speed: 2.25)
        }
        
        
    }
   
    func checkIfCrowded()->Bool{
        if gameScene.taxis.count > maxNumberOfTaxi{
            return false
        }
        else {return true}
      
    }
    func   geraCompostoTriplo(speed:Float){
        let random = Int((arc4random_uniform(3))+1)
        var random2 = Int((arc4random_uniform(3))+1)
        var random3 = Int((arc4random_uniform(3))+1)
        while random==random2 {
            random2 = Int((arc4random_uniform(3))+1)
        }
        
        while (random2==random3) && (random==random3) {
            random3 = Int((arc4random_uniform(3))+1)
        }
        
        gameScene.addTaxi(atLane:random ,carYDistance: 0,taxiSpeed: Float(speed)-0.25)
        gameScene.addTaxi(atLane:random2 ,carYDistance: 2,taxiSpeed: Float(speed))
        gameScene.addTaxi(atLane:random3 ,carYDistance: 4,taxiSpeed: Float(speed))


    
    }
    func geraImpossivel(speed:Float){
        let random = Int((arc4random_uniform(3))+1)
        var random2 = Int((arc4random_uniform(3))+1)
        var random3 = Int((arc4random_uniform(3))+1)
        while random==random2 {
            random2 = Int((arc4random_uniform(3))+1)
        }
        
        while (random2==random3) && (random==random3) {
            random3 = Int((arc4random_uniform(3))+1)
        }
        
        gameScene.addTaxi(atLane:random ,carYDistance: 0,taxiSpeed: Float(speed))
        gameScene.addTaxi(atLane:random2 ,carYDistance: 2,taxiSpeed: Float(speed))
        gameScene.addTaxi(atLane:random3 ,carYDistance: 4,taxiSpeed: Float(speed))
        gameScene.addTaxi(atLane:random ,carYDistance: 5,taxiSpeed: Float(speed)-25)
        gameScene.addTaxi(atLane:random2 ,carYDistance: 5,taxiSpeed: Float(speed))
        gameScene.addTaxi(atLane:random3 ,carYDistance: 6,taxiSpeed: Float(speed))



    
    }
    
    func geraCompostoQuadruplo(speed:Float){
        let random = Int((arc4random_uniform(3))+1)
        var random2 = Int((arc4random_uniform(3))+1)
        var random3 = Int((arc4random_uniform(3))+1)
        while random==random2 {
            random2 = Int((arc4random_uniform(3))+1)
        }
        
        while (random2==random3) && (random==random3) {
            random3 = Int((arc4random_uniform(3))+1)
        }
        
        gameScene.addTaxi(atLane:random ,carYDistance: 0,taxiSpeed: Float(speed)-25)
        gameScene.addTaxi(atLane:random2 ,carYDistance: 2,taxiSpeed: Float(speed))
        gameScene.addTaxi(atLane:random3 ,carYDistance: 4,taxiSpeed: Float(speed))
        gameScene.addTaxi(atLane:random ,carYDistance: 5,taxiSpeed: Float(speed))
        
    }
    func geraCompostoTaxi(speed:Float){
        let random = Int((arc4random_uniform(3))+1)
        var random2 = Int((arc4random_uniform(3))+1)
        while random==random2 {
            random2 = Int((arc4random_uniform(3))+1)
        }
        
        gameScene.addTaxi(atLane:random ,carYDistance: 0,taxiSpeed: Float(speed))
        gameScene.addTaxi(atLane:random2 ,carYDistance: 2,taxiSpeed: Float(speed))
    
    }

    func geraDoisTaxi(speed: Float){
            let random = Int((arc4random_uniform(3))+1)
            var random2 = Int((arc4random_uniform(3))+1)
        while random==random2 {
            random2 = Int((arc4random_uniform(3))+1)
        }
        
        gameScene.addTaxi(atLane:random ,carYDistance: 1,taxiSpeed: Float(speed))
        gameScene.addTaxi(atLane:random2 ,carYDistance: 1,taxiSpeed: Float(speed))

    
    }
    func geraUmTaxi(speed: Float){
        let random = Int((arc4random_uniform(3))+1)
        
  gameScene.addTaxi(atLane:random ,carYDistance: 1,taxiSpeed: Float(speed))
    
    }
    
    func verifyCurrentDifficulty (){
        let  gameManagerScenekm = gameScene.distance
        switch gameManagerScenekm{
        case 0.0..<difficulty.easy.rawValue:
            present_difficulty = difficulty.easy
        case difficulty.easy.rawValue..<difficulty.regular.rawValue:
            present_difficulty = difficulty.regular
        case difficulty.regular.rawValue..<difficulty.hard.rawValue:
            present_difficulty = difficulty.hard

            
        default:
                present_difficulty = difficulty.hard
        }
        
    }
    
}






enum difficulty: Float {
    case easy = 0.250
    case regular = 0.750
    case hard = 1
    case superhard = 2
    
}
