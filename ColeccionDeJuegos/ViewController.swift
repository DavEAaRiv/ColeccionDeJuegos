import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableVie: UITableView!
    var juegos: [Juego] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableVie.dataSource = self;
        tableVie.delegate = self;
    }

    override func viewWillAppear(_ animated: Bool) {
        let appDel = (UIApplication.shared.delegate as! AppDelegate);
        let contexto = appDel.persistentContainer.viewContext;
        
        do{
            try juegos = contexto.fetch(Juego.fetchRequest());
            tableVie.reloadData();
        }
        catch{
            print("Error al cargar lista...");
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell();
        let juego = juegos[indexPath.row];
        cell.textLabel?.text = juego.titulo;
        cell.imageView?.image = UIImage(data: (juego.imagen!));
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juego = juegos[indexPath.row];
        performSegue(withIdentifier: "juegoSegue", sender: juego);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! JuegosViewController;
        siguienteVC.juego = sender as? Juego;
        
    }
}

