//
//  Radio2TableViewCell.swift
//  iptvplayer.me-ios
//
//  Created by Ilya Egorov on 18.04.2022.
//  Copyright © 2022 Никита. All rights reserved.
//

import UIKit

class Radio2TableViewCell: UITableViewCell {
    
    typealias selectionCallBack = (_ selectedIndex: Int) -> Void
    
    var callBack: selectionCallBack?
    
    @IBOutlet weak var lb2Heared: UILabel!
    @IBOutlet weak var lb2Option1: UILabel!
    @IBOutlet weak var lb2Option2: UILabel!
    @IBOutlet weak var lb2Option3: UILabel!
    @IBOutlet weak var lb2Option4: UILabel!
    
    @IBOutlet weak var btn2Option1: UIButton!
    @IBOutlet weak var btn2Option2: UIButton!
    @IBOutlet weak var btn2Option3: UIButton!
    @IBOutlet weak var btn2Option4: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellHeaderWith(_ title: String){
        self.lb2Heared.text = title
    }
    
    func setOptionTitleForm(_ options: [String]){
        self.lb2Option1.text = options[0]
        self.lb2Option2.text = options[1]
        self.lb2Option3.text = options[2]
        self.lb2Option4.text = options[3]
    }
    
    func setOptionSelect(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btn2Option1.isSelected = true
            self.btn2Option2.isSelected = false
            self.btn2Option3.isSelected = false
            self.btn2Option4.isSelected = false
        }else {
            self.btn2Option1.isSelected = false
            self.btn2Option2.isSelected = true
            self.btn2Option3.isSelected = false
            self.btn2Option4.isSelected = false
        }
    }
    
    func setOptionSelect2(_ isOption2seleced: Bool){
        if isOption2seleced{
            self.btn2Option1.isSelected = false
            self.btn2Option2.isSelected = false
            self.btn2Option3.isSelected = true
            self.btn2Option4.isSelected = false
        } else {
            self.btn2Option1.isSelected = false
            self.btn2Option2.isSelected = false
            self.btn2Option3.isSelected = false
            self.btn2Option4.isSelected = true
        }
    }
    
    @IBAction func option1Selected(_ sender: UIButton){
        setOptionSelect(true)
        self.callBack?(1)
    }
    
    @IBAction func option2Selected(_ sender: UIButton){
        setOptionSelect(false)
        self.callBack?(2)
    }
    
    @IBAction func option3Selected(_ sender: UIButton){
        setOptionSelect(false)
        setOptionSelect2(true)
        self.callBack?(3)
    }
    
    @IBAction func option4Selected(_ sender: UIButton){
        setOptionSelect(true)
        setOptionSelect2(false)
        self.callBack?(4)
    }
    
    func cellSelectionHandler(callBack: @escaping selectionCallBack) {
        self.callBack = callBack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
