//
//  PhotoModel.h
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject

@property (readonly, nonatomic) NSArray *filteredPhotos;

- (void)refreshPhotos;
- (void)setSearchText:(NSString *)searchText;

@end
