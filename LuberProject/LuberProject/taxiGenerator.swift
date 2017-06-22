//
//  taxiGenerator.swift
//  LuberProject
//
//  Created by Bruno da Silva Dorneles on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import UIKit

class taxiGenerator: NSObject {
   var gameScene  : GameManagerScene
    var present_difficulty : difficulty = .easy
    var maxNumberOfTaxi = 6
    
    func trytoGenerate(){
        verifyCurrentDifficulty() // VERIFICA SE PASSOU DOS NUMEROS DE KM AVALIADOS E MUDA A DIFICULDADE SE PASSOU
       
        
        if (!checkIfCrowded()){ // VERIFICA SE TEM MUITOS CARROS NA TELA
        switch present_difficulty {
        case .easy:
            generateEasyTaxi()
        case .regular:
            generateRegularTaxi()
        case .hard:
            generateHardTaxi()
        default:
            generateEasyTaxi()
            }
        }
        
        
    }

    //funcao que gera taxis de forma facil
    func generateEasyTaxi(){
            gameScene.addTaxi(1,1,1,1)
    }
    //funcao que gera taxis de forma media
    func generateRegularTaxi(){
        
        // gameScene.addTaxi(atLane lane: Int, carXDistance xCars: CGFloat, taxiSpeed: Float)
        
    }
    //funcao que gera taxis de forma dificil
    func generateHardTaxi(){
    
        // gameScene.addTaxi(atLane lane: Int, carXDistance xCars: CGFloat, taxiSpeed: Float)

    }
   
    func checkIfCrowded()->Bool{
        if gameScene.taxis.count > maxNumberOfTaxi{
            return true
        }
        else {return false}
      
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
