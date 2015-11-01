//
//  LTCollectionViewLayout.m
//  collectionView
//
//  Created by lt on 15/10/30.
//  Copyright (c) 2015年 lt. All rights reserved.
//

#define decorationView @"decorationView"

#import "LTCollectionViewLayout.h"
#import "LTDecotationView.h"

@interface LTCollectionViewLayout()
@property(nonatomic,readonly)CGFloat cellCount;
@property(nonatomic,readonly)CGPoint center;
@property(nonatomic,readonly)CGFloat radius;

@end

@implementation LTCollectionViewLayout

-(void)prepareLayout
{
    [super prepareLayout];
    NSLog(@"prepareLayout");
    
    CGSize size=self.collectionView.frame.size;
    _cellCount=[[self collectionView] numberOfItemsInSection:0];
//    圆心
    _center=CGPointMake(size.height/3.5, size.width/1.5);
//    半径
    _radius=MIN(size.height, size.width)/2.5;
    
//    如果用到了装修，那么必须注册装饰，官方提供了以下两个方法
    
//    - (void)registerClass:(Class)viewClass forDecorationViewOfKind:(NSString *)elementKind;
//    - (void)registerNib:(UINib *)nib forDecorationViewOfKind:(NSString *)elementKind;
    
//    注册装饰
    [self registerClass:[LTDecotationView class] forDecorationViewOfKind:decorationView];
    
}

/**
 *  此方法返回collectionView可以滚动的区域大小
 *
 */
-(CGSize)collectionViewContentSize
{
     NSLog(@"collectionViewContentSize");
    return CGSizeMake(375, 2000);
   
}
/**
 *  描述每个cell的布局信息，包括大小，位置等，布局信息封装到UICollectionViewLayoutAttributes对象中
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"layoutAttributesForItemAtIndexPath");
    UICollectionViewLayoutAttributes *attributes=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    每个cell的大小
    attributes.size=CGSizeMake(34.0 , 34.0);
//    使用三角函数计算每个cell的中点位置
    attributes.center=CGPointMake(_center.x + _radius*cosf(2*M_PI*indexPath.item/_cellCount), _center.y+_radius*sinf(2*M_PI*indexPath.item/_cellCount));
    return attributes;
}

/**
 *  该方法返回值也是UICollectionViewLayoutAttributes对象，attributes对象中已经包含了SupplementaryView的布局信息，即header或footer，区分的方法是ofKind：后面的字符串
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
//    注意：初始化方法和cell、DecorationView不同
    UICollectionViewLayoutAttributes *attributes=[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
    
    return attributes;
}

/**
    使用了装饰，实现这个方法来描述DecorationView的布局
 *  该方法返回值也是UICollectionViewLayoutAttributes对象，attributes对象中已经包含了装饰，使用它需要在自定义的layout的prepareLayout方法中注册，因为collectionView没有提供它的注册方法
 *
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
//    注意：初始化方法和cell、SupplementaryView不同
    UICollectionViewLayoutAttributes *attributes=[UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decorationView" withIndexPath:indexPath];
    
//    放在圆心处
        attributes.center=self.center;
//    尺寸
        attributes.size=CGSizeMake(150,30);

    return attributes;
    
}

/**
 *  对一次显示某个区域的时候自动调用，对显示过的区域不会再调用该方法
 */
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
     NSLog(@"layoutAttributesForElementsInRect,%@",NSStringFromCGRect(rect));
    NSMutableArray *attributes=[NSMutableArray array];
    
//    1、添加cell的布局描述
        for (int i =0; i<self.cellCount; i++) {
            NSIndexPath *indexPath=[NSIndexPath indexPathForItem:i inSection:0];
//            调用对应的方法获得indexPath处的cell布局信息，并添加到数组中
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    
//    2、，如果有，添加header或footer的布局描述
     NSIndexPath *indexPath=[NSIndexPath indexPathForItem:0 inSection:0];
//      调用对应的方法获得indexPath处的header或footer布局信息，并添加到数组中
//    [attributes addObject:[self layoutAttributesForSupplementaryViewOfKind:@"header or footer" atIndexPath:indexPath]];
    
//    3、如果有，添加decorationView的布局描述
    
//       调用对应的方法获取indexPath处decorationView的布局信息
    [attributes addObject:[self layoutAttributesForDecorationViewOfKind:@"decorationView" atIndexPath:indexPath]];
    
//    4、返回装有各种布局信息的数组给collectionView
    return attributes;
  

}
@end
