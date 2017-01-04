//
//  ViewController.swift
//  CoreBluetoothTest
//
//  Created by Javan.Chen on 2017/1/4.
//  Copyright © 2017年 Javan.Chen. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController1: UITableViewController, CBCentralManagerDelegate {

    var btCentralManager: CBCentralManager!
    var btPeripherals: [CBPeripheral] = []      // 儲存掃描到的 peripheral 物件
    var btIsConnectables: [NSNumber] = []       // 儲存各個藍牙裝置是否可以連線
    var btRSSIs: [NSNumber] = []                // 儲存各個藍牙裝置的訊號強度
    @IBOutlet weak var bbRefresh: UIBarButtonItem!
    
    @IBAction func actionRefresh(_ sender: UIBarButtonItem) {
        bbRefresh.isEnabled = false
        title = "Scanning..."
        btPeripherals.removeAll(keepingCapacity: false)
        btRSSIs.removeAll(keepingCapacity: false)
        btIsConnectables.removeAll(keepingCapacity: false)
        btCentralManager.scanForPeripherals(withServices: nil, options: nil)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.stopScan), userInfo: nil, repeats: false)
    }
    
    func stopScan() {
        btCentralManager.stopScan()
        bbRefresh.isEnabled = true
        title = "Scan"
        tableView.reloadData()
        print("reload table view")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        btCentralManager = CBCentralManager(delegate: self, queue: nil)
        tableView.register(UINib(nibName: "PeripheralCell", bundle: nil), forCellReuseIdentifier: "PeripheralCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// Table view
extension ViewController1 {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PeripheralCell = tableView.dequeueReusableCell(withIdentifier: "PeripheralCell") as! PeripheralCell
        cell.lbName.text = "Name : " + (btPeripherals[indexPath.row].name != nil ? btPeripherals[indexPath.row].name! : "")
        cell.lbUUID.text = "UUID : \(btPeripherals[indexPath.row].identifier.uuidString)"
        cell.lbRSSI.text = "RSSI : \(btRSSIs[indexPath.row].description)"
        let RSSI_MEAN = 70
        let RSSI_N = 1
        let distancePower = Double(abs(btRSSIs[indexPath.row].intValue) - RSSI_MEAN) / Double(10 * RSSI_N)
        let distance = NSString(format: "%.2f", pow(10.0, distancePower))
        cell.lbDist.text = "Distance : \(distance) M"
        cell.lbIsConnectable.text = "Connectable : \(btIsConnectables[indexPath.row].description)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("return table cell number")
        return btPeripherals.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "sgToServiceList", sender: btPeripherals[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let targetVC = segue.destination as! ViewController2
        targetVC.centralManager = self.btCentralManager
        targetVC.peripheral = sender as! CBPeripheral
        targetVC.title = (sender as! CBPeripheral).name
    }
}

// CBCentral Manager
extension ViewController1 {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        let temp = btPeripherals.filter { (p1) -> Bool in
            return p1.identifier.uuidString == peripheral.identifier.uuidString
        }
        
        if temp.count == 0 {
            btPeripherals.append(peripheral)
            btRSSIs.append(RSSI)
            btIsConnectables.append(advertisementData[CBAdvertisementDataIsConnectable] as! NSNumber)
            print("-----")
            print(peripheral)
        }
    }
}
