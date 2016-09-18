//
//  SliderViewController.m
//  ManyViewSlider
//
//  Created by 刘松洪 on 16/9/8.
//  Copyright © 2016年 刘松洪. All rights reserved.
//

#import "SliderViewController.h"
#import "MainScrollVier.h"
@interface SliderViewController ()
@property (strong, nonatomic) MainScrollVier *mainView;
@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createGCD];
//    [self createUI];
    
}

- (void)createGCD {
    //    [self createDisPatchGroup];//添加线程组
    //    [self createBarrier];//添加栅栏
    //      [self delayDiposeGCD];//延时执行任务
    //      [self apply];//迭代
    //    [self main_queue_deadlock];
          [self GCDTime];
}

#pragma mark UI
- (void)createUI {
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    WS(weakSelf)
    self.mainView = [[MainScrollVier alloc]initWithViews:5];
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}


#pragma mark GCD线程相关

- (void)GCDTime {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个定时器起源
//    dispatch_source_t time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, <#uintptr_t handle#>, <#unsigned long mask#>, <#dispatch_queue_t queue#>)
}

- (void)apply {
    //参数一:迭代次数
    //参数二:任务队列
    //参数三:迭代执行的代码块
    //迭代是异步的
    dispatch_queue_t queue = dispatch_queue_create("com.726.concurrent", DISPATCH_QUEUE_SERIAL);
    dispatch_apply(5, queue, ^(size_t index) {
        NSLog(@"apply %zu.",index);
    });
}

- (void)delayDiposeGCD {
    
    NSLog(@"%@",[NSDate date]);
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        NSLog(@"延迟执行任务%@",[NSDate date]);
    });
    
    
}

- (void)main_queue_deadlock
{
    
    dispatch_queue_t q = dispatch_get_main_queue();
    NSLog(@"1111");
    dispatch_async(q, ^{
        NSLog(@"主队列异步任务 %@", [NSThread currentThread]);
    });
    NSLog(@"2222");
    // 下面会造成线程死锁
    dispatch_sync(q, ^{
        NSLog(@"主队列同步 %@", [NSThread currentThread]);
    });
}

- (void)createBarrier { //DISPATCH_QUEUE_SERIAL 串行队列／DISPATCH_QUEUE_CONCURRENT并行队列
    dispatch_queue_t queue = dispatch_queue_create("com.lysongzi.barrier.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 15; i++) {
            NSLog(@"before barrier01 ==> %d ==> %@", i, [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 15; i++) {
            NSLog(@"before barrier02 ==> %d ==> %@", i, [NSThread currentThread]);
        }
    });
    
    //创建一个barrier任务，此后添加的任务需要在该任务执行完之后才会开始执行
    dispatch_barrier_async(queue, ^{
        NSLog(@"This is barrier task");
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 15; i++) {
            NSLog(@"after barrier01 ==> %d ==> %@", i, [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 15; i++) {
            NSLog(@"after barrier02 ==> %d ==> %@", i, [NSThread currentThread]);
        }
    });
    
}

- (void)createDisPatchGroup {
    //创建线程组
    dispatch_group_t group = dispatch_group_create();

    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.lsh726.queue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    
    //获取全局队列
    dispatch_queue_t globalQueue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    //添加异步执行的任务,组里的任务都是异步执行的
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行队列:====%d=====> %@",i,[NSThread currentThread]);
        }
    });
    
//      dispatch_group_wait(group, 2);
    
    dispatch_group_async(group, globalQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"全局 ==> %d ==> %@", i, [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, globalQueue, ^{
        for (int i = 0; i < 6; i++) {
            NSLog(@"全局==> %d ==> %@", i, [NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"串行结束通知%@",[NSThread currentThread]);
    });
    
    dispatch_group_notify(group, globalQueue, ^{
        NSLog(@"全局结束通知%@", [NSThread currentThread]);
    });
    
  
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
