//
//  PhotoDataHandler.h
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import <Foundation/Foundation.h>

@interface PhotoDataHandler : NSObject

- (void)getPhotosOnCompletion:(void (^)(NSError *error, NSArray *photos))completion;

@end
