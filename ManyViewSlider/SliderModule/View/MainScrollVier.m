//
//  MainScrollVier.m
//  ManyViewSlider
//
//  Created by 刘松洪 on 16/9/8.
//  Copyright © 2016年 刘松洪. All rights reserved.
//

#import "MainScrollVier.h"
#import "objc/Runtime.h"
@interface MainScrollVier ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _count;//创建view的数量
}
@property (strong, nonatomic) UIScrollView *bgScroll;

@end

@implementation MainScrollVier

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithViews:(NSInteger)i {
    self = [super init];
    if (self) {
         _count = i;
        [self createUI];
         [self willChangeValueForKey:@"age"];
    }
    return self;
}

- (void)createUI {

    UIScrollView *btnBgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,45)];
    [btnBgView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:btnBgView];
     btnBgView.showsHorizontalScrollIndicator = NO;
     btnBgView.contentSize = CGSizeMake(_count * 100,45);
    self.bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, btnBgView.frame.origin.y + btnBgView.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 45)];
    self.bgScroll.showsVerticalScrollIndicator = NO;
    [self addSubview:self.bgScroll];
    self.bgScroll.pagingEnabled = YES;
    self.bgScroll.contentSize = CGSizeMake(_count * [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    
    for (int i = 0; i<_count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:[NSString stringWithFormat:@"按钮%d",i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(0 + i * 100, 0 , 100, 45)];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [btnBgView addSubview:btn];
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 45) style:UITableViewStylePlain];
         table.delegate   = self;
         table.dataSource = self;
        [table setBackgroundColor:[UIColor clearColor]];
         table.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        [table setTableFooterView:[[UIView alloc] init]];
        [self.bgScroll addSubview:table];
        table.tag = 200 + i;
    }
    unsigned int count = 0;
    class_copyPropertyList([self class], &count);
    NSLog(@"%d",count);
    NSString *str = @"bgScroll";
    const char *c = [str UTF8String];
    class_getProperty([self class], c);
    
}

- (void)clickBtn:(id)sender {
    UIButton *b = (UIButton *)sender;
    switch (b.tag) {
        case 100:
            
            break;
        case 101:
            
            break;
        case 102:
            
            break;
        case 103:
            
            break;
        case 104:
            
            break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr = @"cellStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    UILabel *name = [[UILabel alloc]init];
    [cell.contentView addSubview:name];
     [name mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(cell.contentView).offset(15);
         make.top.equalTo(cell.contentView).offset(5.0);
         make.height.mas_equalTo(@20);
     }];
    name.text = @"123";
    UILabel *title = [[UILabel alloc]init];
    [cell.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(name.mas_bottom).offset(5.0);
        make.left.equalTo(name);
        make.bottom.equalTo(cell.contentView).offset(-5);
    }];
    title.text = @"456";

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}



@end
