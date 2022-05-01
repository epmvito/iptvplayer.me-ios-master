import UIKit

class Radio3TableViewCell: UITableViewCell {
    
    typealias selectionCallBack = (_ selectedIndex: Int) -> Void
    
    var callBack: selectionCallBack?
    
    @IBOutlet weak var lb3Heared: UILabel!
    @IBOutlet weak var lb3Option1: UILabel!
    @IBOutlet weak var lb3Option2: UILabel!
    @IBOutlet weak var lb3Option3: UILabel!
    @IBOutlet weak var lb3Option4: UILabel!
    @IBOutlet weak var lb3Option5: UILabel!
    
    @IBOutlet weak var btn3Option1: UIButton!
    @IBOutlet weak var btn3Option2: UIButton!
    @IBOutlet weak var btn3Option3: UIButton!
    @IBOutlet weak var btn3Option4: UIButton!
    @IBOutlet weak var btn3Option5: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellHeaderWith(_ title: String){
        self.lb3Heared.text = title
    }
    
    func setOptionTitleForm(_ options: [String]){
        self.lb3Option1.text = options[0]
        self.lb3Option2.text = options[1]
        self.lb3Option3.text = options[2]
        self.lb3Option4.text = options[3]
        self.lb3Option5.text = options[4]
    }
    
    func setOptionSelect(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn3Option1.isSelected = true
            self.btn3Option2.isSelected = false
            self.btn3Option3.isSelected = false
            self.btn3Option4.isSelected = false
            self.btn3Option5.isSelected = false
        }
    }
    
    func setOptionSelect2(_ isOption2seleced: Bool){
        if isOption2seleced{
            self.btn3Option1.isSelected = false
            self.btn3Option2.isSelected = true
            self.btn3Option3.isSelected = false
            self.btn3Option4.isSelected = false
            self.btn3Option5.isSelected = false
        }
    }
    func setOptionSelect3(_ isOption2seleced: Bool){
        if isOption2seleced{
            self.btn3Option1.isSelected = false
            self.btn3Option2.isSelected = false
            self.btn3Option3.isSelected = true
            self.btn3Option4.isSelected = false
            self.btn3Option5.isSelected = false
        }
    }
    func setOptionSelect4(_ isOption2seleced: Bool){
        if isOption2seleced{
            self.btn3Option1.isSelected = false
            self.btn3Option2.isSelected = false
            self.btn3Option3.isSelected = false
            self.btn3Option4.isSelected = true
            self.btn3Option5.isSelected = false
        }
    }
    func setOptionSelect5(_ isOption2seleced: Bool){
        if isOption2seleced{
            self.btn3Option1.isSelected = false
            self.btn3Option2.isSelected = false
            self.btn3Option3.isSelected = false
            self.btn3Option4.isSelected = false
            self.btn3Option5.isSelected = true
        }
    }
    
    
    @IBAction func option1Selected(_ sender: UIButton){
        setOptionSelect(true)
        //setOptionSelect2(false)
        self.callBack?(1)
    }
    
    @IBAction func option2Selected(_ sender: UIButton){
        //setOptionSelect(false)
        setOptionSelect2(true)
        self.callBack?(2)
    }
    
    @IBAction func option3Selected(_ sender: UIButton){
        setOptionSelect3(true)
//        setOptionSelect2(true)
        self.callBack?(3)
    }
    
    @IBAction func option4Selected(_ sender: UIButton){
        setOptionSelect4(true)
//        setOptionSelect2(false)
        self.callBack?(4)
    }
    @IBAction func option5Selected(_ sender: UIButton){
        setOptionSelect5(true)
//        setOptionSelect2(false)
        self.callBack?(4)
    }
    
    func cellSelectionHandler(callBack: @escaping selectionCallBack) {
        self.callBack = callBack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
