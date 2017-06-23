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
                generateRegularTaxi()
            case .regular:
                generateRegularTaxi()
            case .hard:
                generateHardTaxi()
            }
        }
        
        
    }

    //funcao que gera taxis de forma facil
    func generateEasyTaxi(){
        
        geraUmTaxi(speed: 4.5)
        
        
    }
    //funcao que gera taxis de forma media
    func generateRegularTaxi(){
        let random = Int(arc4random_uniform(3))
        
        if random==1{geraDoisTaxi(speed: 3)}
        else {geraUmTaxi(speed: 3)}
        
    }
    //funcao que gera taxis de forma dificil
    func generateHardTaxi(){
    
        // gameScene.addTaxi(atLane lane: Int, carXDistance xCars: CGFloat, taxiSpeed: Float)

    }
   
    func checkIfCrowded()->Bool{
        if gameScene.taxis.count > maxNumberOfTaxi{
            return false
        }
        else {return true}
      
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
        let  gameManagerScenekm = 10
        switch gameManagerScenekm{
        case 0..<difficulty.easy.rawValue:
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






enum difficulty: Int {
    case easy = 20
    case regular = 30
    case hard = 60
    
}
