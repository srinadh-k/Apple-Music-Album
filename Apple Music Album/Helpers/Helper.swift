//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import Foundation
import  UIKit
enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
    
    var description : String {
        var msgDescription = Constants.Messages.kSomethingWentWrong
        switch self {
        case .custom(let msg):
            msgDescription = msg
        case .network(let msg):
            msgDescription = msg
        case .parser(let msg):
            msgDescription = msg
    
        }
        return msgDescription
    }
}

struct URLs {
    static let topAlbums = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
}
extension UIViewController {
    func showAlert(message : String, onOkAction: (()->())? = nil) {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                onOkAction?()
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        
    }
}
struct Constants{
    
    struct Messages {
        static let kInvalidUrlFormat = "Invalid url format"
        static let kInternetNotAvailable = "Internet not available, Please try with Internet connection"
        static let kSomethingWentWrong = "Something went wrong, Please try again later or contact to support team"
        static let kCannotOpen = "This music album link invalid or not able to open on this device."

    }
    struct Identifiers {
        static let kAlubmCell = "albumCell"
    }
    struct Asserts {
        static let kRightArrow = "Arrow"
        static let kPlaceHolder = "PlaceHolder"
    }
    struct ConstantValues {
        static let kEmpty = ""
        static let kTopAlbums = "Top Albums"
        static let kAlbumDetails = "Album Details"
        static let kAlbum = "Album: "
        static let kArtist = "Artist: "
        static let kGenre = "Genre: "
        static let kReleaseDate = "Release Date: "
        static let kCopyRights = "Copyrights: "
        static let kiTunesAlbum = "Album in iTunes"
        static let kNotAvailable = "N/A"

    }
}
extension UIColor{
    static let nikeTheme = UIColor(displayP3Red: 251.0/255.0, green: 239.0/255.0, blue: 81.0/255.0, alpha: 1.0)

}
extension UILabel {
    func wordTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: range)
        self.attributedText = attribute
    }
}
