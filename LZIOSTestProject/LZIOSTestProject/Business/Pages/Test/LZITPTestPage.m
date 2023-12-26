//
//  LZITPTestPage.m
//  LZIOSTestProject
//
//  Created by 金胜利 on 2023/12/15.
//  Copyright © 2023 jinshengli. All rights reserved.
//

#import "LZITPTestPage.h"
#import "LZLog.h"
#import "LZFileTool.h"
#include <dlfcn.h>

@interface LZITPTestPage ()

@end

@implementation LZITPTestPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self _test1];
    [self _test2];
}

- (void)_test1 {
    Class animal = NSClassFromString(@"LZTFAnimal");
    LZLoggerInfo(@"animal 0: %@", animal);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Frameworks/LZTestFramework.framework/LZTestFramework" ofType:nil];
    void *libHanle = [self _loadDyld:path];
    
    animal = NSClassFromString(@"LZTFAnimal");
    LZLoggerInfo(@"animal 1: %@", animal);
    
    [self _closeDyld:libHanle];
    
    animal = NSClassFromString(@"LZTFAnimal");
    LZLoggerInfo(@"animal 2: %@", animal);
}

- (void)_test2 {
    NSString *path = [[LZFileTool sandBoxPath:LZSandBoxTypeDocument] stringByAppendingFormat:@"/LZTestFramework2.framework/LZTestFramework2"];
    [self _loadDyld:path];
}

- (void *)_loadDyld:(NSString *)path {
    void *libHandle = dlopen(path.UTF8String, RTLD_LAZY);
    if (libHandle) {
        LZLoggerInfo(@"%@, %p", path, libHandle);
    } else {
        LZLoggerInfo(@"failed to load dylb %@, error: %s", path, dlerror());
    }
    return libHandle;
}

- (int)_closeDyld:(void *)handle {
    if (!handle) {
        LZLoggerError(@"close dyld error: handle is nil");
        return -1;
    }
    
    int ret = dlclose(handle);
    LZLoggerInfo(@"close dyld: %d, %s", ret, dlerror());
    return ret;
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
