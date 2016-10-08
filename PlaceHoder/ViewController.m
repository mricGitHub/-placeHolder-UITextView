//
//  ViewController.m
//  PlaceHoder
//
//  Created by hzl on 16/10/1.
//  Copyright © 2016年 hzl. All rights reserved.
// 添加一个通知，监听textview的内容改变；重写drawRect:方法，实现为textView添加placeholder功能。

#import "ViewController.h"
#import "OXTextView.h"

@interface ViewController () <UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutTextView];
    
}

- (void)layoutTextView {
    OXTextView  *textView = [[OXTextView alloc] initWithFrame:CGRectMake(20, 40, 200, 100)];
    textView.delegate = self;
//    textView.text = @"hello";
    textView.placeHolder = @"hello";
    [self.view addSubview:textView];
    
}

#pragma mark uiviewDelegate







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
