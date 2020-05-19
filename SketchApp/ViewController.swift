//
//  ViewController.swift
//  SketchApp
//
//  Created by Havil on 13.05.2020.
//  Copyright © 2020 Havil. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var lampStatePower: NSButton!
    
    var udp: UDP? = nil
    
    override var representedObject: Any? {
        didSet {}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        udp = UDP(ip: "192.168.0.187", port: 4210, onSuccess: { stateServer in
            DispatchQueue.main.async {
                if stateServer!.power {
                    self.lampStatePower.state = NSControl.StateValue.on
                } else {
                    self.lampStatePower.state = NSControl.StateValue.off
                }
            }
        })
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: {_ in
            self.udp?.send(key: "getPowerState", value: "", onError: { err in
                print(err)
            })
        })
    }

    @IBAction func actionOn(_ sender: NSButton) {
        udp?.send(key: "power", value: "1", onError: { err in
            print(err)
        })
    }
    
    @IBAction func actionOff(_ sender: NSButton) {
        udp?.send(key: "power", value: "0", onError: { err in
            print(err)
        })
    }
    
    
    @IBAction func actionGetStatePower(_ sender: NSButton) {
        udp?.send(key: "getPowerState", value: "", onError: { err in
            print(err)
        })
    }
    
}

