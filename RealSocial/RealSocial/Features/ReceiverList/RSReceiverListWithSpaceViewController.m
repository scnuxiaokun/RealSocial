//
//  RSReceiverListWithSpaceViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverListWithSpaceViewController.h"

@interface RSReceiverListWithSpaceViewController ()

@end

@implementation RSReceiverListWithSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableHeaderView = self.spaceView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)loadData {
    [super loadData];
    [self.spaceView.viewModel loadData];
}
-(RSReceiverSpaceView *)spaceView {
    if (_spaceView) {
        return _spaceView;
    }
    _spaceView = [[RSReceiverSpaceView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 138+40+20)];
    return _spaceView;
}

-(void)finishButton:(id)sender {
    if (self.spaceCompletionHandler) {
        //            self.completionHandler(self, [self.viewModel getSelectedUsers], [self.spaceView.viewModel getSelectedSpaces]);
        self.spaceCompletionHandler(self, [self.viewModel getSelectedUsers], [self.spaceView.viewModel getSelectedSpaces]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
