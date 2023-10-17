//
//  DetailVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 17.10.23.
//

import UIKit
import MapKit

class DetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNamelbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var adressLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func mapAction() {
        guard let user = user,
              let latitudeString = user.address?.geo?.lat,
              let longitudeString = user.address?.geo?.lng,
              let latitude = Double(latitudeString),
              let longitude = Double(longitudeString)
        else { return }
     let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "MapVC") as? MapVC else { return }
        vc.coordinate = coordinate
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func postsAtion() {
        let sb = UIStoryboard(name: "PostFlow", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "PostsTVC") as? PostsTVC else { return }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func albumsAction() {
        let sb = UIStoryboard(name: "AlbomsAndPhotosFlow", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "AlbumsTVC") as? AlbumsTVC else { return }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func todosAction() {
        //let sb = UIStoryboard(name: "Main", bundle: nil)
//        guard let vc = sb.instantiateViewController(withIdentifier: "MapVC") as? MapVC else { return }
     //   vc.user = user

//        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        guard let user = user else { return }
        nameLbl.text = user.name
        userNamelbl.text = user.username
        emailLbl.text = user.email
        phoneLbl.text = user.phone
        websiteLbl.text = user.website
        if let city = user.address?.city,
           let street = user.address?.street,
           let suite = user.address?.suite,
           let zipcode = user.address?.zipcode {
            adressLbl.text = "\(city)\n\(street)\n\(suite)\n\(zipcode)"
        } else {
            adressLbl.text = "Unknown"
        }
        if let companyName = user.company?.name,
           let catchPhrase = user.company?.catchPhrase,
           let bs = user.company?.bs {
            companyLbl.text = "\(companyName)\n \n\(catchPhrase)\n\(bs)"
        } else {
            companyLbl.text = "Unknown"
        }
    }
}
