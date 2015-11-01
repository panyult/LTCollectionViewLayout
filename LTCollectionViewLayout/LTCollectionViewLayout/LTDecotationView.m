//
//  LTDecotationView.m
//  collectionView
//
//  Created by lt on 15/10/30.
//  Copyright (c) 2015年 lt. All rights reserved.
//

#import "LTDecotationView.h"

@implementation LTDecotationView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        UILabel *label=[[UILabel alloc]initWithFrame:self.bounds];
        label.text=@"DecotationView";
        label.backgroundColor=[UIColor whiteColor];
        [self addSubview:label];
    }
    
    return self;
}

@end
