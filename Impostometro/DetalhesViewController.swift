//
//  DetalhesViewController.swift
//  Impostometro
//
//  Created by Antony Alkmim on 15/07/15.
//  Copyright (c) 2015 Antony Alkmim. All rights reserved.
//

import UIKit

class DetalhesViewController: UITableViewController {
    
    var detalhes = (
        valorMoeda : Float(0.0),
        valorProduto : Float(0.0),
        valorFrete : Float(0.0),
        tipoPessoa : Int(0),
        taxaImportacao : Float(0.0),
        taxaCorreios : Float(0.0),
        total : Float(0.0)
    )
    
    
    @IBOutlet weak var lblValorMoeda:UILabel!
    @IBOutlet weak var lblValorProduto:UILabel!
    @IBOutlet weak var lblValorFrete:UILabel!
    @IBOutlet weak var lblTaxaImportacao:UILabel!
    @IBOutlet weak var lblTaxaCorreios:UILabel!
    @IBOutlet weak var lblValorTotal:UILabel!
    @IBOutlet weak var lblTipoRemetente: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calcularTaxas()
        
        self.lblValorMoeda.text = detalhes.valorMoeda.moneyFormat()
        self.lblValorProduto.text = detalhes.valorProduto.moneyFormat()
        self.lblValorFrete.text = detalhes.valorFrete.moneyFormat()
        
        self.lblTaxaImportacao.text = detalhes.taxaImportacao.moneyFormat()
        self.lblTaxaCorreios.text = detalhes.taxaCorreios.moneyFormat()
        self.lblValorTotal.text = detalhes.total.moneyFormat()
        self.lblTipoRemetente.text = self.detalhes.tipoPessoa == 1 ? "Pessoa Jurídica" : "Pessoa Física"
    }
    
    
    
    func calcularTaxas() -> Void {
        //converter $->R$
        self.detalhes.valorProduto = (detalhes.valorMoeda * detalhes.valorProduto) //converter $ -> R$
        self.detalhes.valorFrete = (detalhes.valorFrete * detalhes.valorMoeda) //converter $ -> R$
        
        self.detalhes.total = self.detalhes.valorFrete + self.detalhes.valorProduto;
        
        //calcular taxa importacao
        if self.detalhes.total > 50 || self.detalhes.tipoPessoa == 1 {
            self.detalhes.taxaImportacao = self.detalhes.total * 0.6
        }
        
        self.detalhes.total += self.detalhes.taxaImportacao
        
        //calcula taxa correios
        self.detalhes.taxaCorreios = self.detalhes.valorProduto > 50 ? 12 : 0
        
        self.detalhes.total += self.detalhes.taxaCorreios
    }
    
    func moneyFormat(number:Float) -> String! {
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(NSNumber(float: number))
    }
    
}

extension Float{
    func moneyFormat() -> String! {
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.usesGroupingSeparator = true
        return formatter.stringFromNumber(NSNumber(float: self))
    }
}
