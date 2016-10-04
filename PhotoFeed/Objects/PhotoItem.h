//
//  PhotoItem.h
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import <JSONModel/JSONModel.h>

@interface PhotoItem : JSONModel

@property (strong, nonatomic) NSString *photoUrl;
@property (strong, nonatomic) NSString<Optional> *photoDescription;
@property (strong, nonatomic) NSString *photoName;

@end
