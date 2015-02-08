//
//  SecondViewController.m
//  AutoLayoutSample
//
//  Created by Wataru Nishimoto on 2014/11/9.
//  Copyright (c) 2014 Wataru Nishimoto. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation SecondViewController{
    UIView* lastView;
}
- (IBAction)btnPressed:(id)sender {
//    [lastView removeFromSuperview];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
//    
    // 中心に移動する
    NSLayoutConstraint* centerX = [NSLayoutConstraint constraintWithItem:view
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.0
                                                               constant:0.0];
    // 中心に移動する
    NSLayoutConstraint* centerY = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0.0];
    
    [self.view addConstraints:@[centerX,centerY]];
    [self.view layoutIfNeeded];
    // 1x1くらいの大きさにする.
    NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:view
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:2.0];
    NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:view
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:2.0];
    [view addConstraints:@[height,width]];
    [UIView animateWithDuration:1.0 animations:^(){
        [self.view layoutIfNeeded];
    }completion:^(BOOL completion){
        [view removeConstraint:width];
        NSLayoutConstraint* newWidth = [NSLayoutConstraint constraintWithItem:view
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:view.superview
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:1.0
                                                                    constant:0.0];
        [view.superview addConstraint:newWidth];
        [UIView animateWithDuration:1.0 animations:^(){
            [self.view layoutIfNeeded];
        }completion:^(BOOL compl){
            [view removeConstraint:height];
            NSLayoutConstraint* newHeight = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:view.superview
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0
                                                                         constant:0.0];
            [view.superview addConstraint:newHeight];
            [UIView animateWithDuration:1.0 animations:^(){
                [self.view layoutIfNeeded];
            }];
        }];
    }];


    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
