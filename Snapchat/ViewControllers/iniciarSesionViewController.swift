//
//  ViewController.swift
//  Snapchat
//
//  Created by Tecsup on 9/05/19.
//  Copyright © 2019 Glenda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class iniciarSesionViewController: UIViewController, LoginButtonDelegate{
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error == nil {
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("logueadooooo")
        }else{
            print((error?.localizedDescription))
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("usuario salio =)")
    }
    

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var butt: FBLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        butt.delegate = self
        butt.readPermissions = ["email"]
    }
    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text! , password: passwordTextField.text!) { (user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
                let alerta = UIAlertController(title: "Usuario no existe", message: "El Usuario: \(self.emailTextField.text!) no existe :( , CREALO!", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Registrar", style: .default, handler: { (UIAlertAction) in
                    
                    self.performSegue(withIdentifier: "segueRegister", sender: nil)
                })
                let btnCancel = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
                
                alerta.addAction(btnOK)
                alerta.addAction(btnCancel)
                self.present(alerta, animated: true, completion: nil)

            }else{
                print("Inicio de Sesion exitoso!")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    
    @IBAction func IniciarSesionFacebookTapped(_ sender: Any) {
        
    }
}

