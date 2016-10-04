//
//  ViewController.m
//  PhotoFeed
//
//  Created by Lucas Twisk on 04-10-16.
//
//

#import "PhotoFeedController.h"
#import "PhotoModel.h"
#import "PhotoCell.h"
#import "PhotoItem.h"
#import "PhotoDetailController.h"

#import <Masonry/Masonry.h>
#import <UIImageView+AFNetworking.h>

NSString static * const kPhotoModelKeyPath = @"filteredPhotos";
NSInteger static const kNumberOfColumns = 3;
CGFloat	static const kCellMargin = 2.0;

@interface PhotoFeedController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) PhotoModel *photoModel;
@property (strong, nonatomic) NSArray *photos;

@end

@implementation PhotoFeedController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self startObserving];
	[self setupViews];
	
	[self.photoModel refreshPhotos];
	[self.collectionView registerClass:PhotoCell.class forCellWithReuseIdentifier:kPhotoCellReuseIdentifier];
}

- (void)dealloc {
	[self stopObserving];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
	[self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)setupViews {
	[self.view addSubview:self.collectionView];
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
	[self.navigationItem setTitleView:self.searchBar];
}

#pragma mark - Key Value Observing

- (void)startObserving {
	[self.photoModel addObserver:self forKeyPath:NSStringFromSelector(@selector(filteredPhotos)) options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}

- (void)stopObserving {
	[self.photoModel removeObserver:self forKeyPath:NSStringFromSelector(@selector(filteredPhotos))];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
	
	// Reload collection when model changes
	if ([keyPath isEqualToString:NSStringFromSelector(@selector(filteredPhotos))] && object == self.photoModel) {
		self.photos = self.photoModel.filteredPhotos;
		[self.collectionView reloadData];
	}
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1.0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellReuseIdentifier forIndexPath:indexPath];
	PhotoItem *photoItem = [self.photos objectAtIndex:indexPath.row];
	[cell.imageView setImageWithURL:[NSURL URLWithString:photoItem.photoUrl]];
	return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	PhotoDetailController *detailController = [PhotoDetailController new];
	detailController.photos = self.photos;
	detailController.selectedIndexPath = indexPath;
	detailController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
	detailController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	
	[self presentViewController:detailController animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat width = CGRectGetWidth(collectionView.bounds) / (CGFloat)kNumberOfColumns - kCellMargin;
	return CGSizeMake(width, width);
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	[self.photoModel setSearchText:searchText];
}

#pragma mark - Properties

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		
		UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
		flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
		flowLayout.minimumLineSpacing = kCellMargin;
		flowLayout.minimumInteritemSpacing = kCellMargin;
		
		_collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
		_collectionView.delegate = self;
		_collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
		_collectionView.dataSource = self;
		_collectionView.backgroundColor = [UIColor whiteColor];
	}
	return _collectionView;
}

- (UISearchBar *)searchBar {
	if (!_searchBar) {
		_searchBar = [UISearchBar new];
		_searchBar.delegate = self;
	}
	return _searchBar;
}

- (PhotoModel *)photoModel {
	if (!_photoModel) {
		_photoModel = [PhotoModel new];
	}
	return _photoModel;
}

@end
