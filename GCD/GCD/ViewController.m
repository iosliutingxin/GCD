//
//  ViewController.m
//  GCD
//
//  Created by 李孔文 on 2018/5/25.
//  Copyright © 2018年 Sunning. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self gcdDome05];
}

-(void)gcdDemo1{
    
   // 1、创建队列
    dispatch_queue_t g =  dispatch_get_global_queue(0, 0);
    //2、在队列中添加任务
    //2.1定义任务
    void(^task)(void) = ^() {
        NSLog(@"%@",[NSThread currentThread]);
    };
    //2.2 添加任务到队列，并且执行--同步执行
    dispatch_sync(g, task);
    
}


-(void)gcdDemo2{
    
    // 1、创建队列
    dispatch_queue_t g =  dispatch_get_global_queue(0, 0);
    //2、在队列中添加任务
    //2.1定义任务
    void(^task)(void) = ^() {
        NSLog(@"%@",[NSThread currentThread]);
    };
    //2.2 添加任务到队列，并且执行--异步执行
    dispatch_async(g, task);
    
}

-(void)gcdDemo3{
    //主队列用同步和异步都是同一个概念
    
     //指定任务执行--异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"耗时操作");
        //更新UI--在主线程上面
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"更新UI%@",[NSThread currentThread]);
        });
    });
}

//------------------------------------串行队列，同步任务
/**
 不会开启线程，会顺序执行
 */
-(void)gcdDome04{
    
    /**
     1、队列名称：
     2、队列属性
     */
    dispatch_queue_t q = dispatch_queue_create("gcd04", NULL);
    //同步任务
    for (int i = 0; i<9; i++) {
        dispatch_sync(q, ^{
            NSLog(@"线程==%@ %d",[NSThread currentThread],i);
        });
    }
   
}

//串行队列，异步任务
/**
 不会开启线程，会顺序执行
 */
-(void)gcdDome05{
    
    /**
     1、队列名称：
     2、队列属性
     */
    dispatch_queue_t q = dispatch_queue_create("gcd04", NULL);
    //同步任务
    for (int i = 0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"线程==%@ %d",[NSThread currentThread],i);
        });
    }
    NSLog(@"come here");//-----在主线程
}




@end
