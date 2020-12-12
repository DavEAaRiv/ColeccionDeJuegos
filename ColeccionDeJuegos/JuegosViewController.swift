import UIKit
import CoreData

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    var imagePicker = UIImagePickerController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self;
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage;
        JuegoImageView.image = imagenSeleccionada;
        imagePicker.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary;
        present(imagePicker, animated: true, completion: nil);
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        let appDelegate =  (UIApplication.shared.delegate as! AppDelegate);
        let contexto = appDelegate.persistentContainer.viewContext;
        
        let juego = Juego(context: contexto);
        juego.titulo = tituloTextField.text;
        juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50);
        
        if (tituloTextField.text == "" || JuegoImageView.image === nil){
            print("Debe llenar todos los campos.");
        }else{
            appDelegate.saveContext();
            navigationController?.popViewController(animated: true);
        }
    }
}
