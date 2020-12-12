import UIKit
import CoreData

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var agregarActualizacionBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    
    var imagePicker = UIImagePickerController();
    var juego:Juego? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self;
        if juego != nil{
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data);
            tituloTextField.text = juego!.titulo;
            agregarActualizacionBoton.setTitle("Actualizar", for: .normal);
        }
        else{
            eliminarBoton.isHidden = true;
        }
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
        imagePicker.sourceType = .camera;
        present(imagePicker, animated: true, completion: nil);
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        let appDelegate =  (UIApplication.shared.delegate as! AppDelegate);
        let contexto = appDelegate.persistentContainer.viewContext;
        
        if (tituloTextField.text == "" || JuegoImageView.image === nil){
            print("Debe llenar todos los campos.");
        }else{
            if juego != nil {
                juego!.titulo! = tituloTextField.text!;
                juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50);
            }else{
                let juego = Juego(context: contexto);
                juego.titulo = tituloTextField.text;
                juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50);
            }
            appDelegate.saveContext();
            navigationController?.popViewController(animated: true);
        }
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let appDelegate =  (UIApplication.shared.delegate as! AppDelegate);
        let contexto = appDelegate.persistentContainer.viewContext;
        
        contexto.delete(juego!);
        appDelegate.saveContext();
        navigationController?.popViewController(animated: true);
    }
}
