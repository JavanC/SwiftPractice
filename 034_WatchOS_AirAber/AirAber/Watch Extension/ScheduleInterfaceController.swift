//
//  ScheduleInterfaceController.swift
//  AirAber
//
//  Created by Javan.Chen on 2016/10/18.
//  Copyright © 2016年 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {

  @IBOutlet var flightsTable: WKInterfaceTable!
  var flights = Flight.allFlights()
  var selectedIndex = 0
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
    for index in 0..<flightsTable.numberOfRows {
      guard let controller = flightsTable.rowController(at: index) as? FlightRowController else { continue }
      controller.flight = flights[index]
    }
  }
  
  override func didAppear() {
    super.didAppear()
    guard flights[selectedIndex].checkedIn,
      let controller = flightsTable.rowController(at: selectedIndex) as? FlightRowController else {
        return
    }
    
    animate(withDuration: 0.35) {
      controller.updateForCheckIn()
    }
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
    let flight = flights[rowIndex]
    let controllers = ["Flight", "CheckIn"]
    
    selectedIndex = rowIndex
    presentController(withNames: controllers, contexts: [flight, flight])
  }
}
