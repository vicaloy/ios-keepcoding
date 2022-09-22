//
//  Dispatch.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/9/22.
//

import Foundation

func executeUserInterfaceTask(task: @escaping () -> ()){
    
    DispatchQueue.main.async {
        task()
    }
}

func executeUserInterfaceTaskDelayed(time: DispatchTime, task: @escaping () -> ()){
    DispatchQueue.main.asyncAfter(deadline: time) {
        task()
    }
}
