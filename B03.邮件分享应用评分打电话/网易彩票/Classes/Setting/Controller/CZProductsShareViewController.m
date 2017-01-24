//
//  CZProductsShareViewController.m
//  网易彩票
//
//  Created by apple on 15-1-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZProductsShareViewController.h"
#import "CZProduct.h"
#import "CZProductCell.h"

@interface CZProductsShareViewController ()

/**
 *  所有的产品，里面放CZProduct
 */
@property(nonatomic,strong)NSArray *products;

@end

@implementation CZProductsShareViewController


-(NSArray *)products{
    if (!_products) {
        //1.获取json路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"products.json" ofType:nil];
        
        //2.把json转成NSData
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        //3.再把NSData转成数组
        
        //json的序列化 "就是把数据转成字典/数组"
        NSArray *productArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",obj);
        
        //4.遍历数组里字典，转成模型
        NSMutableArray *productsM =[NSMutableArray array];
        for (NSDictionary *dict in productArr) {
            CZProduct *product = [CZProduct productWithDict:dict];
            [productsM addObject:product];
        }
        
        _products = productsM;

    }
    
    return _products;
}

//重用的ID
static NSString * const reuseIdentifier = @"Cell";


-(instancetype)init{
#warning UICollectionViewController初始化的时候，需要一个 "布局参数"
    //流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    if (self = [super initWithCollectionViewLayout:flowLayout]) {

        //最终的cell的大小，是由 流水布局 决定，由xib是决定不了
        //设置cell的尺寸
        flowLayout.itemSize = CGSizeMake(80, 100);
        
        //设置cell的行的间距
        flowLayout.minimumLineSpacing = 50;
        
        //设置cell的列间距
        //flowLayout.minimumInteritemSpacing = 50;
        
        
        //设置section的四边距
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes
    //注册一个可循环引用的cell
    //[self.collectionView registerClass:[CZProductCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CZProductCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}




#pragma mark <UICollectionViewDataSource>
//组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//组里个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CZProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //设置模型
    cell.product = self.products[indexPath.row];
    
    return cell;
}


#pragma mark cell的选中
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    
}

@end
