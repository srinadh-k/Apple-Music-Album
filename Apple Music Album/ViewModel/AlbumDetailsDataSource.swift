//
//  AlbumDetailsViewModel.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/3/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import Foundation
import UIKit
class AlbumDetailsDataSource  {
    private var scrollView = UIScrollView()
    private var safeArea = UILayoutGuide()

    private let kTen:CGFloat = 10.0
    private let kNegTen:CGFloat = -10.0
    private let kTwenty:CGFloat = 20.0
    private let kNegTwenty:CGFloat = -20.0
    private let kFifty:CGFloat = 50.0
    private var contentView = UIView()

    private var detailsvc : AlbumDetailsVC
    private var albumData : Album
    
    var redirectToMusicAlbum: ((URL) -> Void)?
    var onErrorHandling: ((String) -> Void)?

    
    private let albumNameLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let genreLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseDateLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let copyrightsLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let itunesBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(Constants.ConstantValues.kiTunesAlbum, for: .normal)
        btn.backgroundColor = .nikeTheme
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private let albumImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.contentMode = .scaleAspectFit
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    init(detailVC : AlbumDetailsVC, albumData: Album) {
        self.detailsvc = detailVC
        self.albumData = albumData
        safeArea = detailVC.view.layoutMarginsGuide
        self.setupViewDesign()
    }
    
    private func setupViewDesign() {
        contentView.backgroundColor = .white
        
        detailsvc.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: detailsvc.view.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: detailsvc.view.widthAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: detailsvc.view.bottomAnchor).isActive = true

        scrollView = UIScrollView(frame: .zero)

        scrollView.sizeToFit()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(scrollView)
        
        
        self.scrollView.addSubview(albumImageView)
        self.scrollView.addSubview(albumNameLbl)
        self.scrollView.addSubview(artistNameLbl)
        self.scrollView.addSubview(genreLbl)
        self.scrollView.addSubview(releaseDateLbl)
        self.scrollView.addSubview(copyrightsLbl)
        
        self.contentView.addSubview(itunesBtn)
        
        itunesBtn.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: kTwenty).isActive = true
        itunesBtn.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: kNegTwenty).isActive = true
        itunesBtn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: kNegTwenty).isActive = true
        itunesBtn.heightAnchor.constraint(equalToConstant: kFifty).isActive = true
        
        itunesBtn.addTarget(self, action: #selector(iTunesBtnClicked), for: .touchUpInside)
        
        scrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: itunesBtn.topAnchor, constant: kNegTwenty).isActive = true
        
        albumImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        albumImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: kTen).isActive = true
        albumImageView.widthAnchor.constraint(equalTo: detailsvc.view.widthAnchor).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: detailsvc.view.frame.size.width/2).isActive = true

        self.addLabelToScrollVW(lbl: albumNameLbl, topConstrnt: albumImageView.bottomAnchor, bottomCnstrnt: nil)
        self.addLabelToScrollVW(lbl: artistNameLbl, topConstrnt: albumNameLbl.bottomAnchor, bottomCnstrnt: nil)
        self.addLabelToScrollVW(lbl: genreLbl, topConstrnt: artistNameLbl.bottomAnchor, bottomCnstrnt: nil)
        self.addLabelToScrollVW(lbl: releaseDateLbl, topConstrnt: genreLbl.bottomAnchor, bottomCnstrnt: nil)
        self.addLabelToScrollVW(lbl: copyrightsLbl, topConstrnt: releaseDateLbl.bottomAnchor, bottomCnstrnt: scrollView.bottomAnchor)
    }
    
    private func addLabelToScrollVW(lbl:UILabel,topConstrnt:NSLayoutYAxisAnchor, bottomCnstrnt:NSLayoutYAxisAnchor?){
        lbl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: kTen).isActive = true
        lbl.widthAnchor.constraint(equalTo: detailsvc.view.widthAnchor, constant: kNegTwenty).isActive = true
        lbl.topAnchor.constraint(equalTo: topConstrnt, constant: kTwenty).isActive = true
        if let bottomCnstrnt = bottomCnstrnt{
            lbl.bottomAnchor.constraint(equalTo: bottomCnstrnt, constant: kNegTen).isActive = true
        }
    }
    
    @objc private func iTunesBtnClicked(sender : UIButton){
           if let album = albumData.artistUrl, let url = URL(string: album){
               if UIApplication.shared.canOpenURL(url) {
                   redirectToMusicAlbum?(url)
                   return
               }
           }
            onErrorHandling?(Constants.Messages.kCannotOpen)

       }
    
    func loadAlbumDetails(){
            albumImageView.image = UIImage(named: Constants.Asserts.kPlaceHolder)
            if let artWorkImgLink = albumData.artworkUrl, !artWorkImgLink.isEmpty{
                ImageCacheRepository.shared.loadImage(url: artWorkImgLink) { [weak self] data in
                    if let data = data{
                        self?.albumImageView.image = UIImage(data: data)
                    }
                }
            }
            
          
            albumNameLbl.wordTextColorChange(fullText: Constants.ConstantValues.kAlbum + (albumData.name ?? Constants.ConstantValues.kNotAvailable), changeText: Constants.ConstantValues.kAlbum)
            
                artistNameLbl.wordTextColorChange(fullText: Constants.ConstantValues.kArtist + (albumData.artistName ?? Constants.ConstantValues.kNotAvailable), changeText: Constants.ConstantValues.kArtist)
            
            if let genres = albumData.genres, !genres.isEmpty{
               let genresResult = (genres.compactMap{$0.name}).joined(separator: ", ")
                genreLbl.wordTextColorChange(fullText: Constants.ConstantValues.kGenre + genresResult, changeText: Constants.ConstantValues.kGenre)
            }
            else{
                genreLbl.wordTextColorChange(fullText: Constants.ConstantValues.kGenre + Constants.ConstantValues.kNotAvailable, changeText: Constants.ConstantValues.kGenre)

            }
            releaseDateLbl.wordTextColorChange(fullText: Constants.ConstantValues.kReleaseDate + (albumData.releaseDate ?? Constants.ConstantValues.kNotAvailable), changeText: Constants.ConstantValues.kReleaseDate)

                copyrightsLbl.wordTextColorChange(fullText: Constants.ConstantValues.kCopyRights + (albumData.copyright ?? Constants.ConstantValues.kNotAvailable), changeText: Constants.ConstantValues.kCopyRights)
            
            
        
    }
}
