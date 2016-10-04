//
//  PhotoDetailController.m
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import "PhotoDetailController.h"
#import "PhotoDetailCell.h"
#import "PhotoItem.h"

#import <Masonry/Masonry.h>
#import <UIImageView+AFNetworking.h>

CGFloat static const kCellMargin = 16.0;

@interface PhotoDetailController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIButton *closeButton;


@end

@implementation PhotoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupViews];
	self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.9];
	[self.collectionView registerClass:PhotoDetailCell.class forCellWithReuseIdentifier:kPhotoDetailCellReuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.collectionView layoutIfNeeded];
	[self.collectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
	
	// Adjust contentOffset to show same photo after rotation
	CGFloat currentPage = ceil(self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.bounds));
	[self.collectionView setContentOffset:CGPointMake(currentPage * size.width, 0) animated:NO];
	[self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)setupViews {
	
	[self.view addSubview:self.collectionView];
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(60.0, 0.0, 60.0, 0.0));
	}];
	
	[self.view addSubview:self.closeButton];
	[self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.top.equalTo(self.view).insets(UIEdgeInsetsMake(16.0, 16.0, 0.0, 0.0));
		make.size.mas_equalTo(CGSizeMake(40.0, 40.0));
	}];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1.0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	PhotoDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoDetailCellReuseIdentifier forIndexPath:indexPath];
	PhotoItem *photoItem = [self.photos objectAtIndex:indexPath.row];
	[cell.imageView setImageWithURL:[NSURL URLWithString:photoItem.photoUrl]];
	return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(CGRectGetWidth(collectionView.bounds) - 2 * kCellMargin, CGRectGetHeight(collectionView.bounds));
}

#pragma mark - Actions

- (void)didPressCloseButton:(UIButton *)button {
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Properties

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		
		UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
		flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		flowLayout.minimumLineSpacing = 2 * kCellMargin;
		flowLayout.sectionInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);
		
		_collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.pagingEnabled = YES;
		_collectionView.backgroundColor = [UIColor clearColor];
	}
	return _collectionView;
}

- (UIButton *)closeButton {
	if (!_closeButton) {
		_closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_closeButton setImage:[UIImage imageNamed:@"close_button"] forState:UIControlStateNormal];
		[_closeButton addTarget:self action:@selector(didPressCloseButton:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _closeButton;
}

@end
