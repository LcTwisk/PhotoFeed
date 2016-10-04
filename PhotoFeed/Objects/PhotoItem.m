//
//  PhotoItem.m
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import "PhotoItem.h"

@implementation PhotoItem

+ (JSONKeyMapper *)keyMapper {
	return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"photoUrl" : @"image_url",
																  @"photoDescription" : @"description",
																  @"photoName" : @"name"}];
}

@end
