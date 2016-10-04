//
//  PhotoModel.m
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import "PhotoModel.h"
#import "PhotoItem.h"
#import "PhotoDataHandler.h"

@interface PhotoModel ()

@property (strong, nonatomic) PhotoDataHandler *photoDataHandler;
@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSArray *allPhotos;
@property (strong, nonatomic) NSArray *filteredPhotos;

@end

@implementation PhotoModel

- (void)refreshPhotos {
	
	[self.photoDataHandler getPhotosOnCompletion:^(NSError *error, NSArray *photos) {
		if (!error) {
			self.allPhotos = photos;
		}
	}];
}

- (void)filter {
	
	NSPredicate *nameSearch = [NSPredicate predicateWithFormat:@"photoName contains[c] %@", self.searchText];
	NSPredicate *descriptionSearch = [NSPredicate predicateWithFormat:@"photoDescription contains[c] %@", self.searchText];
	
	if (self.searchText && self.searchText.length > 0) {
		self.filteredPhotos = [self.allPhotos filteredArrayUsingPredicate:[NSCompoundPredicate orPredicateWithSubpredicates:@[nameSearch, descriptionSearch]]];
	} else {
		self.filteredPhotos = self.allPhotos;
	}
}

#pragma mark - Setters

- (void)setAllPhotos:(NSArray *)allPhotos {
	_allPhotos = allPhotos;
	[self filter];
}

- (void)setSearchText:(NSString *)searchText {
	_searchText = searchText;
	[self filter];
}

#pragma mark - Properties

- (PhotoDataHandler *)photoDataHandler {
	if (!_photoDataHandler) {
		_photoDataHandler = [PhotoDataHandler new];
	}
	return _photoDataHandler;
}

@end
