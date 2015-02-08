//
//  FifthViewController.m
//  AutoLayoutSample
//
//  Created by Wataru Nishimoto on 2015/1/30.
//  Copyright (c) 2015 Wataru Nishimoto. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController (){
    UIImageView* _imageView;
    UIView* _fromView;
    UIView* _desinationView;
}

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple.png"]];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_imageView];
    
    // Do any additional setup after loading the view.
}
- (IBAction)btnPressed:(UIButton*)sender {
    sender.enabled = NO;
    NSLayoutConstraint* x = [NSLayoutConstraint constraintWithItem:_imageView
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0 constant:0];
    NSLayoutConstraint* y = [NSLayoutConstraint constraintWithItem:_imageView
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0 constant:0];
    [self.view addConstraints:@[x,y]];
    [UIView animateWithDuration:1 animations:^(){
        [self.view layoutIfNeeded];
        [self.view bringSubviewToFront:sender];
    }completion:^(BOOL compl){
        [self loop:x y:y];
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple.png"]];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_imageView];
        sender.enabled = YES;
    }];

}


-(void)loop:(NSLayoutConstraint*)x y:(NSLayoutConstraint*)y{
    // スタックくいつくす．
    x.constant = arc4random()%(int)(self.view.frame.size.width/2.0);
    y.constant = arc4random()%(int)(self.view.frame.size.height/2.0);
    [UIView animateWithDuration:1 animations:^(){
        [self.view layoutIfNeeded];
    }completion:^(BOOL compl){
        x.constant = x.constant * -1;
        y.constant = y.constant * -1;
        [UIView animateWithDuration:1 animations:^(){
            [self.view layoutIfNeeded];
        }completion:^(BOOL compl){
            x.constant = 0;
            y.constant = 0;
            [UIView animateWithDuration:1 animations:^(){
                [self.view layoutIfNeeded];
            }completion:^(BOOL compl){
                [self loop:x y:y];
            }];
        }];
    }];
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

@end
