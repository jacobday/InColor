//
//  CanvasViewController.swift
//  InColor
//
//  Created by Evan Japundza on 4/15/22.
//
// Evan Japundza, evjapund - Eli Cohen, cohenelj - Jacob Day, day6 ---------- In Color ---------- 5/6/2022

import UIKit
import CoreData
import Photos
import PhotosUI

class CanvasViewController: UIViewController {
    @IBOutlet weak var canvasImageView: UIImageView!
    @IBOutlet weak var newCanvas: UIButton!
    @IBOutlet weak var saveCanvas: UIButton!
    @IBOutlet weak var uploadImage: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var counter = 0
    
    var appDelegate: AppDelegate?
    var drawingData: DrawingDataModel?
    
    var beginStroke: CGPoint = CGPoint.zero
    var endStroke: CGPoint = CGPoint.zero
    
    var backgroundColor: UIColor = .white
    var strokeColor: UIColor = .black
    var strokeWidth: CGFloat = 1.0
    
    @IBAction func clearCanvas(_ sender: Any) {
        self.canvasImageView.image = nil
        
        drawingData?.reset()
        strokeColor = .black
        strokeWidth = 1.0
        self.view.backgroundColor = .white
        self.backgroundImageView.image = nil
    }
    
    @IBAction func saveCanvas(_ sender: Any) {
        //changes the drawing to a png
        if let saveDrawing = self.canvasImageView.image?.pngData() {
            //calls saveImage
            CoreDataHelper.shareInstance.saveImage(data: saveDrawing)
        }
        counter += 1
    }
    
    func drawStroke(strokeStart: CGPoint, strokeEnd: CGPoint) {
        // Begin image context
        UIGraphicsBeginImageContext(view.frame.size)
        let currentContext = UIGraphicsGetCurrentContext()
        
        // Create path from strokeStart to strokeEnd
        currentContext?.move(to: strokeStart)
        currentContext?.addLine(to: strokeEnd)
        
        // Path properties
        currentContext?.setStrokeColor(strokeColor.cgColor)
        currentContext?.setLineWidth(strokeWidth)
        currentContext?.setLineCap(.round)
        
        // Paint line across path
        currentContext?.strokePath()
        
        // Draw image within view bounds
        canvasImageView.image?.draw(in: view.bounds)
        
        // Display context onto ImageView
        canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        // End image context
        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentTouch = touches.first?.location(in: view)
        
        // Store beginning touch position
        beginStroke = currentTouch ?? beginStroke
        
        // Draw a point at the beginStroke position
        drawStroke(strokeStart: beginStroke, strokeEnd: currentTouch ?? beginStroke)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentTouch = touches.first?.location(in: view)
        
        // Draw a line from beginStroke position to current touch's position
        drawStroke(strokeStart: beginStroke, strokeEnd: currentTouch ?? beginStroke)
        
        // Store current touch's position as beginStroke for next drawStroke() call
        beginStroke = currentTouch ?? beginStroke
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.drawingData = self.appDelegate?.drawingData
        
        strokeColor = drawingData?.getStrokeColor() ?? .black
        strokeWidth = drawingData?.getStrokeWidth() ?? 1.0
        
        //allow background image to be slightly transparent and center the view
        self.backgroundImageView.isOpaque = false
        self.backgroundImageView.alpha = 0.6
        self.backgroundImageView.center = self.view.center
        self.backgroundImageView.layer.zPosition = -1
        
        self.view.addSubview(self.backgroundImageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        strokeColor = drawingData?.getStrokeColor() ?? .black
        strokeWidth = drawingData?.getStrokeWidth() ?? 1.0
        backgroundColor = drawingData?.getBackgroundColor() ?? .white
        
        self.view.backgroundColor = backgroundColor
    }
    
    func loadImage() -> UIImage? {
        //create image manager
        let imageManager = PHImageManager.default()
        
        //gather all images selected into one object
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions())
        
        //create image
        var image: UIImage? = nil
        
        //choose random image by random integer
        let randomImage = (Int.random(in: 0..<fetchResult.count))
        
        //manager gets image from fetchResult
        imageManager.requestImage(for: fetchResult.object(at: randomImage), targetSize: CGSize(width: 500, height: 1200), contentMode: .aspectFill, options: requestOptions()) {
            
            img, err  in guard let img = img
            else {
                return
            }
            image = img
        }
        return image
    }
    
    func fetchOptions() -> PHFetchOptions {
        //function controls set of options that affect the filtering, sorting, and management of results that Photos returns when you fetch asset or collection objects
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOptions
    }
    
    
    func requestOptions() -> PHImageRequestOptions {
        //function controls how the actual image is presented to the view, in this case in high quality format
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        return requestOptions
    }
    
    //Request user for permission to access photos, calls actual load function
    func photoAuthorization() {
        // auth status
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            //call loadImage and set it to view
            backgroundImageView.image = loadImage()
            
        case .restricted, .denied:
            //if user denies access to photo gallery
            print("User declined access")
        case .notDetermined:
            //undetermined
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        self.backgroundImageView.image = self.loadImage()
                    }
                case .restricted, .denied:
                    print("Photo Auth restricted or denied")
                case .notDetermined: break
                case .limited: break
                    
                @unknown default: break
                    
                }
            }
        case .limited: break
            
        @unknown default:
            break
        }
    }
    
    //RANDOM BACKGROUND IMAGE BUTTON
    @IBAction func uploadImage(_ sender: Any) {
        photoAuthorization()
    }
}

class CoreDataHelper {
    //Lets this class's methods be used elsewhere
    static let shareInstance = CoreDataHelper()
    
    private var appDelegate: AppDelegate?
    private var drawingData: DrawingDataModel?
    
    //gets the information from Core Data to be edited
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImage(data: Data) {
        //gets the image and makes it type Image (Core Data entity)
        let imageInstance = Image(context: context)
        let bkgColor = drawingData?.getBackgroundColor()
        
        //sets the attribute img to data
        imageInstance.img = data
        imageInstance.bkgColor = bkgColor
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage() -> [Image] {
        //creates an array of type Image
        var fetchingImagesArray = [Image]()
        
        //does a fetch request for entities named "Image"
        let fetchRequester = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        
        do {
            //calls the fetch request and puts them in the array
            fetchingImagesArray = try context.fetch(fetchRequester) as! [Image]
        } catch {
            print("Error while fetching the image.")
        }
        return fetchingImagesArray
    }
}
