//
//  Net_Url.h
//  tiku
//
//  Created by zhixinB on 2019/5/6.
//  Copyright © 2019 zhixinB. All rights reserved.
//

#ifndef Net_Url_h
#define Net_Url_h
//正式环境
#define SafeNetUrl @"https://api.eduzhixin.com/v1/"
//正式环境登录
#define LoginUrl @"https://passport.eduzhixin.com/v1/"
//测试服-----2018.6.4最新版
#define SafeNetUrl_Alpha @"https://www.upho2015.com/v1/"
//测试服登录
#define LoginUrl_Alpha @"https://passport.upho2015.com/v1/"

#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)
/** 网站基础URL */
#define BASEURL(urlStr) [NSString stringWithFormat:@"%@%@", SafeNetUrl_Alpha, urlStr]
/** 仅仅限登录URL */
#define APIURL(urlStr) [NSString stringWithFormat:@"%@%@", LoginUrl_Alpha, urlStr]


#else
#define NSLog(...) {}
/** 网站基础URL */
#define BASEURL(urlStr) [NSString stringWithFormat:@"%@%@", SafeNetUrl, urlStr]

#define APIURL(urlStr) [NSString stringWithFormat:@"%@%@", LoginUrl, urlStr]
#endif
#define GetMultiQuestions_URL BASEURL(@"Question/getMultiQuestions")
#define NewLOGIN_URL APIURL(@"Auth/access")
#endif /* Net_Url_h */
