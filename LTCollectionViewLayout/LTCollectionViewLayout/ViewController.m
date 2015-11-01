//
//  ViewController.m
//  collectionView
//
//  Created by lt on 15/10/30.
//  Copyright (c) 2015年 lt. All rights reserved.
//

#define  collectionCell @"collectionCell"
#import "ViewController.h"
#import "LTCollectionViewLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    1、初始化collectionView
    LTCollectionViewLayout *myLayout=[[LTCollectionViewLayout alloc]init];
    
    UICollectionView * myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) collectionViewLayout:myLayout];
    
    myCollectionView.backgroundColor=[UIColor purpleColor];
    
    self.collectionView=myCollectionView;
    [self.view addSubview:myCollectionView];
//    2、设置代理
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    
//    3、注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
    

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    cell.backgroundColor=[UIColor orangeColor];

    return cell;
    
}

@end
