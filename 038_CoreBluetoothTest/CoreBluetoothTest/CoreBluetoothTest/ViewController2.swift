//
//  ViewController2.swift
//  CoreBluetoothTest
//
//  Created by Javan.Chen on 2017/1/4.
//  Copyright © 2017年 Javan.Chen. All rights reserved.
//

import UIKit
import CoreBluetooth

class BTServiceInfo {
    var service: CBService!
    var characteristics: [CBCharacteristic]
    init(service: CBService, characteristics: [CBCharacteristic]) {
        self.service = service
        self.characteristics = characteristics
    }
}

class ViewController2: UITableViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    var btServices: [BTServiceInfo] = []
    
    override func viewWillAppear(_ animated: Bool) {
        centralManager.delegate = self
        peripheral.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CharacteristicCell", bundle: nil) , forCellReuseIdentifier: "CharacteristicCell")
        centralManager.connect(peripheral, options: nil)    // 連線
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacteristicCell = tableView.dequeueReusableCell(withIdentifier: "CharacteristicCell") as! CharacteristicCell
        cell.lbDESC.text = "DESC : \(btServices[indexPath.section].characteristics[indexPath.row].uuid.description)"
        cell.lbProp.text = "Prop : " + String(format: "0x%02X", btServices[indexPath.section].characteristics[indexPath.row].properties.rawValue)
        cell.lbValue.text = "Value : " + (btServices[indexPath.section].characteristics[indexPath.row].value?.description ?? "null")
        cell.lbNotifying.text = "Noti : " + btServices[indexPath.section].characteristics[indexPath.row].isNotifying.description
        cell.lbUUID.text = "UUID : " + btServices[indexPath.section].characteristics[indexPath.row].uuid.uuidString
        cell.lbPropertyContent.text = "Content : " + btServices[indexPath.section].characteristics[indexPath.row].getPropertyContent()
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "sgToCharDetail", sender: btServices[indexPath.section].characteristics[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(sender as! CBCharacteristic)
        if segue.identifier == "sgToCharDetail" {
            let targetVC = segue.destination as! ViewController3
            targetVC.peripheral = self.peripheral
            targetVC.char = sender as! CBCharacteristic
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return btServices.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return btServices[section].characteristics.count
    }
}

// CBCentral Manager
extension ViewController2 {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("central state:\(central.state.rawValue)")
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral.state == CBPeripheralState.connected {
            peripheral.discoverServices(nil)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for serviceObj in peripheral.services! {
            let service: CBService = serviceObj
            let isServiceIncluded = self.btServices.filter({ (item: BTServiceInfo) -> Bool in
                return item.service.uuid == service.uuid
            }).count
            if isServiceIncluded == 0 {
                btServices.append(BTServiceInfo(service: service, characteristics: []))
            }
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        let serviceCharacteristics = service.characteristics
        
        for item in btServices {
            if item.service.uuid == service.uuid {
                item.characteristics = serviceCharacteristics!
                break
            }
        }
        tableView.reloadData()
    }
}
