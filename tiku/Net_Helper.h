//
//  Net_Helper.h
//  tiku
//
//  Created by zhixinB on 2019/5/6.
//  Copyright © 2019 zhixinB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN

@interface Net_Helper : NSObject
// 清空Cookie
+ (void)clearCookie;
// 获取cookie
+ (NSArray *)getCookie;
// 获取cookie字符串
+ (NSString *)getCookieStr;
// 封装POST请求（返回字典）
+ (void)post:(NSString *)urlStr
       param:(id)param
     success:(void (^)(NSDictionary *resultDict))success
     failure:(void (^)(NSError *error))failure;

// 封装GET请求（返回字典）
+ (void)get:(NSString *)urlStr
      param:(id)param
    success:(void (^)(NSDictionary *resultDict))success
    failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
