//
//  BlockStatus.swift
//  Platformer_Final
//
//  Created by Daphnis Labs on 14/03/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

import Foundation

class BlockStatus            // #9
{
    var isRunning = false                 //CURRENTLY RUNNING ON SCREEN OR NOT
    var timeGapForNextRun = UInt32(0)      // HOW LONG WE IT SHOULD WAIT FOR NEXT RUN
    var currentInterval = UInt32(0)         //TOTAL INTERVAL WAITED

//====================================================================================================================//

    // INITIALIZING BLOCK STATUS
    init(isRunning:Bool, timeGapForNextRun:UInt32, currentInterval:UInt32)
    {
        self.isRunning = isRunning
        self.timeGapForNextRun = timeGapForNextRun
        self.currentInterval = currentInterval
    }
//====================================================================================================================//
    
    // RUNNING BLOCKS
    func shouldRunBlock() -> Bool
    {
        return self.currentInterval > self.timeGapForNextRun
    }
    
//====================================================================================================================//

}