//
//  PhotoDetailCell.m
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import "PhotoDetailCell.h"
#import <Masonry/Masonry.h>

NSString * const kPhotoDetailCellReuseIdentifier = @"kPhotoDetailCellReuseIdentifier";

@implementation PhotoDetailCell

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self.contentView addSubview:self.imageView];
		[self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(self.contentView);
		}];
	}
	return self;
}


#pragma mark - Properties

- (UIImageView *)imageView {
	if (!_imageView) {
		_imageView = [UIImageView new];
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		_imageView.clipsToBounds = YES;
	}
	return _imageView;
}

@end
