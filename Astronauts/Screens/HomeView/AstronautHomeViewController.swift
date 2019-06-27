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
        addCollectionViewBackground()
        getPeopleInSpace()
    }
    
    func getPeopleInSpace() {
        RequestManager.getCurrentPeople { (peoples) in
            DispatchQueue.main.async {
                switch peoples.result.status {
                    
                case .success:
                    self.astronauts = peoples.peoples
                    self.collectionView.reloadData()
                case .fail:
                    print("failed")
                }
            }
        }
    }
    
    private func addCollectionViewBackground() {
        let gView = UIView(frame: collectionView.frame)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
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
        switch cellType {

        case .peopleCell:
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentPeopleViewController") as? CurrentPeopleViewController
            viewController?.astronauts = self.astronauts
            present(viewController!, animated: true, completion: nil)
        case .passTime:
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentLocationViewController") as? CurrentLocationViewController
            present(viewController!, animated: true, completion: nil)
        case .currentLocation:
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PassTimesViewController") as? PassTimesViewController
            present(viewController!, animated: true, completion: nil)
        }
    }
}
