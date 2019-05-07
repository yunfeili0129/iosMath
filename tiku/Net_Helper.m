//
//  Net_Helper.m
//  tiku
//
//  Created by zhixinB on 2019/5/6.
//  Copyright © 2019 zhixinB. All rights reserved.
//

#import "Net_Helper.h"

@implementation Net_Helper
/// 清空Cookie
+ (void)clearCookie {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (NSHTTPCookie *obj in cookieArray) {
        [cookieJar deleteCookie:obj];
    }
    cookieArray = nil;
    
    NSUserDefaults *uds = [NSUserDefaults standardUserDefaults];
    [uds removeObjectForKey:@"Cookies"];
    [uds removeObjectForKey:@"tokenKeyAndValue"];
    [uds synchronize];
}

/// 获取cookie
+ (NSArray *)getCookie {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    // NSHTTPCookie 类型数据数组
    return [cookieJar cookies];
}

/// 获取cookie字符串
+ (NSString *)getCookieStr {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSMutableString *cookieStr = [NSMutableString string];
    for (NSHTTPCookie * cookie in cookies) {
        [cookieStr appendFormat:@"%@=%@;", cookie.name, cookie.value];
    }
    NSLog(@"%@", cookieStr);
    
    return cookieStr;
}
/// 封装POST请求
+ (void)post:(NSString *)urlStr
       param:(id)param
     success:(void (^)(NSDictionary *resultDict))success
     failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拒绝自动解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 使用cookie
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    // 设置请求头
    [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [manager.requestSerializer setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [manager.requestSerializer setValue:@"https://www.eduzhixin.com/" forHTTPHeaderField:@"Referer"];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval =10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    /// 读取和设置Cookie
    __block NSUserDefaults *uds = [NSUserDefaults standardUserDefaults];
    NSData *cookiesdata = [uds objectForKey:@"Cookies"];
    NSLog(@"请求前");
    if(cookiesdata.length) {
        NSArray *cookies = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSData class] fromData:cookiesdata error:nil];
        //        for (NSHTTPCookie * cookie in cookies) {
        //            NSLog(@"name:%@, value:%@", cookie.name, cookie.value);
        //        }
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
    
    NSMutableDictionary *mutParam = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)param];
    NSDictionary *urlExt = [uds valueForKey:@"tokenKeyAndValue"];
    [mutParam setValuesForKeysWithDictionary:urlExt];
    NSLog(@"\npostUrl   : %@\nparameter : %@", urlStr, mutParam);
    [manager POST:urlStr
       parameters:mutParam
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
              /// 保存Cookies
              NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
              //              NSLog(@"请求后");
              //              for (NSHTTPCookie * cookie in cookies) {
              //                  NSLog(@"name:%@, value:%@", cookie.name, cookie.value);
              //              }
              if (cookies) {
                  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies requiringSecureCoding:YES error:nil];
                  [uds setObject:data forKey:@"Cookies"];
                  [uds synchronize];
              }
              
              NSError *error = nil;
              /// 解析数字，如果数字在 [10e-128, 10e127] 范围外，解析失败，因为NSNumber放不下区间外的数字，导致解析为 NaN
              NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
              if (success) {
                  success(dict);
              }
              
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
          }];
}

/// 封装GET请求
+ (void)get:(NSString *)urlStr
      param:(id)param
    success:(void (^)(NSDictionary *resultDict))success
    failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拒绝自动解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 使用cookie
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    // 设置请求头
    [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [manager.requestSerializer setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"https://www.eduzhixin.com/" forHTTPHeaderField:@"Referer"];
    /// 读取和设置Cookie
    __block NSUserDefaults *uds = [NSUserDefaults standardUserDefaults];
    NSData *cookiesdata = [uds objectForKey:@"Cookies"];
    NSLog(@"请求前");
    if(cookiesdata.length) {
        NSArray *cookies = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSData class] fromData:cookiesdata error:nil];
        //        for (NSHTTPCookie * cookie in cookies) {
        //            NSLog(@"name:%@, value:%@", cookie.name, cookie.value);
        //        }
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
    NSMutableDictionary *mutParam = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)param];
    NSDictionary *urlExt = [uds valueForKey:@"tokenKeyAndValue"];
    [mutParam setValuesForKeysWithDictionary:urlExt];
    NSLog(@"\npostUrl   : %@\nparameter : %@", urlStr, mutParam);
    NSLog(@"\ngetUrl    : %@\nparameter : %@", urlStr, param);
    [manager GET:urlStr
      parameters:mutParam
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
             /// 保存Cookies
             NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
             //             NSLog(@"请求后");
             //             for (NSHTTPCookie * cookie in cookies) {
             //                 NSLog(@"name:%@, value:%@", cookie.name, cookie.value);
             //             }
             if (cookies) {
                 NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies requiringSecureCoding:YES error:nil];
                 [uds setObject:data forKey:@"Cookies"];
                 [uds synchronize];
             }
             
             NSError *error = nil;
             /// 解析数字，如果数字在 [10e-128, 10e127] 范围外，解析失败，因为NSNumber放不下区间外的数字，导致解析为 NaN
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
             if (success) {
                 success(dict);
             }
            
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
         }];
}
@end
