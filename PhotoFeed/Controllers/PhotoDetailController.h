//
//  PhotoDetailController.h
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import <UIKit/UIKit.h>

@interface PhotoDetailController : UIViewController

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) NSArray *photos;

@end
