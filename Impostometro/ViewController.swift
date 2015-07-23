//
//  ViewController.swift
//  Impostometro
//
//  Created by Antony Alkmim on 15/07/15.
//  Copyright (c) 2015 Antony Alkmim. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import TSCurrencyTextField

class ViewController: UITableViewController {

    @IBOutlet weak var lblValorProduto: TSCurrencyTextField!
    @IBOutlet weak var lblValorFrete: TSCurrencyTextField!
    @IBOutlet weak var lblValorDolar: TSCurrencyTextField!
    @IBOutlet weak var tfTipoPessoa: UITextField!
    @IBOutlet weak var lblTipoPessoa: UILabel!
    
    var __tipoPessoa = 0; //0-Fisica|1-Juridica
    let TipoPessoa = ["Pessoa Física", "Pessoa Jurídica"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showPickerTipoPessoa(sender: UIButton) {
        
        ActionSheetStringPicker(title: "Tipo pessoa", rows: TipoPessoa, initialSelection: 0, doneBlock: {
            (picker, index, value) -> Void in
            self.lblTipoPessoa.text = self.TipoPessoa[index]
            self.__tipoPessoa = index
        }, cancelBlock: {
            (picker) -> Void in
            //calcel
        }, origin: self.view).showActionSheetPicker()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "MostrarImpostosCalculados"{
            var dtVC = segue.destinationViewController as? DetalhesViewController
                
            dtVC!.detalhes.valorMoeda = self.lblValorDolar.amount.floatValue
            dtVC!.detalhes.valorProduto = self.lblValorProduto.amount.floatValue
            dtVC!.detalhes.valorFrete = self.lblValorFrete.amount.floatValue
            dtVC!.detalhes.tipoPessoa = self.__tipoPessoa
        }
    }
    
}

