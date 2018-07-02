//
//  ConstantDefineHeader.h
//  cacwallte
//
//  Created by Gandalf on 2017/4/26.
//  Copyright © 2017年 licong. All rights reserved.
//

#ifndef ConstantDefineHeader_h
#define ConstantDefineHeader_h

// app在后台的时间长度，默认5分钟
//(60 * 5)(2017年11月29日14:49:45,当前app进入后台不做超时逻辑)
#define DEF_DURATION_WHEN_IN_BACKGROUND INT_MAX
// app在后台的时间超过一分钟，则需要验证手势或指纹
// 60
#define DEF_DURATION_WHEN_NEED_RECHECK  INT_MAX
// 保存app在后台的时间
#define DEF_APP_START_UP_TIME           @"app_start_up_time"

// 网络状态
#define DEF_NETWORK_AVAILABLE           @"system_network_available"

// 远程通知
#define DEF_USER_REMOTE_NOTIFICATION    @"user_remote_notification"
#define DEF_REMOTE_NOTIFICATION_DATA    @"remote_notification_data"

/**
 * 启动广告页
 */
#define DEF_LOAD_AD_IMAGE_NAME          @"load_ad_imagename"
#define DEF_LOAD_AD_TARGET              @"load_ad_h5_target"

//保存登录用户的手机号，再次登录时直接
#define SAVE_LOGIN_USER_PHONE_NUM          @"Last_Login_Success_Phone_Num"

#define SAVE_REGISTER_SEL               @"Register_Success_Save_sel"
#define SAVE_REGISTER_USERNAME           @"Register_Success_Save_username"
#define SAVE_REGISTER_PASSWORLD           @"Register_Success_Save_passworld"
#define TYPE_USER           @"type_user"

//保存用户密码的MD5加密
#define SAVE_LOGIN_PWD_MD5                  @"save_login_pwd_md5"

//保存联系人的userID
#define SAVE_REGISTER_INVITER_USERID       @"Register_Success_Save_Inviter_UserID"

#define SAVE_REGISTER_ARR       @"Register_Success_Save_arr"

//JS回调对象名称
#define DEF_JS_CALLBACK_OBJ_NAME    @"CallJsOperator"

// 网络请求的超时时间
#define DEF_WEB_REQUEST_TIMEOUT     60

// 提示框展示时间
#define DEF_ERROR_MESSAGE_SHOW_TIME  1.5

// app版本
#define DEF_LAST_APP_VERSION             @"app_version"

// 手势密码
//#define DEF_GESTURE_PASSWORD            @"gesture_password"
#define DEF_GESTURE_AESKEY              @"FinanceGesturePassword"
//#define DEF_GESTURE_SHOW_PATH           @"show_path"

// 指纹
#define DEF_FINGERPRINT_PASSWORD        @"fingerprint_password"


//app id
#define APPSTORE_ID                     @"1226300577"

// 网络请求返回的数据类型
#define RequestOperationDataTask        NSURLSessionDataTask

// 还款日历
// 还款日历
#define MAX_YEAR                        30
#define LINE_COUNT                      3
#define MONTH_COUNT                     13
#define CELL_WIDTH                      ([UIScreen mainScreen].bounds.size.width / 6)
#define OFFSET                          (CELL_WIDTH * 0.0)
#define RIGHT_MARGIN                    15
#define JOINT_BTN_WIDTH                 15
#define GRAPH_MAX_HEIGHT                120

#define DEF_REFRESHCODE_NOTIFICATION    @"refreshImageCode_notification"

#define CALENDER_SCROLL_NOTIFICATION     @"CALENDER_SCROLL_NOTIFICATION"
#define MONTH_SCROLL_NOTIFICATION        @"MONTH_SCROLL_NOTIFICATION"
#define LEFT_ACTION                      @"LEFT_ACTION"
#define RIGHT_ACTION                     @"RIGHT_ACTION"
#define VALID_ACTION                     @"VALID_ACTION"

#define CALENDER_SINGLE_UPDATE_NOTIFICATION @"CALENDER_SINGLE_UPDATE_NOTIFICATION"
#define CALENDER_WHOLE_UPDATE_NOTIFICATION  @"CALENDER_WHOLE_UPDATE_NOTIFICATION"

struct SwipeAction {
    int currentCellTag;
    int selectedTag;
};

#define DEF_PAGE_SIZE                       10

#define DEF_DOT_NUMBERS                 @"0123456789.\n"
#define DEF_NUMBERS                     @"0123456789\n"

//判断用户是否App是否首次使用
#define DEF_APP_FIRST_USAGE                 @"APP_FIRST_USAGE"

//判断用户首次使用, 是否需要弹出"安全提示"
#define DEF_APP_FIRST_USAGE_SAFE_HINT       @"APP_FIRST_USAGE_SAFE_HINT"

#endif /* ConstantDefineHeader_h */
