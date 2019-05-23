//
//  RegisterViewController.swift
//  Snapchat
//
//  Created by Tecsup on 23/05/19.
//  Copyright © 2019 Glenda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var userTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func RegisterHandler(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.userTxt.text!, password: self.passwordTxt.text!, completion: { (user, error) in
            print("Intentando crear usuario")
            if error != nil{
                print("Se presento el siguiente error al intentar crear un usuario: \(error)")
                let alerta = UIAlertController(title: "Error", message: "Se presento el siguiente error al intentar crear un usuario: \(error)", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
            }else{
                print("El usuario fue creado Exitosamente")
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                
                let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.userTxt.text!) se creo correctamente!", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Iniciar Sesion", style: .default, handler: { (UIAlertAction) in
                    
                    self.performSegue(withIdentifier: "volverlogin", sender: nil)
                })
                
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
            }
        })
    }
    

}
