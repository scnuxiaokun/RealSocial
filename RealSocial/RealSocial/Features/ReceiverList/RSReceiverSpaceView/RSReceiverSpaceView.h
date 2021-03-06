//
//  RSReceiverSpaceView.h
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSReceiverTitleView.h"
#import "RSReceiverSpaceViewModel.h"
#import "RSReceiverSpaceCollectionViewCell.h"
@interface RSReceiverSpaceView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) RSReceiverTitleView *titleView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) RSReceiverSpaceViewModel *viewModel;
@property (nonatomic, strong) UIButton *createGroupButton;
@property (nonatomic, assign) NSInteger selectedCount;
@property (nonatomic, strong) UIView *fixedSpaceView;
@property (nonatomic, strong) RSReceiverSpaceCollectionViewCell *allFriendCell;
@property (nonatomic, strong) RSReceiverSpaceCollectionViewCell *memoriesCell;
-(void)setAllunSelected;
@end
