//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    let albumImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    let albumNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailImageView:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: Constants.Asserts.kRightArrow)
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    var album : Album? {
        didSet {
            
            guard let album =  album else {
                return
            }
            artistNameLabel.text = album.artistName ?? Constants.ConstantValues.kEmpty
            albumNameLabel.text = album.name ?? Constants.ConstantValues.kEmpty
            albumImageView.image = UIImage(named: Constants.Asserts.kPlaceHolder)
            if let artWorkImgLink = album.artworkUrl, !artWorkImgLink.isEmpty{
                ImageCacheRepository.shared.loadImage(url: artWorkImgLink) { [weak self] data in
                    if let data = data{
                        self?.albumImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(albumImageView)
        self.contentView.addSubview(albumNameLabel)
        self.contentView.addSubview(artistNameLabel)
        self.contentView.addSubview(detailImageView)
        
        albumImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        albumImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        
        detailImageView.widthAnchor.constraint(equalToConstant:25).isActive = true
        detailImageView.heightAnchor.constraint(equalToConstant:25).isActive = true
        detailImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -10).isActive = true
        detailImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        
        albumNameLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 15).isActive = true
        albumNameLabel.leadingAnchor.constraint(equalTo:self.albumImageView.trailingAnchor, constant:10).isActive = true
        albumNameLabel.trailingAnchor.constraint(equalTo:self.detailImageView.leadingAnchor).isActive = true
        
        artistNameLabel.topAnchor.constraint(equalTo:self.albumNameLabel.bottomAnchor, constant: 5).isActive = true
        artistNameLabel.leadingAnchor.constraint(equalTo:self.albumImageView.trailingAnchor, constant:10).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo:self.detailImageView.leadingAnchor).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}

class ImageTVCell: UITableViewCell {
    
    
    let albumImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        //img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(albumImageView)
        
        
        albumImageView.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        albumImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant:300).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant:150).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}

class nameTVCell: UITableViewCell {
    
    
    let albumNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(albumNameLabel)
        
        
        albumNameLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 15).isActive = true
        albumNameLabel.leadingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:10).isActive = true
        albumNameLabel.trailingAnchor.constraint(equalTo:self.contentView.leadingAnchor).isActive = true
        albumNameLabel.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}
