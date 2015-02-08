//
//  ThirdViewController.m
//  AutoLayoutSample
//
//  Created by Wataru Nishimoto on 2014/11/10.
//  Copyright (c) 2014 Wataru Nishimoto. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ThirdViewController{
    UIView* _lastView;
    NSMutableArray* _ary;
    int _idx;
    float _margin;
}


- (UIColor*)randomColor{
    CGFloat r = (arc4random_uniform(255) + 1)/255.0;
    CGFloat g = (arc4random_uniform(255) + 1)/255.0;
    CGFloat b = (arc4random_uniform(255) + 1)/255.0;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    return color;
}

-(NSArray*)wiskers:(UIView*)wisker mainView:(UIView*)mainView{
    // widthが同じになるようにする
    NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:wisker
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:2.0];

    // widthが同じになるようにする
    NSLayoutConstraint* centerX = [NSLayoutConstraint constraintWithItem:wisker
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:mainView
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0.0];

    
    
    return @[width,centerX];
}

- (IBAction)btnPressed:(id)sender {
    // とりあえず0個目だけ
    
    // 四角のView
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    // 上の髭
//    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectZero];
//    topLineView.translatesAutoresizingMaskIntoConstraints = NO;
//    topLineView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:topLineView];
//    [self.view addConstraints:[self wiskers:topLineView mainView:view]];
//    
//    
//    // 下の髭
//    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
//    bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
//    bottomLineView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:bottomLineView];
//    [self.view addConstraints:[self wiskers:bottomLineView mainView:view]];
//
    
    view.backgroundColor = [self randomColor];
    [self.view addSubview:view];
    // 最小値とか最大値とかの設定
    NSLayoutConstraint* minTop = [NSLayoutConstraint constraintWithItem:view
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                 toItem:view.superview
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0];
    NSLayoutConstraint* maxBottom = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                                                    toItem:view.superview
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0.0];
    
    
    NSLayoutConstraint* minHeight = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0
                                                                  constant:0.1];
    NSLayoutConstraint* minWidth = [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:0.1];
    // 何もないなら大きさ最大みたいなことがしたい．

//    
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view
                                         attribute:NSLayoutAttributeRight
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:view.superview
                                         attribute:NSLayoutAttributeRight
                                        multiplier:1.0
                                          constant:0.0];
    NSLayoutConstraint *left;
    if (_lastView == nil) {
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:10];
        height.priority = 10;
        NSLayoutConstraint* centerY = [NSLayoutConstraint constraintWithItem:view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:view.superview
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.0
                                                                    constant:0.0];
        [view.superview addConstraint:centerY];
        [view addConstraint:height];

        left = [NSLayoutConstraint constraintWithItem:view
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:view.superview
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0
                                             constant:0.0];
    }else{
        NSLayoutConstraint* con;
        for(con in view.superview.constraints){
            if (con.firstAttribute == NSLayoutAttributeRight && con.firstItem == _lastView) {
                break;
            }
        }
        // 右端を繋ぎかえる
        // _rightViewと繋いでいたViewを外す
        [view.superview removeConstraint:con];
        // _rightViewに繋いでいたViewの右端を新しいviewの左端に繋ぐ
        left = [NSLayoutConstraint constraintWithItem:view
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
        width.priority = 100;
        
        float yesterdayHigh = [_ary[_idx-1][1] floatValue];
        float todayHigh = [_ary[_idx][1] floatValue];
        float todayTop = yesterdayHigh/todayHigh;
        NSLayoutConstraint* top =  [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_lastView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:todayTop
                                                                 constant:0.0];
        float yesterdayLow = [_ary[_idx-1][4] floatValue];
        float todayLow = [_ary[_idx][4] floatValue];
        float todayBottom = yesterdayLow/todayLow;
        
        NSLayoutConstraint* bottom =  [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_lastView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:todayBottom
                                                                 constant:0.0];

        [view.superview addConstraints:@[width,top,bottom]];
    }
    [view addConstraints:@[minWidth,minHeight]];
    [view.superview addConstraints:@[minTop,maxBottom,left,right]];

//    // アニメーションさせる.
//    [UIView animateWithDuration:1.0 animations:^(){
        [view.superview layoutIfNeeded];
        [view.superview bringSubviewToFront:_button];
//    }];
    _idx++;
    _lastView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSError *error = nil;
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"csv"];
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding: NSShiftJISStringEncoding error: &error];
    // 1行ごとに分割
    NSArray *lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    _ary = [NSMutableArray array];
    float highest = 0;
    float lowest = 100000000;
    for(NSString* currentPointString in lines)
    {
        NSArray* ary = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        highest = MAX(highest, [ary[2] floatValue]);
        lowest = MIN(lowest, [ary[3] floatValue]);

        [_ary addObject:ary];
    }
    _margin = highest - lowest;
    _idx = 0;
    _lastView = nil;
    while (_idx < [_ary count]) {
        [self btnPressed:nil];
    }
    // Do any additional setup after loading the view.
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
