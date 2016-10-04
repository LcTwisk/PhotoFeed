//
//  PhotoCell.h
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import <UIKit/UIKit.h>

extern NSString * const kPhotoCellReuseIdentifier;

@interface PhotoCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

@end
