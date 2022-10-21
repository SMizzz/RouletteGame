//
//  AngleCalculate.swift
//  RandomWheelGame
//
//  Created by Jero on 2022/10/21.
//

import SwiftUI

// count가 4일 경우
// 하나당 필요한 각도는 90도
// startAngle은 0 -> 90 -> 180 -> 270
// endAngle은 270(360 - (360 / 갯 수)) -> 0 -> 90 -> 180

// count가 5일 경우
// 하나당 필요한 각도는 72도
// startAngle은 0 -> 72 -> 144 -> 216 -> 288
// endAngle은 288 (360 - (360 / 갯 수)) -> 0 -> 72 -> 144 -> 216


// 규칙 1 - startAngle
// startAngle의 규칙은 (360 / 입력받은 갯 수)만큼 더해진다.
// startAngle += (360 / count)

// 규칙 2 - endAngle
// endAngle의 규칙은 1번째는 360 - (360 / count) 이고, 두 번째는 0이 온다.
// 그 이후로는 startAngle과 같이 + (360 / count)만큼 더해진다.
// endAngle += (360 / count)

// 입력 받은 수만큼 각도를 계산하는 구조체
struct CalculateAngle {
    
    func CalculateAngleDegrees(
        _ count: Int
    ) -> (
        startAngleArray: [Double],
        endAngleArray: [Double]) {
        // #1 (360 / count)를 해주었을 때 소수점으로 떨어지는 count를 대비해 Double Type으로 정해준다.
        // #1-1 예를 들면 7일 경우가 있다.
        let countIntToDouble: Double = Double(count)
            
        // #2 규칙 1에서 (360 / 입력받은 갯 수)만큼 더해질 startAngle을 위한 변수
        var startAngle: Double = 0
            
        // #3 규칙 2에서 (360 / 입력받은 갯 수)만큼 더해질 endAngle을 위한 변수
        var endAngle: Double = 0
        
        var calculateAngle: Double = 360
            
        // #4 #2와 #3에서 계산한 값을 저장하기 위한 각각의 배열
        // startAngle은 무조건 0부터 시작하기 때문에 미리 배열에 0을 넣어준다.
        var startAngleArray: [Double] = [0]
        var endAngleArray: [Double] = []
        
        // #5 입력받은 갯 수로 한 칸당 몇 도일 지 계산해주는 calculateAngle 변수
        calculateAngle = calculateAngle / countIntToDouble
        
        // #6 count가 1일 경우, 이미 0을 넣어놨기 때문에 360도를 넣어주고,
        // endAngleArray도 360, 0을 차례대로 넣어준다.
        if count == 1 {
            startAngleArray.append(360)
            endAngleArray.append(360)
            endAngleArray.append(0)
        
        // #7 count가 2일 경우 부터 startAngle의 값을 #5에서 계산해준 값을 더해 배열에 넣는다.
        // #8 소수점일 경우에 숫자가 모자라 원이 완성되지 않는 경우를 위해 ceil 메소드를 사용하여 올림하여 배열에 넣어준다.
        } else if count == 2 {
            startAngle += calculateAngle
            startAngleArray.append(ceil(startAngle))
            endAngleArray.append(360 - calculateAngle)
            endAngleArray.append(0)
        } else if count >= 3 {
            for _ in 1...count {
                startAngle += calculateAngle
                startAngleArray.append(ceil(startAngle))
            }
            
            endAngleArray.append(360 - ceil(calculateAngle))
            endAngleArray.append(0)
            
            for _ in 2...count {
                endAngle += calculateAngle
                endAngleArray.append(ceil(endAngle))
            }
        }
        print("startAngleArray \(startAngleArray)")
        print("endAngleArray \(endAngleArray)")
        print("========================================")
        
        return (startAngleArray, endAngleArray)
    }
}
