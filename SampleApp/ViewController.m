//
//  ViewController.m
//  SampleApp
//
//  Created by Dimitris Koutsogiorgas on 12/16/19.
//  Copyright © 2019 Dimitris Koutsogiorgas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [[NSProcessInfo processInfo] environment]);
    // Do any additional setup after loading the view.
}


@end
