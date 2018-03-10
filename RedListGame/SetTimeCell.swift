import UIKit

class SetTimeCell: UITableViewCell {

    @IBOutlet weak var pickerView: UIPickerView!
    let timeStrs = ["１分", "３分", "５分", "１０分", "１５分", "２０分", "３０分"]
    let seconds = [60, 180, 300, 600, 900, 1200, 1800]
    
    var selectedTime: Int {
        return seconds[pickerView.selectedRow(inComponent: 0)]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(timeStrs.count / 2, inComponent: 0, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension SetTimeCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeStrs.count
    }
}

extension SetTimeCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeStrs[row]
    }
}

