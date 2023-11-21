import UIKit

class ViewController: UIViewController {
    // 在庫データのテキストフィールド
    @IBOutlet weak var textFieldDataBoxes: UITextField!
    @IBOutlet weak var textFieldDataUnits: UITextField!
    @IBOutlet weak var textFieldUnitsPerBox: UITextField!
    // 実際の在庫のテキストフィールド
    @IBOutlet weak var textFieldActualBoxes: UITextField!
    @IBOutlet weak var textFieldActualUnits: UITextField!

    // 結果表示用のラベル
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 入力変更時に在庫計算を実行するようリスナーを設定
        textFieldDataBoxes.addTarget(self, action: #selector(calculateInventory), for: .editingChanged)
        textFieldDataUnits.addTarget(self, action: #selector(calculateInventory), for: .editingChanged)
        textFieldUnitsPerBox.addTarget(self, action: #selector(calculateInventory), for: .editingChanged)
        textFieldActualBoxes.addTarget(self, action: #selector(calculateInventory), for: .editingChanged)
        textFieldActualUnits.addTarget(self, action: #selector(calculateInventory), for: .editingChanged)
    }

    // 実際の箱数を増減させるアクション
    @IBAction func adjustActualBoxes(_ sender: UIButton) {
        let adjustment = sender.tag // ボタンのタグを使用して調整値を取得
        adjustTextFieldValue(textField: textFieldActualBoxes, adjustment: sender.tag)
        calculateInventory()
    }

    // 実際の本数を増減させるアクション
    @IBAction func adjustActualUnits(_ sender: UIButton) {
        let adjustment = sender.tag
        adjustTextFieldValue(textField: textFieldActualUnits, adjustment: sender.tag)
        calculateInventory()
    }
    
    // データの箱数を増減させるアクション
    @IBAction func adjustDataBoxes(_ sender: UIButton) {
        let adjustment = sender.tag // ボタンのタグを使用して調整値を取得
        adjustTextFieldValue(textField: textFieldDataBoxes, adjustment: sender.tag)
        calculateInventory()
    }

    // データの本数を増減させるアクション
    @IBAction func adjustDataUnits(_ sender: UIButton) {
        let adjustment = sender.tag
        adjustTextFieldValue(textField: textFieldDataUnits, adjustment: sender.tag)
        calculateInventory()
    }
    
    @IBAction func adjustUnitsPerBox(_ sender: UIButton) {
        let adjustment = sender.tag
        adjustTextFieldValue(textField: textFieldUnitsPerBox, adjustment: sender.tag)
        calculateInventory()
    }
    
    // テキストフィールドの値を増減させる汎用メソッド
    func adjustTextFieldValue(textField: UITextField, adjustment: Int) {
        let currentValue = Int(textField.text ?? "") ?? 0 // 空の場合は0とする
        let newValue = currentValue + adjustment
        if newValue >= 0 {
            textField.text = "\(newValue)"
        }
    }


    
    
    // 在庫計算を実行するメソッド
    @objc func calculateInventory() {
        let dataBoxes = Int(textFieldDataBoxes.text ?? "") ?? 0
        let dataUnits = Int(textFieldDataUnits.text ?? "") ?? 0
        let unitsPerBox = Int(textFieldUnitsPerBox.text ?? "") ?? 0
        let actualBoxes = Int(textFieldActualBoxes.text ?? "") ?? 0
        let actualUnits = Int(textFieldActualUnits.text ?? "") ?? 0

        let totalDataUnits = dataBoxes * unitsPerBox + dataUnits
        let totalActualUnits = actualBoxes * unitsPerBox + actualUnits

        let difference = totalDataUnits - totalActualUnits

        if difference > 0 {
            if unitsPerBox != 0 { // 0での除算を防ぐ
                let missingBoxes = difference / unitsPerBox
                let missingUnits = difference % unitsPerBox
                resultLabel.text = "欠品: \(missingBoxes) 箱と \(missingUnits) 本"
                resultLabel.textColor = UIColor.systemTeal // 水色に設定
            }
        } else if difference < 0 {
            if unitsPerBox != 0 {
                let extraBoxes = abs(difference) / unitsPerBox
                let extraUnits = abs(difference) % unitsPerBox
                resultLabel.text = "余剰: \(extraBoxes) 箱と \(extraUnits) 本"
                resultLabel.textColor = UIColor.systemOrange // オレンジ色に設定
            }
        } else {
            resultLabel.text = "在庫は一致しています"
            resultLabel.textColor = UIColor.systemGreen // またはデフォルトの色に設定
        }
    }
}
