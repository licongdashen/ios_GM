//
//  RequestOperationManager.h
//  cacwallet
//
//  Created by Queen on 2017/4/25.
//  Copyright © 2017年 licong. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>

/**
 请求数据结果block
 **/
typedef void (^successBlock) (id result);
typedef void (^failtureBlock) (id result);

@interface RequestOperationManager : AFHTTPSessionManager

+ (RequestOperationManager *)shareInstance;
+ (RequestOperationManager *)shareInstance1;

/**
 取消所有的网络请求
 */
+ (void)cancelAllOperations;

/**
 取消url对于的task请求

 @param url 待取消的url请求
 */
+ (void)cancelOperation:(NSString*)url;

/**
 用户登录请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)userLoginParametersDic:(NSDictionary *)parameterDic
                      success:(void (^)(NSMutableDictionary *result))successBlock
                     failture:(void (^)(id result))failtureBlock;

/**
 用户注册请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)userRegisterParametersDic:(NSDictionary *)parameterDic
                         success:(void (^)(NSMutableDictionary *result))successBlock
                        failture:(void (^)(id result))failtureBlock;

/**
 获取用户信息接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)getUserInfoParametersDic:(NSDictionary *)parameterDic
                        success:(void (^)(NSMutableDictionary *result))successBlock
                       failture:(void (^)(id result))failtureBlock;

/**
 验证码图片接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)getValidImgParametersDic:(NSDictionary *)parameterDic
                        success:(void (^)(NSMutableDictionary *result))successBlock
                       failture:(void (^)(id result))failtureBlock;


/**
 校验图片验证码接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)checkValidImgParametersDic:(NSDictionary *)parameterDic
                        success:(void (^)(NSMutableDictionary *result))successBlock
                       failture:(void (^)(id result))failtureBlock;

/**
 发送验证码接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)sendTelSmsParametersDic:(NSDictionary *)parameterDic
                       success:(void (^)(NSMutableDictionary *result))successBlock
                      failture:(void (^)(id result))failtureBlock;

/**
 忘记密码接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)forgetPasswordParametersDic:(NSDictionary *)parameterDic
                           success:(void (^)(NSMutableDictionary *result))successBlock
                          failture:(void (^)(id result))failtureBlock;

/**
 检测手机是否注册接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)checkPhoneNumIsRegisterParametersDic:(NSDictionary *)parameterDic
                                    success:(void (^)(NSMutableDictionary *result))successBlock
                                   failture:(void (^)(id result))failtureBlock;

/**
 检测验证码是否正确接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)checkSmsCodeParametersDic:(NSDictionary *)parameterDic
                           success:(void (^)(NSMutableDictionary *result))successBlock
                          failture:(void (^)(id result))failtureBlock;

/**
 总资产接口请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)getTotalAssetsParametersDic:(NSDictionary *)parameterDic
                           success:(void (^)(NSMutableDictionary *result))successBlock
                          failture:(void (^)(id result))failtureBlock;


/**
 检测是否可以测评
 */
+(void)riskAppraisalCheckParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSMutableDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;

#pragma mark - 个人信息页面请求接口
/**
 绑定邮箱接口
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)emailBindingParametersDic:(NSDictionary *)parameterDic
                         success:(void (^)(NSMutableDictionary *result))successBlock
                        failture:(void (^)(id result))failtureBlock;

/**
 更换绑定邮箱检验密码接口
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)exchangEmailCheckPasswordParametersDic:(NSDictionary *)parameterDic
                                      success:(void (^)(NSMutableDictionary *result))successBlock
                                     failture:(void (^)(id result))failtureBlock;

/**
 更换手机绑定接口
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)changPhoneBindParametersDic:(NSDictionary *)parameterDic
                           success:(void (^)(NSMutableDictionary *result))successBlock
                          failture:(void (^)(id result))failtureBlock;

/**
 重置登录密码接口
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)resetPasswordParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock;

/**
 还款计划请求接口
 */
+(void)repaymentPlanParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock;

/**
 投资记录
 */
+(void)getRecordListParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock;
/**
 债权列表
 */
+(void)getClaimsListParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock;
#pragma mark - 首页

/**
 首页接口
 */
+(void)homeParametersDic:(NSDictionary *)parameterDic
                 success:(void (^)(NSMutableDictionary *result))successBlock
                failture:(void (^)(id result))failtureBlock;

/**
 首页消息列表
 */
+(void)requestForUserPrivateMessagesDataWithParametersDict:(NSDictionary *)parameterDic
                                                   success:(void (^)(NSMutableDictionary *result))successBlock
                                                  failture:(void (^)(id result))failtureBlock;
/**
 首页公告列表
 */
+(void)requestForNoticesDataWithParametersDict:(NSDictionary *)parameterDic
                                       success:(void (^)(NSMutableDictionary *result))successBlock
                                      failture:(void (^)(id result))failtureBlock;
/**
 设置消息已读
 */
+(void)requestForSettingMessageReadWithParametersDict:(NSDictionary *)parameterDic
                                              success:(void (^)(NSMutableDictionary *result))successBlock
                                             failture:(void (^)(id result))failtureBlock;
/**
 删除消息
 */
+(void)requestForDeleteMessageWithParametersDict:(NSDictionary *)parameterDic
                                         success:(void (^)(NSMutableDictionary *result))successBlock
                                        failture:(void (^)(id result))failtureBlock;
#pragma mark - 产品列表

/**
 产品列表接口
 */
+(void)productListParametersDic:(NSDictionary *)parameterDic
                 success:(void (^)(NSMutableDictionary *result))successBlock
                failture:(void (^)(id result))failtureBlock;

/**
 产品详情(计划)
 */
+(void)productDetailNewParametersDic:(NSDictionary *)parameterDic
                             success:(void (^)(NSMutableDictionary *result))successBlock
                            failture:(void (^)(id result))failtureBlock;
/**
 产品详情(散标债转)
 */
+(void)productDetailParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock;
/**
 投资页面接口
 */
+(void)investmentParametersDic:(NSDictionary *)parameterDic
                       success:(void (^)(NSMutableDictionary *result))successBlock
                      failture:(void (^)(id result))failtureBlock;
/**
 投资页面预计收益接口
 */
+(void)investmentEarningsParametersDic:(NSDictionary *)parameterDic
                       success:(void (^)(NSMutableDictionary *result))successBlock
                      failture:(void (^)(id result))failtureBlock;
/**
 发起投资接口
 */
+(void)confirmInvestParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSMutableDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock;

/**
 我的投资列表
 */
+(void)userInvestListParametersDic:(NSDictionary *)parameterDic
                        success:(void (^)(NSMutableDictionary *result))successBlock
                       failture:(void (^)(id result))failtureBlock;

/**
 我的投资计划列表
 */
+(void)userInvestPlanListParametersDic:(NSDictionary *)parameterDic
                           success:(void (^)(NSMutableDictionary *result))successBlock
                          failture:(void (^)(id result))failtureBlock;

/**
 我的投资计划详情
 */
+(void)userInvestPlanDetailsParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSMutableDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;

/**
 我的投资散标列表
 */
+(void)userInvestScatLoanListParametersDic:(NSDictionary *)parameterDic
                                  success:(void (^)(NSMutableDictionary *result))successBlock
                                 failture:(void (^)(id result))failtureBlock;

/**
 我的投资散标详情
 */
+(void)userInvestScatLoanDetailsParametersDic:(NSDictionary *)parameterDic
                                   success:(void (^)(NSMutableDictionary *result))successBlock
                                  failture:(void (^)(id result))failtureBlock;
#pragma mark - 发现

/**
 发现主页面
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForFindViewDataWithParametersDict:(NSDictionary *)parameterDic
                                        success:(void (^)(NSMutableDictionary *result))successBlock
                                       failture:(void (^)(id result))failtureBlock;
#pragma mark - 我的主页面
/**
 我的主页面
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForMineViewDataWithParametersDict:(NSDictionary *)parameterDic
                                        success:(void (^)(NSMutableDictionary *result))successBlock
                                       failture:(void (^)(id result))failtureBlock;
/**
 交易明细页面
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForUserTransactionInfoWithParametersDict:(NSDictionary *)parameterDic
                                               success:(void (^)(NSMutableDictionary *result))successBlock
                                              failture:(void (^)(id result))failtureBlock;

/**
 校验用户余额是否可用
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForCheckUserAvailableAmountWithParametersDict:(NSDictionary *)parameterDic
                                                    success:(void (^)(NSMutableDictionary *result))successBlock
                                                   failture:(void (^)(id result))failtureBlock;

/**
 充值页面数据展示
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForRechargeViewDataWithParametersDict:(NSDictionary *)parameterDic
                                            success:(void (^)(NSMutableDictionary *result))successBlock
                                           failture:(void (^)(id result))failtureBlock;

/**
 赎回页面数据展示
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForRedeemViewDataWithParametersDict:(NSDictionary *)parameterDic
                                          success:(void (^)(NSMutableDictionary *result))successBlock
                                         failture:(void (^)(id result))failtureBlock;
/**
 赎回列表页面
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForRedeemRecordListWithParametersDict:(NSDictionary *)parameterDic
                                            success:(void (^)(NSMutableDictionary *result))successBlock
                                           failture:(void (^)(id result))failtureBlock;
/**
 卡券列表页面
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForUserCardVoucherListWithParametersDict:(NSDictionary *)parameterDic
                                               success:(void (^)(NSMutableDictionary *result))successBlock
                                              failture:(void (^)(id result))failtureBlock;

/**
 债转列表
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForCreditAssignmentListWithParametersDict:(NSDictionary *)parameterDic
                                                success:(void (^)(NSMutableDictionary *result))successBlock
                                               failture:(void (^)(id result))failtureBlock;

/**
 发起债转确认信息
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForCreditAssignmentCheckWithParametersDict:(NSDictionary *)parameterDic
                                                 success:(void (^)(NSMutableDictionary *result))successBlock
                                                failture:(void (^)(id result))failtureBlock;

/**
 发起债转
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForCreditAssignmentWithParametersDict:(NSDictionary *)parameterDic
                                            success:(void (^)(NSMutableDictionary *result))successBlock
                                           failture:(void (^)(id result))failtureBlock;

/**
 用户借款信息
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForUserLoanWithParametersDict:(NSDictionary *)parameterDic
                                    success:(void (^)(NSMutableDictionary *result))successBlock
                                   failture:(void (^)(id result))failtureBlock;
/**
 用户银行卡列表
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)requestForUserBankCardListWithParametersDict:(NSDictionary *)parameterDic
                                            success:(void (^)(NSMutableDictionary *result))successBlock
                                           failture:(void (^)(id result))failtureBlock;
/**
 上传头像接口
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)uplordingHeadShotParametersDic:(NSDictionary *)parameterDic
                              success:(void (^)(NSMutableDictionary *result))successBlock
                             failture:(void (^)(id result))failtureBlock;
@end
