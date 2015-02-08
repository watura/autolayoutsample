//
//  FourthViewController.m
//  AutoLayoutSample
//
//  Created by Wataru Nishimoto on 2015/1/29.
//  Copyright (c) 2015 Wataru Nishimoto. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController (){
    UITextView* _scrollSample;
    UIView* _resizeView;
    UILabel* _label;
    CGPoint _oldPoint;
    BOOL _willChangeHeight;
}

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _willChangeHeight = NO;

    
    _scrollSample = [[UITextView alloc] init];
    _scrollSample.translatesAutoresizingMaskIntoConstraints = NO;
    _scrollSample.editable = NO;
    _scrollSample.userInteractionEnabled = YES;
    _scrollSample.selectable = NO;
    _scrollSample.delegate = self;
    // サンプル長文を作る
    _scrollSample.text = @"Hello World";
    for (int i = 0; i < 100; i++) {
        _scrollSample.text = [_scrollSample.text stringByAppendingString:[NSString stringWithFormat:@"%d\n",i]];
    }
    
    
    [self.view addSubview:_scrollSample];
    _resizeView = [[UIView alloc]init];
    _resizeView.translatesAutoresizingMaskIntoConstraints = NO;
    _resizeView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_resizeView];
    [self setToDefalutSize];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _scrollSample.contentOffset =CGPointZero;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void) setToDefalutSize{

    // Constainsを全て削除する.
    [_resizeView removeConstraints:_resizeView.constraints];
    [_scrollSample removeConstraints:_scrollSample.constraints];

    // _scrollSample
    
    // Left
    NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem:_scrollSample
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.view
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0
                                                             constant:0];
    NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:_scrollSample
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0];
    [self.view addConstraints:@[left,bottom]];

    // Width/ Height
    NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:_scrollSample
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1.0
                                                              constant:0];
    NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:_scrollSample
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:0.9
                                                              constant:0];
    
    [self.view addConstraints:@[width,height]];
    
    // _resizeView
    // X
    NSLayoutConstraint* x = [NSLayoutConstraint constraintWithItem:_resizeView
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0
                                                          constant:0];
    [self.view addConstraint:x];
    
    // Width
    width = [NSLayoutConstraint constraintWithItem:_resizeView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1
                                                              constant:0];
    [self.view addConstraint:width];
    // Height & Y
    NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:_resizeView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0.0];
    bottom = [NSLayoutConstraint constraintWithItem:_resizeView
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:_scrollSample
                                          attribute:NSLayoutAttributeTop
                                         multiplier:1.0
                                           constant:0.0];

    [self.view addConstraints:@[top,bottom]];
    [self.view layoutIfNeeded];
}

-(void) decreaseHeightWithSpeed:(NSInteger)speed{
    NSLayoutConstraint* con=nil;
    for(con in self.view.constraints){
        if (con.firstItem == _scrollSample && con.secondItem == self.view && con.firstAttribute ==NSLayoutAttributeHeight){
            break;
        }
    }

    if (con  == nil)
        return;
    if (speed > 10)
        speed = 34 - con.constant;
    if (con.constant + speed>= self.view.frame.size.height*0.05)
        return;
    [self.view removeConstraint:con];
    NSLayoutConstraint * newHeight = [NSLayoutConstraint constraintWithItem:_scrollSample
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:0.9
                                                                   constant:con.constant + speed];
    [self.view addConstraint:newHeight];

    _scrollSample.contentOffset = _oldPoint;
    _scrollSample.bounces = NO;
    [UIView animateWithDuration:0.05 animations:^(){
        [self.view layoutIfNeeded];
    }completion:^(BOOL compete){
        _scrollSample.bounces = YES;
    }];
}

-(void) increaseHeightWithSpeed:(NSInteger)speed{
    NSLayoutConstraint* con=nil;
    for(con in self.view.constraints){
        if (con.firstItem == _scrollSample && con.secondItem == self.view && con.firstAttribute ==NSLayoutAttributeHeight){
            break;
        }
    }
    
    if (con  == nil)
        return;
    if (speed > 24)
        speed = con.constant;
    if (con.constant - speed <0 )
        return;
    [self.view removeConstraint:con];
    NSLayoutConstraint * newHeight = [NSLayoutConstraint constraintWithItem:_scrollSample
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:0.9
                                                                   constant:con.constant - speed];
    [self.view addConstraint:newHeight];

//    [UIView animateWithDuration:0.1 animations:^(){
        _scrollSample.contentOffset = CGPointMake(_oldPoint.x, 0);

        [self.view layoutIfNeeded];
//    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}   


#pragma mark -
#pragma mark Scroll View Delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _oldPoint = _scrollSample.contentOffset;
    _willChangeHeight = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 最初にスクロールしてしまうのでそれは無視する
    
    
    CGFloat diff = abs(_oldPoint.y - _scrollSample.contentOffset.y);
    if (_oldPoint.y < _scrollSample.contentOffset.y && _scrollSample.contentOffset.y >0) {
        [self decreaseHeightWithSpeed:diff];
    }else if(_scrollSample.contentOffset.y <= 0 && _oldPoint.y >= 0){
        [self increaseHeightWithSpeed:diff];
    }
    _oldPoint = _scrollSample.contentOffset;

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _willChangeHeight = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
