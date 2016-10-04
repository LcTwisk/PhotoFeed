//
//  PhotoDataHandler.m
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import "PhotoDataHandler.h"
#import "PhotoItem.h"
#import <AFNetworking/AFNetworking.h>

NSString * const kBaseUrl = @"https://api.500px.com/v1/";
NSString * const kConsumerKey = @"tXiWI01bjgDuYNA5WHJ7yurka7pMH29BdxsMZKG5";

@implementation PhotoDataHandler

- (void)getPhotosOnCompletion:(void (^)(NSError *error, NSArray *photos))completion {
	
	NSString *urlString = [NSString stringWithFormat:@"%@/photos", kBaseUrl];
	NSDictionary *parameters = @{@"consumer_key" : kConsumerKey,
								 @"rpp" : @"100",
								 @"image_size"  : @"21",
								 @"exclude" : @"Nude"};

	[[AFHTTPSessionManager manager] GET:urlString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
		
		NSError *error;
		NSArray *photos = [PhotoItem arrayOfModelsFromDictionaries:responseObject[@"photos"] error:&error];

		if (error) {
			completion(error, nil);
		} else {
			completion(nil, photos);
		}
		
	} failure:^(NSURLSessionTask *operation, NSError *error) {
		completion(error, nil);
	}];
}

@end
