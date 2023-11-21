//
//  ViewController.swift
//  InventoryApp
//
//  Created by 遠藤洸亮 on R 5/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldDataBoxes: UITextField!
    @IBOutlet weak var textFieldDataUnits: UITextField!
    @IBOutlet weak var textFieldActualBoxes: UITextField!
    @IBOutlet weak var textFieldActualUnits: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキストフィールドにイベントリスナーを設定
        textFieldDataBoxes.addTarget(self, action: #selector(calculateInventory), for: .editingChanged)
        textFieldDataUnits.addTarget(self, action: #selector(calculateInventory), for: .editingChanged)
        textFieldActualBoxes.addTarget(self, action: #selector(calculateInventory), for: .editingChanged)
        textFieldActualUnits.addTarget(self, action: #selector(calculateInventory), for: .editingChanged)
    }

    @objc func calculateInventory() {
        // テキストフィールドから値を取得
        let dataBoxes = Int(textFieldDataBoxes.text ?? "") ?? 0
        let dataUnits = Int(textFieldDataUnits.text ?? "") ?? 0
        let actualBoxes = Int(textFieldActualBoxes.text ?? "") ?? 0
        let actualUnits = Int(textFieldActualUnits.text ?? "") ?? 0

        // 在庫の合計を計算
        let totalDataUnits = (dataBoxes * dataUnits) + dataUnits
        let totalActualUnits = (actualBoxes * actualUnits) + actualUnits

        // 差を計算
        let difference = totalDataUnits - totalActualUnits

        // 結果を表示
        if difference > 0 {
            // 欠品の場合
            let missingBoxes = difference / dataUnits
            let missingUnits = difference % dataUnits
            resultLabel.text = "欠品: \(missingBoxes) 箱と \(missingUnits) 本"
        } else if difference < 0 {
            // 余剰の場合
            let extraBoxes = abs(difference) / dataUnits
            let extraUnits = abs(difference) % dataUnits
            resultLabel.text = "余剰: \(extraBoxes) 箱と \(extraUnits) 本"
        } else {
            // 在庫が一致する場合
            resultLabel.text = "在庫は一致しています"
        }
    }
}


