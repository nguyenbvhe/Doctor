//
//  DoctorTableViewCell.swift
//  BSGNProject
//
//  Created by Linh Thai on 21/08/2024.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {
    
    @IBOutlet var doctorCollectionView: UICollectionView!
    var doctors = [DoctorList]()
    var homeData: HomeData?
    var doctorViewModel: DoctorViewModel?
    let homeService = HomeService()
    var numberOfDoctors = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
        fetchData()
    }
    
    // MARK: - Setup CollectionView
    private func setupCollectionView() {
        doctorCollectionView.delegate = self
        doctorCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        doctorCollectionView.collectionViewLayout = layout
        doctorCollectionView.register(UINib(nibName: "DoctorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DoctorCollectionViewCell")
    }
    
    // MARK: - Fetch Data
    func fetchData() {
        NewsService.fetchNews { result in
            switch result {
            case .success(let data):
                self.doctors = data.doctorList
                if self.doctorViewModel == nil {
                    self.doctorViewModel = DoctorViewModel()
                }
                self.homeData = data
                self.doctorViewModel?.doctors = data.doctorList
                self.numberOfDoctors = data.doctorList.count
                self.updateUI()
            case .failure(let error):
                print("Error fetching doctors: \(error)")
            }
        }
    }
    
    // MARK: - Update UI
    func updateUI() {
        DispatchQueue.main.async {
            self.doctorCollectionView.reloadData()
        }
    }
    
    // MARK: - Helper Method to Apply Shadow
    private func applyShadow(to cell: UICollectionViewCell) {
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
    }
}

// MARK: - UICollectionViewDataSource
extension DoctorTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDoctors
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorCollectionViewCell", for: indexPath) as? DoctorCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let doctor = doctorViewModel?.doctors[indexPath.row] {
            cell.configure(with: doctor)
            cell.doctorNameLabel.text = doctor.fullName
            cell.majorNameLabel.text = doctor.majorsName
            cell.reviewerCountLabel.text = "\(doctor.numberOfReviews)"
            cell.starLabel.text = "\(doctor.ratioStar)"
        }
        
        // Bo góc và tạo màu khung
        cell.layer.cornerRadius = 12  // Bo góc
        cell.layer.borderWidth = 2    // Độ rộng của khung
        cell.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.3).cgColor  // Màu của khung
        
        // Áp dụng bóng cho cell (nếu cần)
     //   applyShadow(to: cell)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DoctorTableViewCell: UICollectionViewDelegate {
    // Bạn có thể thêm các hành động khi người dùng tương tác với cell tại đây nếu cần
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DoctorTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 121, height: 185)  // Điều chỉnh kích thước cell nếu cần
    }
}
