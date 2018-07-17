//
//  ConfigDefineHeader.h
//  cacwallet
//
//  Created by Queen on 2017/4/19.
//  Copyright © 2017年 licong. All rights reserved.
//

#ifndef ConfigDefineHeader_h
#define ConfigDefineHeader_h

#define DEF_WEB_REQUEST_TIMEOUT     15

//#define DEF_IPAddress          @"https://cgapp.chaoaicai.com"

//RAP模拟环境
//@"http://172.16.21.240:6789"

//测试环境ip地址
#define DEF_IPAddress           @"http://140.143.193.19:8080/"

//张最本地ip地址
//#define DEF_IPAddress          @"http://172.16.21.58:8022"

//亚楠本地ip地址
//#define DEF_IPAddress          @"http://172.16.21.85:8022"
// 刘孝春
//#define DEF_IPAddress          @"http://172.16.21.46:8022"

//测试HTML地址
#define DEF_HTML_IPAddress      @"http://test1-live.chaoaicai.com"
//预发布HTML地址
//#define DEF_HTML_IPAddress      @"http://prelive.chaoaicai.com"
//正式HTML地址
//#define DEF_HTML_IPAddress      @"http://live.chaoaicai.com"

#pragma mark - 友盟appKey
//友盟测试Key
//#define UMENG_APPKEY        @"55fbc534e0f55aed13004eed"
static NSString *const UMENG_APPKEY = @"5a55ab57a40fa36edc000103";

//友盟正式Key
//#define UMENG_APPKEY        @"564aec82e0f55ab194000e21"
//static NSString *const UMENG_APPKEY = @"564aec82e0f55ab194000e21";

//growing 测试key
#define GROWING_KEY         @"b93dab62d0b5618b"

//growing 正式key
//#define GROWING_KEY         @"882bec76dec881d8"

#pragma mark - 第三方appKey

//微信appId
#define WEIXIN_APP_ID       @"wx2618284a5d01d1a2"
//微信appSecret
#define WEIXIN_APP_SECRET   @"d4624c36b6795d1d99dcf0547af5443d"

//QQ appId
#define QQ_APP_ID           @"1104919850"
//QQ appKey
#define QQ_APP_KEY          @"8z9BpzZpzz0nLqqL"

//智齿key
#define SOBOKIT_KEY         @"12363511e42243cc9a3e844d63d8cdc7"

#define BASE_URL_NOTICE  @"http://api.sdcen.cn/mobile/api/schoolnotice.aspx"
#define BASE_URL_COURSE_NOTICE  @"http://api.sdcen.cn/mobile/api/coursenotice.aspx"

#define BASE_URL_NOTICE1  @"http://api.sdcen.cn/mobile/api/Homework.aspx"
#define BASE_URL_COURSE_NOTICE1  @"http://api.sdcen.cn/mobile/api/HomeworkRecord.aspx"

#define BASE_URL_NOTICE2  @"http://api.sdcen.cn/mobile/api/Exam.aspx"
#define BASE_URL_COURSE_NOTICE2  @"http://api.sdcen.cn/mobile/api/ExamRecord.aspx"

//首页
#define DEF_API_HOME             @"api/GetEbookCatalog"             //首页接口
#define DEF_API_NOTICES    @"api/GetEbookmarkList"   // 用户公告列表
#define DEF_API_PRIVATEMESSAGES    @"api/new/MyCourse"   // 用户消息列表
#define DEF_API_PRIVATEMESSAGES_SETTINGREAD    @"api/AddEbookmark"   // 设置消息已读
#define DEF_API_PRIVATEMESSAGES_DELETE    @"api/GetHomeworkList"   // 删除消息

//产品
#define DEF_API_PRODUCTLIST            @"api/GetHomeworkInfo"           //产品列表
#define DEF_API_NEWLOANDETAIL          @"api/GetCourseInfo"           //产品详情(计划)
#define DEF_API_LOANDETAIL             @"api/GetSchoolNotices"           //产品详情(债转/散标)
#define DEF_API_INVESTMENT             @"api/GetCourseNotices"           //投资页面接口
#define DEF_API_INVESTMENTEARNINGS     @"api/GetExamPaperList"     //投资页面预计收益接口
#define DEF_API_CONFIRINVESTMENT       @"api/new/MyExam"       //发起投资接口

// 发现
#define DEF_API_FIND    @"api/GetExamPaperInfo" // 发现主页
#define DEF_API_MINE    @"api/GetUserInfo" // 我的主页

// 交易明细
#define DEF_API_USERTRANSACTIONINFO    @"api/UpdatePassword" // 交易明细

// 用户余额检验
#define DEF_API_USERAVAILABLEAMOUNTCHECK   @"api/GetEbookList" // 判断金额是否可用

// 充值提现
#define DEF_API_RECHARGEPAGE @"api/UpdateLogInfo"   // 充值界面显示
#define DEF_API_REDEEMPAGE    @"api/GetCellInfo" // 赎回界面显示
#define DEF_API_REDEEMRECORDLIST    @"api/GetCommentRate" // 赎回记录列表

// 我的卡券
#define DEF_API_USERCARDVOUCHER @"api/CommentRate"   // 我的卡券列表

//我的投资
//我的投资列表
#define DEF_API_USERINVEST_LIST            @"api/new/MyScore"
//我的投资计划列表
#define DEF_API_USERINVEST_PLAN_LIST       @"api/GetEbookInfo"
//我的投资计划详情
#define DEF_API_USERINVEST_PLAN_DETAIL     @"api/GetAnswerCount"
//我的投资散标列表
#define DEF_API_USERINVEST_SCALOAN_LIST    @"api/GetPaperAnswerCount"
//我的投资散标详情
#define DEF_API_USERINVEST_SCALOAN_DETAIL  @"api/GetScoreInfo"

// 债权转让列表
#define DEF_API_CREDITASSIGNMENT_LIST @"api/AddProblem"   // 债权转让列表
#define DEF_API_CREDITASSIGNMENT_CHECK @"api/UpdateNote"   // 发起债权转让确认接口
#define DEF_API_CREDITASSIGNMENT @"api/GetNote"   // 发起债权转让接口

#define DEF_API_USERLOAN @"api/GetIntroduction"   // 我的借款信息

#define DEF_API_USEBANKCARD_LIST @"api/GetCourseeProcess"   // 我的银行卡信息

// 登录 注册
#define DEF_API_LOGIN            @"api/v1/cars"           //登录接口
#define DEF_API_REGISTER         @"api/v1/experience"     //注册接口
#define DEF_API_GETVALIDIMG      @"api/v1/login"       //请求图片验证码接口
#define DEF_API_CHECKVALIDIMG    @"api/RrfreshInteractiveScore"      //校验图片验证码接口
#define DEF_API_SENDTELSMS       @"api/new/AddEbookOrder"        //请求短信验证码接口
#define DEF_API_CHECKSMSCODE     @"api/GetForgetPwdVeryCode"    //校验短信验证码接口
#define DEF_API_FORGETPASSWORD   @"/api/SetPhone"  //忘记密码接口
#define DEF_API_CHECKISREGISTER  @"/api/ucsLogin/checkPhoneNo.app"    //检测手机号是否注册接口
#define DEF_API_GET_USERINFO     @"api/getschoollist"     //获取用户信息接口
#define DEF_AIP_UPLORDINGHEADSHOT      @"upload"    // 上传头像接口

// 个人信息
#define DEF_API_EMAILBIND              @"api/new/TeacherExamRoom"    // 绑定邮箱接口
#define DEF_API_EXCHANGEEMAIL_CHECKPSD @"api/new/EaxmRoomStu"  // 检验密码接口
#define DEF_API_RESET_PASSWORD         @"api/new/SetExamStatus"   // 重置登录密码接口
#define DEF_API_CHANGE_PHONEBIND       @"api/new/FaceVerify"   // 更换手机绑定接口

#define DEF_API_GET_TOTALASSETS        @"api/new/GetExamStuInfo"    //获得用户总资产接口

#define DEF_API_REPAYMENTPLAN           @"api/new/GetSpecialCourseInfo"        //还款计划
#define DEF_API_RECORDLIST              @"api/new/RSASign"        //投资记录
#define DEF_API_CLAIMSLIST              @"api/new/GetPrepayId"     //债权列表

#define DEF_API_RISKAPPRAISAL_CEHCK      @"api/new/AddOrder"   //检测是否可以风险测评
#define DEF_API_RISKAPPRAISAL_INDEX      @"/app/riskEvaluation/index.html"      //风险测评页
#define DEF_API_RISKAPPRAISAL_RESULT     @"/app/riskEvaluation/result.html"     //风险测评结果页

#define DEF_API_WEBMIDLEPAGE             @"/app/middlePage.html"                //包括开户等

#define DEF_SAFEHTML                     @"/shCg/app/safeAssurance.html"      //安全保障HTML

#define DEF_CARDINFO                     @"/shCg/app/app_ithaca_state.html"      //卡券说明HTML

#pragma mark - 协议相关h5
// 协议相关h5
// 隐私声明
static NSString *const DEF_H5_PrivacyStatement = @"/shCg/app/agreement/privacyStatement.html";
// 注册协议
static NSString *const DEF_H5_RegisterAgreement = @"/shCg/app/agreement/registerAgreement.html";
// 债权转让说明
static NSString *const DEF_H5_Debt_Instruction = @"/shCg/app/agreement/debt_instruction.html";
// 银行卡限额说明
static NSString *const DEF_H5_SupportBank = @"/shCg/app/supportBank.html";

#endif /* ConfigDefineHeader_h */
