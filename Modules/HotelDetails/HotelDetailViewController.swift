//
//  HotelDetailViewController.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

import MapKit

final class HotelDetailViewController: UIViewController, MKMapViewDelegate {
    
    private lazy var activityIndicator = UIActivityIndicatorView()
    private lazy var containerView = UIView(cornerRadius: .radius)
    private lazy var mapKit = MKMapView()
    
    private lazy var hotelImage = UIImageView.hotelImage()
    private lazy var nameLabel = UILabel(font: .avenirMedium16())
    private lazy var addressLabel = UILabel(font: .avenir14())
    private lazy var starsLabel = UILabel(font: .avenir14())
    private lazy var distanceLabel = UILabel(font: .avenir14())
    private lazy var suitesAvailability = UILabel(font: .avenir14())
    
    var viewModel: HotelDetailViewModelProtocol? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.fetchHotels { [weak self] error in
                self?.showAlertError(withError: error)
            } successCompletion: { [weak self] in
                self?.setupViewModel()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupActivityIndicator()
        setupMapKit()
        setupConstraints()
    }
    
    private func setupViewModel() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
        starsLabel.text = viewModel.stars
        distanceLabel.text = viewModel.distance
        suitesAvailability.text = viewModel.suites_availability
        
        viewModel.fetchImage(id: viewModel.image) { [weak self] data in
            guard let self = self else { return }
            self.convertImage(data: data, to: self.hotelImage)
            self.activityIndicator.stopAnimating()
        }
        
        hotelLocation(location: viewModel.location,
                      title: viewModel.name,
                      locationName: viewModel.address)
    }
    
    private func setupMapKit() {
        mapKit.layer.cornerRadius = .radius
        mapKit.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    private func convertImage(data: Data, to convert: UIImageView) {
        if let image = UIImage(data: data) {
            convert.image = cropImage(input: image)
            convert.contentMode = .scaleAspectFill
        } else {
            convert.image = UIImage(named: "MookImage")
        }
    }
    
    private func cropImage(input image: UIImage) -> UIImage? {
        let imageRef = image.cgImage
        
        let CGImage = imageRef?.cropping(to: CGRect(
            x: .offsetX, y: .offsetY,
            width: image.size.width - .cropWith,
            height: image.size.height - .cropHeight))
        return UIImage(cgImage: CGImage!)
    }
    
    private func hotelLocation(location: CLLocationCoordinate2D, title: String?, locationName: String?) {
        let coordinate = MKCoordinateRegion(center: location,
                                            latitudinalMeters: .latZoomMap,
                                            longitudinalMeters: .lonZoomMap)
        
        let annotation = MapKitPlaces(title: title,
                                      locationName: locationName,
                                      coordinate: location)
        mapKit.setRegion(coordinate, animated: true)
        mapKit.addAnnotation(annotation)
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                       addressLabel,
                                                       starsLabel,
                                                       distanceLabel,
                                                       suitesAvailability],
                                    axis: .vertical,
                                    spacing: .smallOffSet)
        
        view.addSubview(hotelImage)
        hotelImage.addSubview(activityIndicator)
        view.addSubview(containerView)
        view.addSubview(stackView)
        view.addSubview(mapKit)
        
        NSLayoutConstraint.activate([
            hotelImage.topAnchor.constraint(equalTo: view.topAnchor, constant: .offset),
            hotelImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .offset),
            hotelImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .inset),
            hotelImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: .heightMultiplier),
            
            containerView.topAnchor.constraint(equalTo: hotelImage.bottomAnchor, constant: .offset),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .offset),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .inset),
            containerView.bottomAnchor.constraint(equalTo: mapKit.topAnchor, constant: .inset),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .stackOffset),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .stackOffset),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: .stackInset),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: .stackInset),
            
            mapKit.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mapKit.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            mapKit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: .inset),
            mapKit.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: .heightMultiplier),
            
            activityIndicator.centerXAnchor.constraint(equalTo: hotelImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: hotelImage.centerYAnchor)
        ])
    }
    
    private func showAlertError(withError error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default))
        present(alertController, animated: true)
    }
}
