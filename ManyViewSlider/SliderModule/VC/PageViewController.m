//
//  PageViewController.m
//  ManyViewSlider
//
//  Created by 刘松洪 on 16/9/22.
//  Copyright © 2016年 刘松洪. All rights reserved.
//

#import "PageViewController.h"
#import "SliderModel.h"
@interface PageViewController (){
    NSArray *_titleArray;//标题数组
   // NSMutableArray *_modelArray;//控制器数据模型数组
}
@end

@implementation PageViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _titleArray = [NSArray array];
     //   _modelArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  /*  [self getData];//组装假数据
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aclklick:)];
    [self.view addGestureRecognizer:rec];
   */
  [self createUI];
    
}

- (void)aclklick:(UITapGestureRecognizer *)reg {
    CGPoint location = [reg locationInView:reg.view];
    [self drawImageForGestureRecognizer:reg atPoint:location];
    NSLog(@"点击次数%lu",(unsigned long)reg.numberOfTouches);
}

- (void)drawImageForGestureRecognizer:(UITapGestureRecognizer *)reg atPoint:(CGPoint)location {
    
}

- (void)getData {
    NSMutableArray *Arr     = [NSMutableArray array];

    for (int i = 0 ; i < 5; i++) {
        [Arr addObject:[NSString stringWithFormat:@"按钮%d",i]];
      /*  NSMutableArray *modelArr = [NSMutableArray array];
        for (int j = 0; j < 2; j++) {
            SliderModel *model = [[SliderModel alloc]init];
            model.name = [NSString stringWithFormat:@"姓名%d",i];
            model.time = @"2016-09-22";
            model.desc = [NSString stringWithFormat:@"描述内容%d",i];
            model.url  = nil;
            [modelArr addObject:model];
        }
        [_modelArray addObject:modelArr]; */
    }
    _titleArray = Arr;
    
}



- (void)createUI {
   
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
