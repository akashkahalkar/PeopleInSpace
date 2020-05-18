//
//  AstronautHomeViewController.swift
//  astronauts
//
//  Created by Akash kahalkar on 21/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class AstronautHomeViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var astronauts = [Astronaut]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPeopleInSpace()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addCollectionViewBackground()
    }
    
    private func getPeopleInSpace() {
        RequestManager.getCurrentPeople {[weak self] (peoples) in
            
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch peoples.result.status {
                    
                case .success:
                    self.astronauts = peoples.peoples
                    self.collectionView.reloadData()
                case .fail:
                    let errorMsg = peoples.result.message ?? "Error while fetching data"
                    let alert = UIAlertController.init(title: "Error",
                                                       message: errorMsg,
                                                       preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
                        guard let self = self else { return }
                        self.getPeopleInSpace()
                    })
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func addCollectionViewBackground() {
        
        let gView = UIView(frame: view.frame)
        let gradientLayer = CAGradientLayer()
        let colors = FlatColors.DIMIGO.colors()
        
        gradientLayer.colors = [colors[3].cgColor, colors[0].cgColor]
        gradientLayer.frame = gView.frame
        gView.layer.addSublayer(gradientLayer)
        collectionView.backgroundView = gView
    }
}

extension AstronautHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell)!
        let cellType = CollectionsCellType(rawValue: indexPath.row)!
        cell.setupCell(buttonTitle: "SHOW",
                       tag: indexPath.row,
                       image: cellType.image()!,
                       peopleCount: astronauts.count)
        cell.tapEvent = { tag in
            self.pushScreens(for: CollectionsCellType(rawValue: tag)!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? HomeCollectionViewCell {
            cell.colorTheCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height - 50)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let cells = collectionView.visibleCells
        if let cell = cells.first, let indexPath = collectionView.indexPath(for: cell) {
            pageControl.currentPage = indexPath.row
        }
    }
    
    private func pushScreens(for cellType: CollectionsCellType) {
        
        var viewControllerToPresent: UIViewController?
        
        switch cellType {
        
        case .peopleCell:
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentPeopleViewController") as? CurrentPeopleViewController
            viewController?.astronauts = self.astronauts
            viewControllerToPresent = viewController
        case .passTime:
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentLocationViewController") as? CurrentLocationViewController
            viewControllerToPresent = viewController
        case .currentLocation:
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PassTimesViewController") as? PassTimesViewController
            viewControllerToPresent = viewController
        }
        
        guard let viewController = viewControllerToPresent else { return }
        present(viewController, animated: true, completion: nil)
    }
}

