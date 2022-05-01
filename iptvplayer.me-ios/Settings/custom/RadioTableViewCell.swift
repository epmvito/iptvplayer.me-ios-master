//
//  RadioTableViewCell.swift
//  iptvplayer.me-ios
//
//  Created by Ilya Egorov on 18.04.2022.
//  Copyright © 2022 Никита. All rights reserved.
//

import UIKit

class RadioTableViewCell: UITableViewCell {
    
    typealias selectionCallBack = (_ selectedIndex: Int) -> Void
    
    var callBack: selectionCallBack?
    
    @IBOutlet weak var lbHeared: UILabel!
    @IBOutlet weak var lbOption1: UILabel!
    @IBOutlet weak var lbOption2: UILabel!
    @IBOutlet weak var lbOption3: UILabel!
    
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellHeaderWith(_ title: String){
        self.lbHeared.text = title
    }
    
    func setOptionTitleForm(_ options: [String]){
        self.lbOption1.text = options[0]
        self.lbOption2.text = options[1]
        self.lbOption3.text = options[2]
    }
    
    func setOptionSelect(_ isOption1seleced: Bool){
        if isOption1seleced{
            self.btnOption1.isSelected = true
            self.btnOption2.isSelected = false
            self.btnOption3.isSelected = false
        }else {
            self.btnOption1.isSelected = false
            self.btnOption2.isSelected = true
            self.btnOption3.isSelected = false
        }
    }
    
    func setOptionSelect2(_ isOption2seleced: Bool){
        if isOption2seleced{
            self.btnOption1.isSelected = true
            self.btnOption2.isSelected = false
            self.btnOption3.isSelected = false
        } else {
            self.btnOption1.isSelected = false
            self.btnOption2.isSelected = false
            self.btnOption3.isSelected = true
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
        setOptionSelect2(false)
        self.callBack?(3)
    }
    
    func cellSelectionHandler(callBack: @escaping selectionCallBack) {
        self.callBack = callBack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
