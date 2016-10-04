//
//  PhotoCell.m
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import "PhotoCell.h"
#import <Masonry/Masonry.h>

NSString * const kPhotoCellReuseIdentifier = @"kPhotoCellReuseIdentifier";

@implementation PhotoCell

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

- (void)prepareForReuse {
	[super prepareForReuse];
	self.imageView.image = nil;
}

#pragma mark - Properties

- (UIImageView *)imageView {
	if (!_imageView) {
		_imageView = [UIImageView new];
		_imageView.contentMode = UIViewContentModeScaleAspectFill;
		_imageView.clipsToBounds = YES;
	}
	return _imageView;
}

@end
