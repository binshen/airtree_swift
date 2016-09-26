//
//  MyButton.m
//  airtree_swift
//
//  Created by Bin Shen on 9/26/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

#import "MyButton.h"
#import <UIKit/UIKit.h>

@implementation MyButton

+ (void) setTitle:(NSString *) title button: (id) sender {
    UIButton *button = (UIButton *) sender;
    NSAttributedString *attributedTitle = [button attributedTitleForState:UIControlStateNormal];
    NSMutableAttributedString *butTitle = [[NSMutableAttributedString alloc] initWithAttributedString:attributedTitle];
    [butTitle.mutableString setString:title];
    [button setAttributedTitle:butTitle forState:UIControlStateNormal];
}

@end
