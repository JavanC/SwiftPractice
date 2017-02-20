//
//  BluetoothManager.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2017/2/13.
//  Copyright © 2017年 Javan chen. All rights reserved.
//

import UIKit
import CoreBluetooth

protocol BluetoothManagerDelegate {
    func debugLogUpdate(debugLog: String)
    func updateLightStatus(isLightOn: Bool)
}

enum ValueType {
    case Read
    case Write
}

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    static let sharedInstance = BluetoothManager()
    var btCentralManager: CBCentralManager!
    var btPeripheral: CBPeripheral?
    var btService: CBService?
    var btCharacteristic: CBCharacteristic?
    var timer: Timer?
    var beaconData: BeaconData!
    var isLightOn: Bool = false
    var delegate: BluetoothManagerDelegate?
    var valueType: ValueType = .Write
    
    // MARK: - Use Function
    
    func initialization() {
        btCentralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func changeLightStatus(beaconData: BeaconData, isLightOn: Bool) {
        self.beaconData = beaconData
        self.isLightOn = isLightOn
        self.valueType = .Write

        delegate?.debugLogUpdate(debugLog: "Scanning Target BLE.......................")
        btCentralManager.scanForPeripherals(withServices: nil, options: nil)
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.stopScan), userInfo: nil, repeats: false)
    }
    
    func readLightStatue(beaconData: BeaconData) {
        self.beaconData = beaconData
        self.valueType = .Read
        
        delegate?.debugLogUpdate(debugLog: "Scanning Target BLE.......................")
        btCentralManager.scanForPeripherals(withServices: nil, options: nil)
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.stopScan), userInfo: nil, repeats: false)
    }
    
    // MARK: - Custom
    
    func stopScan() {
        delegate?.debugLogUpdate(debugLog: "\nTime out, Stop Scan.\n")
        btCentralManager.stopScan()
    }
    
    func stopConnected() {
        if btPeripheral != nil {
            delegate?.debugLogUpdate(debugLog: "\nTime out, Stop Connected.\n")
            btCentralManager.cancelPeripheralConnection(btPeripheral!)
        }
    }
    
    // MARK: - CBCentralManager Delegate
    
    internal func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        print("centralManagerDidUpdate - \(central.state.rawValue)")
    }
    
    internal func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let btIsConnectables = (advertisementData[CBAdvertisementDataIsConnectable] as! NSNumber) == 1
        if peripheral.identifier == beaconData.bleUUID && btIsConnectables {
            delegate?.debugLogUpdate(debugLog: "Success!\nConnecting.....................................")
            self.btPeripheral = peripheral
            btCentralManager.stopScan()
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.stopConnected), userInfo: nil, repeats: false)
            btCentralManager.connect(peripheral, options: nil)
            
        }
    }
    
    internal func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
            delegate?.debugLogUpdate(debugLog: "Success!\nDiscover Light Service....................")
            peripheral.discoverServices([Config.LIGHT_Service])
    }
    
    // MARK: - CBPeripheral Delegate
    
    internal func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let service:CBService = peripheral.services?.filter({ $0.uuid == Config.LIGHT_Service }).first {
            delegate?.debugLogUpdate(debugLog: "Success!\nDiscover Light Characteristics........")
            self.btService = service
            peripheral.discoverCharacteristics([Config.LIGHT_CHARACTERISTIC], for: service)
        }
    }
    
    internal func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let char:CBCharacteristic = service.characteristics?.filter({ $0.uuid == Config.LIGHT_CHARACTERISTIC }).first {
            switch valueType {
            case .Write:
                delegate?.debugLogUpdate(debugLog: "Success!\nWrite Value.....................................")
                self.btCharacteristic = char
                let data = isLightOn ? Config.LIGHT_ON_COMMAND : Config.LIGHT_OFF_COMMAND
                peripheral.writeValue(data, for: char, type: .withResponse)
            case .Read:
                delegate?.debugLogUpdate(debugLog: "Success!\nRead Value.....................................")
                self.btCharacteristic = char
                peripheral.readValue(for: char)
            }
        }
    }
    
    internal func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil{
            print("Error: \(error?.localizedDescription)")
        } else {
            self.delegate?.debugLogUpdate(debugLog: "Success!\nLight is \(self.isLightOn ? "On" : "Off"). Disconnect BLE.\n")
            self.delegate?.updateLightStatus(isLightOn: isLightOn)
            btCentralManager.cancelPeripheralConnection(btPeripheral!)
            timer?.invalidate()
        }
    }
    
    internal func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        // print(characteristic)
        if let value = characteristic.value {
            self.isLightOn = (value == Config.LIGHT_ON_COMMAND)
            self.delegate?.updateLightStatus(isLightOn: isLightOn)
            delegate?.debugLogUpdate(debugLog: "Success!\nLight is \(self.isLightOn ? "On" : "Off"). Disconnect BLE.\n")
            btCentralManager.cancelPeripheralConnection(btPeripheral!)
            timer?.invalidate()
        }
    }
}
