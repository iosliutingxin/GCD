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

//------------------------------------串行队列，同步任务-------------------------------------------------
//-------------------------串行不允许拿多个任务，并行允许--同步没有开启线程，异步开启线程
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
    dispatch_queue_t q = dispatch_queue_create("gcd05", NULL);
    //同步任务
    for (int i = 0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"线程==%@ %d",[NSThread currentThread],i);
        });
    }
    NSLog(@"come here");//-----在主线程
}

//------------------------------------并行队列，异步任务-------------------------------------------------
/**
 */
-(void)gcdDome06{
    
    /**
     1、队列名称：
     2、队列属性
     */
    dispatch_queue_t q = dispatch_queue_create("gcd06", DISPATCH_QUEUE_CONCURRENT);
    //同步任务
    for (int i = 0; i<9; i++) {
        dispatch_async(q, ^{
            NSLog(@"线程==%@ %d",[NSThread currentThread],i);
        });
    }
    
}

-(void)gcdDome07{
    
    /**
     1、队列名称：
     2、队列属性
     */
    dispatch_queue_t q = dispatch_queue_create("gcd07", DISPATCH_QUEUE_CONCURRENT);
    //同步任务
    for (int i = 0; i<9; i++) {
        dispatch_sync(q, ^{
            NSLog(@"线程==%@ %d",[NSThread currentThread],i);
        });
    }
    
}
//------------------------------------同步任务作用-------------------------------------------------
//当任务有顺序要求时----依赖关系
-(void)gcdDome08{
    //队列
    dispatch_queue_t q = dispatch_queue_create("gcd08", DISPATCH_QUEUE_CONCURRENT);
    
    //block
    void(^task)(void) = ^() {
        dispatch_sync(q, ^{
            NSLog(@"登录");
        });
        dispatch_async(q, ^{
            NSLog(@"支付");
        });
        dispatch_async(q, ^{
            NSLog(@"下载");
        });
    };
    dispatch_async(q, task);
    
    
}

//------------------------------------全局队列-------------------------------------------------
-(void)gcdDome09{
    //第一个参数是优先级
    //第二个参数是为未来使用
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    for (int i = 0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"%@",[NSThread currentThread]);
        });
    }
}

//------------------------------------延时执行-------------------------------------------------
-(void)gcdDome10{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self gcdDome10];
}

@end
