//
//  QXTextView.h
//  PlaceHoder
//
//  Created by hzl on 16/10/1.
//  Copyright © 2016年 hzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OXTextView : UITextView


@property(nonatomic, strong) UILabel *placeHolderLabel;

@property(nonatomic, strong) NSString *placeHolder;

@property(nonatomic, strong) UIColor *placeHolderTextColor;

-(void)textChanged:(NSNotification*)notification;

@end
