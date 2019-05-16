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
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("Intentando crear usuario")
                    if error != nil{
                        print("Se presento el siguiente error al intentar crear un usuario: \(error)")
                    }else{
                        print("El usuario fue creado Exitosamente")
                        Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                        
                        let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.emailTextField.text!) se creo correctamente", preferredStyle: .alert)
                         let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
                            self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                         })
                        
                        alerta.addAction(btnOK)
                        self.present(alerta, animated: true, completion: nil)
                    }
                })
            }else{
                print("Inicio de Sesion exitoso!")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    
    @IBAction func IniciarSesionFacebookTapped(_ sender: Any) {
        
    }
}

