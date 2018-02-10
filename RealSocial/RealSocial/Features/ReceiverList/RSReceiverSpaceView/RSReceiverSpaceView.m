//
//  RSReceiverSpaceView.m
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverSpaceView.h"
#import "RSReceiverSpaceCollectionViewCell.h"
@implementation RSReceiverSpaceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor randomColor];
        [self addSubview:self.titleView];
        [self addSubview:self.collectionView];
        
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom);
            make.left.right.bottom.equalTo(self);
        }];
    }
    return self;
}

-(RSReceiverSpaceViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSReceiverSpaceViewModel alloc] init];
    return _viewModel;
}

-(RSReceiverTitleView *)titleView {
    if (_titleView) {
        return _titleView;
    }
    _titleView = [[RSReceiverTitleView alloc] init];
    _titleView.label.text = @"My Space";
    return _titleView;
}
-(UICollectionView *)collectionView {
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(130, 130);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 2;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 244, self.frame.size.width,130) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor randomColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[RSReceiverSpaceCollectionViewCell class] forCellWithReuseIdentifier:@"RSReceiverSpaceCollectionViewCell"];
    @weakify(self);
    [[RACObserve(self.viewModel, listData) deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        [self.collectionView reloadData];
    }];
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.viewModel.listData count];
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RSReceiverSpaceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RSReceiverSpaceCollectionViewCell" forIndexPath:indexPath];
    RSReceiverSpaceItemViewModel *itemViewMdoel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    cell.viewModel = itemViewMdoel;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RSReceiverSpaceItemViewModel *itemViewMdoel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    itemViewMdoel.isSeleted = !itemViewMdoel.isSeleted;
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
}
@end
