//
//  WebJSBridgeKit.h
//  cacbos
//
//  Created by Apple on 2017/10/27.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol WebJSBridgeProtocol <JSExport>

/** 邀请 */
- (void)inviteFriend;

/** 被踢（退出并跳转到登录页） */
- (void)logoutAndPushLogin;

/** 登录 */
- (void)pushLogin;

/** 跳转到理财页 */
- (void)goToMoneyManage;

/** 跳转到发现页 */
- (void)logoutAndPushFind;

/** 摇一摇任务:分享 */
- (void)taskShare;

/** 摇一摇任务:投资 */
- (void)taskInvest;

/**    微信分享    **/
- (void)weChatShare;

/**    朋友圈分享    **/
- (void)weChatCircleShare;

/**    短信分享    **/
- (void)smsShare;

/**    更多分享    **/
- (void)moreShare;

/**    我的超级壕友    **/
- (void)getMyPartners;

/** 跳转到摇一摇 */
- (void)goToShake;

/** 生成二维码 */
- (void)showQRCode;

//   风险测评交互方法
- (void)closeOrBackOperation;

-(void)signOut;


@end


typedef void (^WebLoginSuccessCallbackBlock)(void);

@interface WebJSBridgeKit : NSObject <WebJSBridgeProtocol>

@property (nonatomic, copy) WebLoginSuccessCallbackBlock loginSuccessCallback;

- (id)initWithViewController:(UIViewController *)viewController;

@end
