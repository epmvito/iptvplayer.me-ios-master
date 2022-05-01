import UIKit

class Radio4TableViewCell: UITableViewCell {
    
    typealias selectionCallBack = (_ selectedIndex: Int) -> Void
    
    var callBack: selectionCallBack?
    
    @IBOutlet weak var lb4Heared: UILabel!
    @IBOutlet weak var lb4Option1: UILabel!
    @IBOutlet weak var lb4Option2: UILabel!
    @IBOutlet weak var lb4Option3: UILabel!
    @IBOutlet weak var lb4Option4: UILabel!
    @IBOutlet weak var lb4Option5: UILabel!
    @IBOutlet weak var lb4Option6: UILabel!
    @IBOutlet weak var lb4Option7: UILabel!
    @IBOutlet weak var lb4Option8: UILabel!
    @IBOutlet weak var lb4Option9: UILabel!
    @IBOutlet weak var lb4Option10: UILabel!
    @IBOutlet weak var lb4Option11: UILabel!
    @IBOutlet weak var lb4Option12: UILabel!
    
    @IBOutlet weak var btn4Option1: UIButton!
    @IBOutlet weak var btn4Option2: UIButton!
    @IBOutlet weak var btn4Option3: UIButton!
    @IBOutlet weak var btn4Option4: UIButton!
    @IBOutlet weak var btn4Option5: UIButton!
    @IBOutlet weak var btn4Option6: UIButton!
    @IBOutlet weak var btn4Option7: UIButton!
    @IBOutlet weak var btn4Option8: UIButton!
    @IBOutlet weak var btn4Option9: UIButton!
    @IBOutlet weak var btn4Option10: UIButton!
    @IBOutlet weak var btn4Option11: UIButton!
    @IBOutlet weak var btn4Option12: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellHeaderWith(_ title: String){
        self.lb4Heared.text = title
    }
    
    func setOptionTitleForm(_ options: [String]){
        self.lb4Option1.text = options[0]
        self.lb4Option2.text = options[1]
        self.lb4Option3.text = options[2]
        self.lb4Option4.text = options[3]
        self.lb4Option5.text = options[4]
        self.lb4Option6.text = options[5]
        self.lb4Option7.text = options[6]
        self.lb4Option8.text = options[7]
        self.lb4Option9.text = options[8]
        self.lb4Option10.text = options[9]
        self.lb4Option11.text = options[10]
        self.lb4Option12.text = options[11]
    }
    
    func setOptionSelect(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = true
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect2(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = true
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect3(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = true
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect4(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = true
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect5(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = true
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect6(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = true
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect7(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = true
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect8(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = true
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect9(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = true
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect10(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = true
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect11(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = true
            self.btn4Option12.isSelected = false

        }
    }
    func setOptionSelect12(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn4Option1.isSelected = false
            self.btn4Option2.isSelected = false
            self.btn4Option3.isSelected = false
            self.btn4Option4.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option5.isSelected = false
            self.btn4Option6.isSelected = false
            self.btn4Option7.isSelected = false
            self.btn4Option8.isSelected = false
            self.btn4Option9.isSelected = false
            self.btn4Option10.isSelected = false
            self.btn4Option11.isSelected = false
            self.btn4Option12.isSelected = true
        }
    }
    
    @IBAction func option1Selected(_ sender: UIButton){
        setOptionSelect(true)
        self.callBack?(1)
    }
    
    @IBAction func option2Selected(_ sender: UIButton){
        setOptionSelect2(true)
        self.callBack?(2)
    }
    
    @IBAction func option3Selected(_ sender: UIButton){
        setOptionSelect3(true)
        self.callBack?(3)
    }
    
    @IBAction func option4Selected(_ sender: UIButton){
        setOptionSelect4(true)
        self.callBack?(4)
    }
    @IBAction func option5Selected(_ sender: UIButton){
        setOptionSelect5(true)
        self.callBack?(5)
    }
    @IBAction func option6Selected(_ sender: UIButton){
        setOptionSelect6(true)
        self.callBack?(6)
    }
    @IBAction func option7Selected(_ sender: UIButton){
        setOptionSelect7(true)
        self.callBack?(7)
    }
    @IBAction func option8Selected(_ sender: UIButton){
        setOptionSelect8(true)
        self.callBack?(8)
    }
    @IBAction func option9Selected(_ sender: UIButton){
        setOptionSelect9(true)
        self.callBack?(9)
    }
    @IBAction func option10Selected(_ sender: UIButton){
        setOptionSelect10(true)
        self.callBack?(10)
    }
    @IBAction func option11Selected(_ sender: UIButton){
        setOptionSelect11(true)
        self.callBack?(11)
    }
    @IBAction func option12Selected(_ sender: UIButton){
        setOptionSelect12(true)
        self.callBack?(12)
    }
    
    func cellSelectionHandler(callBack: @escaping selectionCallBack) {
        self.callBack = callBack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
