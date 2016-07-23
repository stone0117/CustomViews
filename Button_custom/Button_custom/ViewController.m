//
//  ViewController.m
//  Button_custom
//
//  Created by stone on 16/7/24.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "SNButton.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //    SNButton * btn = [[SNButton alloc] initWithFrame:CGRectMake(20, 20, 100, 44) actionBlock:^(SNButton * sender) {
    //
    //      NSLog(@"111");
    //
    //    }];
    //
    //    [btn setTitle:@"button" forState:UIControlStateNormal];
    //    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

    SNButton * btn = [[SNButton alloc] initWithFrame:CGRectMake(20, 20, 200, 44) title:@"button" color:HexRGBA(0xBCEAC0, 1.0)];

    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
