//
//  RequestOperationManager.m
//  cacwallet
//
//  Created by Queen on 2017/4/25.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "RequestOperationManager.h"
@interface RequestOperationManager()

@property (nonatomic, strong) NSString *urlPath;

@end

@implementation RequestOperationManager

// 保存当前任务的字典，key为请求的url，value为请求的task
static NSMutableDictionary *tasks;

static RequestOperationManager *sessionManager;

static RequestOperationManager *sessionManager1;

+ (RequestOperationManager *)shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sessionManager = [[RequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:DEF_IPAddress]];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html",@"application/octet-stream",@"image/jpeg",@"image/png", nil];
        sessionManager.requestSerializer.timeoutInterval = DEF_WEB_REQUEST_TIMEOUT;
        tasks = [NSMutableDictionary dictionaryWithCapacity:0];

    });
    
    return sessionManager;
}

+ (RequestOperationManager *)shareInstance1
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sessionManager1 = [[RequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://file.zhaomingedu.com/doc/upload"]];
        sessionManager1.responseSerializer = [AFJSONResponseSerializer serializer];
        sessionManager1.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html",@"application/octet-stream",@"image/jpeg",@"image/png", nil];
        sessionManager1.requestSerializer.timeoutInterval = DEF_WEB_REQUEST_TIMEOUT;
        
    });
    
    return sessionManager;
}

+ (void)cancelAllOperations
{
    [[self shareInstance].operationQueue cancelAllOperations];
}


/**
 取消当前的任务

 @param url 任务的url(不包含base部分)
 */
+ (void)cancelOperation:(NSString*)url
{
    if ([DEF_OBJECT_TO_STIRNG(url) isEqualToString:@""]) {
        return;
    }
    
    url = [NSString stringWithFormat:@"%@%@", DEF_IPAddress, url];
    
    if ([tasks.allKeys containsObject:url]) {
        NSURLSessionTask *task = tasks[url];
        if (task) {
            [task cancel];
        }
        [tasks removeObjectForKey:url];
    }
}

//请求错误处理
+ (void)requestError:(NSError *)error task:(NSURLSessionDataTask *_Nonnull)task failHandle:(failtureBlock)failHandle
{
    if(error.code == kCFURLErrorNotConnectedToInternet)
    {
        [CACUtility showTips:@"网络不可用，请检查网络连接"];
    }else if (error.code == kCFURLErrorTimedOut)
    {
        [CACUtility showTips:@"网络请求超时"];
    }else if (error.code == kCFURLErrorCannotConnectToHost)
    {
        [CACUtility showTips:@"网络不可用，请检查网络连接"];
    }else
    {
        NSLog(@"responseError===%@",error);
    }
    NSLog(@"responseError===%@",error);
    
    failHandle(error);
}

//请求成功处理
+ (void)requestSuccess:(id)responseObject task:(NSURLSessionDataTask *_Nonnull)task finishHandle:(successBlock)finishHandle
{
    if (!responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            finishHandle(nil);
        });
        return;
    }
    NSLog(@"responseDic===%@",responseObject);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
        if ([DEF_OBJECT_TO_STIRNG(responseObject[@"returnCode"]) isEqualToString:@"7200"]) {
            [dic setObject:@"" forKey:@"returnMessage"];
            [[NSNotificationCenter defaultCenter] postNotificationName:DEF_USERBYPLAY_NOTIFICATION object:responseObject[@"returnMessage"]];
        }else{
           
        }
        
        finishHandle(dic);
    });
}

//log请求的url
+ (void)logUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters
{
 
    sessionManager.urlPath = urlPath;
    
    NSMutableString *tempUrl = [NSMutableString stringWithFormat:@"%@", urlPath];
    for (int i=0; i<parameters.allKeys.count; i++) {
        if (i > 0) {
            [tempUrl appendString:@"&"];
        } else {
            [tempUrl appendString:@"?"];
        }
        [tempUrl appendFormat:@"%@=%@", parameters.allKeys[i], parameters.allValues[i]];
    }
    NSLog(@"requestUrl:%@",tempUrl);
}

//get请求
+ (AFHTTPSessionManager *)requestGetWithParameters:(NSDictionary *)parameters
                                         urlString:(NSString *)urlString
                                      finishHandle:(successBlock)finishHandle
                                        failHandle:(failtureBlock)failHandle
{
    AFHTTPSessionManager *manager = [RequestOperationManager shareInstance];
    
    [RequestOperationManager logUrlPath:urlString parameters:parameters];
    
    NSURLSessionTask *task = [manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [tasks removeObjectForKey:urlString];
        
        [RequestOperationManager requestSuccess:responseObject task:task finishHandle:finishHandle];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [tasks removeObjectForKey:urlString];
        
        [RequestOperationManager requestError:error task:task failHandle:failHandle];
    }];
    
    // 添加到任务字典中保存
    [self cancelOperation:urlString];
    [tasks setObject:task forKey:urlString];
    
    return manager;
}

//post请求
+ (AFHTTPSessionManager *)requestPostWithParameters:(NSDictionary *)parameters
                                          urlString:(NSString *)urlString
                                       finishHandle:(void (^)(id result))finishHandle
                                         failHandle:(void (^)(id result))failHandle
{
    AFHTTPSessionManager *manager = [RequestOperationManager shareInstance];
    
    [RequestOperationManager logUrlPath:urlString parameters:parameters];
    
    NSURLSessionTask *task = [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [tasks removeObjectForKey:urlString];
        
        [RequestOperationManager requestSuccess:responseObject task:task finishHandle:finishHandle];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [tasks removeObjectForKey:urlString];
        
        [RequestOperationManager requestError:error task:task failHandle:failHandle];
    }];
    
    // 添加到任务字典中保存
    [self cancelOperation:urlString];
    [tasks setObject:task forKey:urlString];
    
    return manager;
}

//带图片的post请求
+ (AFHTTPSessionManager *)requestPostImageWithParameters:(NSDictionary *)parameters
                                               urlString:(NSString *)urlString
                                            finishHandle:(successBlock)finishHandle
                                              failHandle:(failtureBlock)failHandle
{
    AFHTTPSessionManager *manager = [RequestOperationManager shareInstance1];

    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [para removeObjectForKey:@"pics"];
    
    [RequestOperationManager logUrlPath:urlString parameters:parameters];

    NSURLSessionTask *task = [manager POST:urlString parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSArray *keys = [parameters[@"pics"] allKeys];
        
        for (NSString *key in keys)
        {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(parameters[@"pics"][key], 1.0f) name:key fileName:@"file.jpeg" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
         NSLog(@"上传进度:%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [tasks removeObjectForKey:urlString];
        
        [RequestOperationManager requestSuccess:responseObject task:task finishHandle:finishHandle];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [tasks removeObjectForKey:urlString];
        
        [RequestOperationManager requestError:error task:task failHandle:failHandle];
    }];
    
    // 添加到任务字典中保存
    [self cancelOperation:urlString];
    [tasks setObject:task forKey:urlString];
    
    return manager;
}


/**
 请求测试的数据
 
 @param parameters 请求参数
 @param urlString 请求的完整连接
 @param finishHandle 成功回调
 @param failHandle 失败回调
 */
+ (void)requestPostLocalData:(NSDictionary *)parameters
                   urlString:(NSString *)urlString
                finishHandle:(successBlock)finishHandle
                  failHandle:(failtureBlock)failHandle
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html",@"application/octet-stream",@"image/jpeg",@"image/png", nil];
    manager.requestSerializer.timeoutInterval = DEF_WEB_REQUEST_TIMEOUT;
    
    [manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [RequestOperationManager requestSuccess:responseObject task:task finishHandle:finishHandle];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [RequestOperationManager requestError:error task:task failHandle:failHandle];
    }];
}

/**
 用户登录请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)userLoginParametersDic:(NSDictionary *)parameterDic
                      success:(void (^)(NSMutableDictionary *result))successBlock
                     failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_LOGIN
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 用户注册请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)userRegisterParametersDic:(NSDictionary *)parameterDic
                         success:(void (^)(NSMutableDictionary *result))successBlock
                        failture:(void (^)(id result))failtureBlock{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_REGISTER
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
    
}

/**
 获取用户信息接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)getUserInfoParametersDic:(NSDictionary *)parameterDic
                        success:(void (^)(NSMutableDictionary *result))successBlock
                       failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_GET_USERINFO
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
    
}

/**
 图片验证码接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)getValidImgParametersDic:(NSDictionary *)parameterDic
                        success:(void (^)(NSMutableDictionary *result))successBlock
                       failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_GETVALIDIMG
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 校验图片验证码接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)checkValidImgParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_CHECKVALIDIMG
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 发送验证码接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)sendTelSmsParametersDic:(NSDictionary *)parameterDic
                       success:(void (^)(NSMutableDictionary *result))successBlock
                      failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_SENDTELSMS
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
    
}

/**
 忘记密码接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)forgetPasswordParametersDic:(NSDictionary *)parameterDic
                           success:(void (^)(NSMutableDictionary *result))successBlock
                          failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_FORGETPASSWORD
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
    
}

/**
 检测手机是否注册接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)checkPhoneNumIsRegisterParametersDic:(NSDictionary *)parameterDic
                                    success:(void (^)(NSMutableDictionary *result))successBlock
                                   failture:(void (^)(id result))failtureBlock{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_CHECKISREGISTER
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
    
}
/**
 检测验证码是否正确接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)checkSmsCodeParametersDic:(NSDictionary *)parameterDic
                         success:(void (^)(NSMutableDictionary *result))successBlock
                        failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_CHECKSMSCODE
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}


/**
 总资产接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)getTotalAssetsParametersDic:(NSDictionary *)parameterDic
                           success:(void (^)(NSMutableDictionary *result))successBlock
                          failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_GET_TOTALASSETS
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
    
}

+(void)riskAppraisalCheckParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSMutableDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_RISKAPPRAISAL_CEHCK
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

#pragma mark - 个人信息页面请求接口
/**
 绑定邮箱接口
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)emailBindingParametersDic:(NSDictionary *)parameterDic
                         success:(void (^)(NSMutableDictionary *result))successBlock
                        failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_EMAILBIND
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 更换绑定邮箱检验密码接口
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)exchangEmailCheckPasswordParametersDic:(NSDictionary *)parameterDic
                                      success:(void (^)(NSMutableDictionary *result))successBlock
                                     failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_EXCHANGEEMAIL_CHECKPSD
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
    
}

/**
 更换手机绑定接口
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)changPhoneBindParametersDic:(NSDictionary *)parameterDic
                           success:(void (^)(NSMutableDictionary *result))successBlock
                          failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_CHANGE_PHONEBIND
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 重置登录密码接口
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)resetPasswordParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_RESET_PASSWORD
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
    
}



/**
 还款计划请求接口
 */
+(void)repaymentPlanParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_REPAYMENTPLAN
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

+(void)getRecordListParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_RECORDLIST
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 债权列表
 */
+(void)getClaimsListParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock{
   
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString: DEF_API_CLAIMSLIST
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
    
}


/**
 首页接口
 */
+(void)homeParametersDic:(NSDictionary *)parameterDic
                 success:(void (^)(NSMutableDictionary *result))successBlock
                failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_HOME
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 首页消息
 */
+(void)requestForUserPrivateMessagesDataWithParametersDict:(NSDictionary *)parameterDic
                                                   success:(void (^)(NSMutableDictionary *result))successBlock
                                                  failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_PRIVATEMESSAGES
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}
/**
 首页公告列表
 */
+(void)requestForNoticesDataWithParametersDict:(NSDictionary *)parameterDic
                                       success:(void (^)(NSMutableDictionary *result))successBlock
                                      failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_NOTICES
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 设置消息已读
 */
+(void)requestForSettingMessageReadWithParametersDict:(NSDictionary *)parameterDic
                                              success:(void (^)(NSMutableDictionary *result))successBlock
                                             failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_PRIVATEMESSAGES_SETTINGREAD
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 删除消息
 */
+(void)requestForDeleteMessageWithParametersDict:(NSDictionary *)parameterDic
                                         success:(void (^)(NSMutableDictionary *result))successBlock
                                        failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_PRIVATEMESSAGES_DELETE
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}
#pragma mark - 产品列表
/**
 产品列表接口
 */
+(void)productListParametersDic:(NSDictionary *)parameterDic
                        success:(void (^)(NSMutableDictionary *result))successBlock
                       failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_PRODUCTLIST
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}
/**
 产品详情(计划)
 */
+(void)productDetailNewParametersDic:(NSDictionary *)parameterDic
                             success:(void (^)(NSMutableDictionary *result))successBlock
                            failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_NEWLOANDETAIL
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 产品详情(散标债转)
 */
+(void)productDetailParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_LOANDETAIL
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 投资页面接口
 */
+(void)investmentParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_INVESTMENT
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 发起投资接口
 */
+(void)confirmInvestParametersDic:(NSDictionary *)parameterDic
                       success:(void (^)(NSMutableDictionary *result))successBlock
                      failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_CONFIRINVESTMENT
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 投资页面预计收益接口
 */
+(void)investmentEarningsParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSMutableDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_INVESTMENTEARNINGS
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 我的投资列表
 */
+(void)userInvestListParametersDic:(NSDictionary *)parameterDic
                           success:(void (^)(NSMutableDictionary *result))successBlock
                          failture:(void (^)(id result))failtureBlock{
   
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_USERINVEST_LIST
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 我的投资计划列表
 */
+(void)userInvestPlanListParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSMutableDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
   
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_USERINVEST_PLAN_LIST
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 我的投资计划详情
 */
+(void)userInvestPlanDetailsParametersDic:(NSDictionary *)parameterDic
                                  success:(void (^)(NSMutableDictionary *result))successBlock
                                 failture:(void (^)(id result))failtureBlock{
   
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_USERINVEST_PLAN_DETAIL
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 我的投资散标列表
 */
+(void)userInvestScatLoanListParametersDic:(NSDictionary *)parameterDic
                                   success:(void (^)(NSMutableDictionary *result))successBlock
                                  failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_USERINVEST_SCALOAN_LIST
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

/**
 我的投资散标详情
 */
+(void)userInvestScatLoanDetailsParametersDic:(NSDictionary *)parameterDic
                                      success:(void (^)(NSMutableDictionary *result))successBlock
                                     failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_USERINVEST_SCALOAN_DETAIL
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

#pragma mark - 发现
+(void)requestForFindViewDataWithParametersDict:(NSDictionary *)parameterDic
                                        success:(void (^)(NSMutableDictionary *result))successBlock
                                       failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_FIND
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

#pragma mark - 我的
+(void)requestForMineViewDataWithParametersDict:(NSDictionary *)parameterDic
                                        success:(void (^)(NSMutableDictionary *result))successBlock
                                       failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_MINE
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

+(void)requestForUserTransactionInfoWithParametersDict:(NSDictionary *)parameterDic
                                               success:(void (^)(NSMutableDictionary *result))successBlock
                                              failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_USERTRANSACTIONINFO
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

+(void)requestForCheckUserAvailableAmountWithParametersDict:(NSDictionary *)parameterDic
                                                    success:(void (^)(NSMutableDictionary *result))successBlock
                                                   failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_USERAVAILABLEAMOUNTCHECK
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

+(void)requestForRechargeViewDataWithParametersDict:(NSDictionary *)parameterDic
                                            success:(void (^)(NSMutableDictionary *result))successBlock
                                           failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_RECHARGEPAGE
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

+(void)requestForRedeemViewDataWithParametersDict:(NSDictionary *)parameterDic
                                          success:(void (^)(NSMutableDictionary *result))successBlock
                                         failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_REDEEMPAGE
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

+(void)requestForRedeemRecordListWithParametersDict:(NSDictionary *)parameterDic
                                            success:(void (^)(NSMutableDictionary *result))successBlock
                                           failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_REDEEMRECORDLIST
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

+(void)requestForUserCardVoucherListWithParametersDict:(NSDictionary *)parameterDic
                                               success:(void (^)(NSMutableDictionary *result))successBlock
                                              failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_USERCARDVOUCHER
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}
+(void)requestForCreditAssignmentListWithParametersDict:(NSDictionary *)parameterDic
                                                success:(void (^)(NSMutableDictionary *result))successBlock
                                               failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_CREDITASSIGNMENT_LIST
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

+(void)requestForCreditAssignmentCheckWithParametersDict:(NSDictionary *)parameterDic
                                                 success:(void (^)(NSMutableDictionary *result))successBlock
                                                failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_CREDITASSIGNMENT_CHECK
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}
+(void)requestForCreditAssignmentWithParametersDict:(NSDictionary *)parameterDic
                                            success:(void (^)(NSMutableDictionary *result))successBlock
                                           failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_CREDITASSIGNMENT
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}

+(void)requestForUserLoanWithParametersDict:(NSDictionary *)parameterDic
                                    success:(void (^)(NSMutableDictionary *result))successBlock
                                   failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_USERLOAN
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}
+(void)requestForUserBankCardListWithParametersDict:(NSDictionary *)parameterDic
                                            success:(void (^)(NSMutableDictionary *result))successBlock
                                           failture:(void (^)(id result))failtureBlock {
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:DEF_API_USEBANKCARD_LIST
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}


/**
 上传头像接口
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)uplordingHeadShotParametersDic:(NSDictionary *)parameterDic
                              success:(void (^)(NSMutableDictionary *result))successBlock
                             failture:(void (^)(id result))failtureBlock{
    
    [RequestOperationManager requestPostImageWithParameters:parameterDic
                                                  urlString:@""
                                               finishHandle:^(id result) {
                                                   successBlock(result);
                                               } failHandle:^(id result) {
                                                   failtureBlock(result);
                                               }];
}
@end

