//
//  FirstViewController.m
//  AutoLayoutSample
//
//  Created by Wataru Nishimoto on 2014/11/9.
//  Copyright (c) 2014 Wataru Nishimoto. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (strong, nonatomic) IBOutlet UIView *parentView;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@end

@implementation FirstViewController{
    UIView* _lastView;
}

- (UIColor*)randomColor{
    CGFloat r = (arc4random_uniform(255) + 1)/255.0;
    CGFloat g = (arc4random_uniform(255) + 1)/255.0;
    CGFloat b = (arc4random_uniform(255) + 1)/255.0;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    return color;
}

- (IBAction)btnPressed:(id)sender {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;

    view.backgroundColor = [self randomColor];
    [self.view addSubview:view];
    
    // 高さは常に画面の高さ
    NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:view
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1.0
                                                               constant:0.0];
    // 右端は常に_rightViewの左端まで
    NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:view
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem: _rightView
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1.0
                                                              constant:0.0];
    [self.view addConstraints:@[height,width]];
    [self.view layoutIfNeeded];
    // ここまでで，右端にViewが入っている
    
    if (_lastView == nil) { // 最初は左端を決めないといけない
        // 最初は左端は_leftViewの右端(画面の左端がViewの左端)
        NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_leftView
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.0
                                                                 constant:0.0];
        [self.view addConstraint:left];
    }else{
        NSLayoutConstraint* con;
        for(con in self.view.constraints){
            if (con.firstAttribute == NSLayoutAttributeRight && con.firstItem == _lastView) {
                break;
            }
        }
        // 右端を繋ぎかえる
        // _rightViewと繋いでいたViewを外す
        [self.view removeConstraint:con];
        // _rightViewに繋いでいたViewの右端を新しいviewの左端に繋ぐ
        NSLayoutConstraint* newRight = [NSLayoutConstraint constraintWithItem:_lastView
                                            attribute:NSLayoutAttributeRight
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:view
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0
                                             constant:0.0];
        // 上の反対
        NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem:view
                                           attribute:NSLayoutAttributeLeft
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:_lastView
                                           attribute:NSLayoutAttributeRight
                                          multiplier:1.0
                                            constant:0.0];
        // widthが同じになるようにする
        NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_lastView
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0
                                                                 constant:0.0];
        [self.view addConstraints:@[width,newRight,left]];
    }
    
    // アニメーションさせる.
    [UIView animateWithDuration:1.0 animations:^(){
        [self.view layoutIfNeeded];
        [self.view bringSubviewToFront:_button];
    }];
    _lastView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _lastView = nil;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
