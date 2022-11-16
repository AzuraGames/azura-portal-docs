# 集成SDK功能 #

    MyExternalInterface.getInstance().isStartLog(true);//TAG: mySDK

<font color=red size=2>在启动activity里oncreate加上,可以开启日志调试，正式上线包需要改成false</font>
## 1.在自己的Application onCreate里调用 ##

    MyExternalInterface.getInstance().APPInit(Application application,boolean isProduction);
	 
	参数：isProduction：传入运行的环境
     	  true 表示正式环境 production 
		  false 表示测试环境sandbox 

<font color=red size=2>注意：正式上线包一定要把环境改成true</font>

## 2. 初始化SDK ##

    接口定义：
	public void SDKInit(Activity activity,String gameId,String appkey,String channelId,SDKInterfaceInitListener initListener)
####1. 接口参数说明####

参数名|类型|参数说明
 ---|----|----
activity|Activity|上下文实例
gameId|	String|	游戏ID|
appkey|	String|	游戏加密密钥
channelId|String|渠道 ID，目前固定为“GP”
initListener|SDKInterfaceInitListener|	初始化回调接口
####2. 调用示例代码####
    MyExternalInterface.getInstance().SDKInit(MainActivity.this, GAMEID, SIGN_KEY, CHANNELID, new SDKInterfaceInitListener() {
            @Override
            public void initSuccess(String result) {
                Log.d(TAG, "SDKInitsuccese-result====" + result);

                if(result.equals("true")){
                    //同意了协议直接登录
                    login();
                }else{
                    //没有同意协议调用协议界面
                    MyExternalInterface.getInstance().SDKProtocol(MainActivity.this, new BaseListener() {
                        @Override
                        public void onSuccess(int code, String msg) {
                            //同意协议
                            login();
                        }
                        @Override
                        public void onFail(int code, String msg) {
                            Log.d(TAG,"不同意协议 code="+code);
                        }
                    });
                }
            }
            @Override
            public void initFail(String result) {
                Log.d(TAG, "SDKInitfail-result====" + result);
            }
        });

## 3. 登录 ##
    接口定义：
		public void SDKLogin(Activity activity,SDKLoginListener listener)

####1. 接口参数说明####
参数名|类型|参数说明
 ---|----|----
activity|Activity|上下文实例
listener|SDKLoginListener|登录的回调

####2. 接口回调说明####
    登录成功回调 
	public void onSuccess(int code, SdkLogincallBack sdkLogincallBack)
sdkLogincallBack中会得到登录验证时所需要的参数

参数名|类型|参数说明
 ---|----|----
gameSign|	string|	登录成功后，得到的加密字符串
loginTime|	string|	用户登录的时间
uid	|String|	用户的uid
subId|	String|	Market平台子账号subId（唯一）
mainId|	String	|Market平台id（可能为空）
token|	string|	主平台token
username|	String|	用户名
loginWay|	String|	登录的方式 1:游客登录   2:Fb登录 3:账号密码登录 4:Twitter登陆 5：自动登录 6：Google登录
fbBind|	String|	0表示没有绑定，1表示绑定了
twitterBind|	String|	0表示没有绑定，1表示绑定了

####3. 调用示例代码####
     MyExternalInterface.getInstance().SDKLogin(MainActivity.this, new SDKLoginListener() {
            @Override
            public void onSuccess(int code, SdkLogincallBack sdkLogincallBack) {
                String gameSign = sdkLogincallBack.gameSign;
                String loginTime = sdkLogincallBack.loginTime;
                String uid = sdkLogincallBack.uid;
                String username = sdkLogincallBack.username;
                String loginWay = sdkLogincallBack.loginWay;
                String fbBind = sdkLogincallBack.fbBind;
                String twitterBind = sdkLogincallBack.twitterBind;
                String subId = sdkLogincallBack.subId;
                String mainId = sdkLogincallBack.mainId;
                String token = sdkLogincallBack.token;
                Log.d(TAG, "gameSign==" + gameSign + "\nloginTime==" + loginTime + "\nuid==" + uid + "\nusername==" + username
                        + "\nloginWay==" + loginWay + "\nfbBind==" + fbBind + "\ntwitterBind==" + twitterBind+ "\nsubId==" + subId+ "\nmainId==" + mainId
                        + "\ntoken==" + token);
            }

            @Override
            public void onFail(int code, String msg) {
                Log.d(TAG, "code==" + code + "\nmsg==" + msg);
            }
        });
####4. 实现onActivityResult 方法####
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
 		MyExternalInterface.getInstance().onActivityResult(MainActivity.this, requestCode, resultCode, data, new BaseListener() {
            @Override
            public void onSuccess(int code, String msg) {
               
            }
            @Override
            public void onFail(int code, String msg) {
              
            }
        });
    }

## 3.账号管理界面 ##
    接口定义：
	public void SDKAccountManage(Activity activity, SDKInterfaceExitListener exitListener)
####1. 接口参数说明####
参数名|类型|参数说明
 ---|----|----
activity|Activity|上下文实例
listener|SDKInterfaceExitListener|切换账号的回调

####2. 调用示例代码####
    MyExternalInterface.getInstance().SDKAccountManage(this, new SDKInterfaceExitListener() {
            @Override
            public void exitSuccess(String result) {
                    //点了切换账号确定接口，游戏需要返回登录界面，再次调用sdk登录
                    BaseSDKUtils.logD(TAG,"exitSuccess===="+result);
                    sdkLogin();
            }
            @Override
            public void exitFail(String result) {
            }
        });


## 4.生命周期方法 ##
####1. 调用示例代码####
在Activity的onStart里调用

    MyExternalInterface.getInstance().onStart(MainActivity.this, "");

在Activity的onStop里调用
	
	MyExternalInterface.getInstance().onStop (MainActivity.this, "");

在activity的onDestroy里调用

	MyExternalInterface.getInstance().onDestroy(MainActivity.this);

## 5.分享功能 ##
Android 11,需要在 AndroidMainfest.xml 加上下面内容，不然可能会分享不了图片:

    <manifest package="com.example.app">

		<queries>
			<package android:name="com.facebook.katana" />
        	<provider android:authorities="com.facebook.katana.provider.PlatformProvider" />
    	</queries>
    ...
	</manifest>
<img src="../images/Android_8.png" width = "550" height = "80" alt="Android_8" 
align=center />

####1.Facebook分享链接####
    接口定义：
	public void SDKFacebookShare(Activity activity, ShareInfo shareInfo, SDKInterfaceShareListener callback)

#####a.接口参数说明#####

参数名|	类型|	参数说明
 ---|----|----
activity|Activity|上下文实例
shareInfo|ShareInfo|分享的信息对象
callback|SDKInterfaceShareListener|	分享的回调

ShareInfo对象说明

参数名|	类型| 参数说明
 ---|----|----
andLink|String|	分享的链接
dsp|String|	分享的描述信息
uid|String|	用户uid
serverId|String|服务器id
roleId|	String|	游戏内的角色id
shareId|String|	分享点所在位置id（具体值具体定义）

#####b.分享回调说明#####
    msg = "0"; 为分享成功状态，回调shareSuccess
	msg = "1", 为分享失败状态, 回调shareFail
	msg ="2";为分享取消状态，回调shareFail
	msg ="3";为用户没有安装Facebook app，回调shareFail

#####c.调用示例代码#####
    ShareInfo shareInfo = new ShareInfo();
        shareInfo.andLink = "https://www.baidu.com";
        shareInfo.dsp = "测试分享";
        shareInfo.uid = "10000";
        shareInfo.serverId = "1";
        shareInfo.roleId = "123";
        shareInfo.shareId = "maipage";
        MyExternalInterface.getInstance().SDKFacebookShare(this, shareInfo, new SDKInterfaceShareListener() {
            @Override
            public void shareSuccess(String s) {
                Log.d(TAG, "s==" + s);
            }

            @Override
            public void shareFail(String s) {
                Log.d(TAG, "s==" + s);
            }
        });

####2.Facebook分享本地视频####
    接口定义：
	public void SDKFacebookShareVideo (Activity activity, ShareInfo shareInfo,File videoFile, SDKInterfaceShareListener callback)
	参数：File videoFile 传入本地视频的File目录

	UpdateInfo同上说明

#####a.调用示例代码#####

	File dir = this.getExternalFilesDir("video");
 	File loadingvideo = new File(dir, "shareVideo.mp4");

    ShareInfo shareInfo = new ShareInfo();
        shareInfo.uid = "10000";
        shareInfo.serverId = "1";
        shareInfo.roleId = "123";
        shareInfo.shareId = "maipage";

        MyExternalInterface.getInstance().SDKFacebookShareVideo (this,shareInfo,loadingvideo,new SDKInterfaceShareListener(){
			@Override
            public void shareSuccess(String s) {
                Log.d(TAG, "s==" + s);
            }

            @Override
            public void shareFail(String s) {
                Log.d(TAG, "s==" + s);
            }
	});

####3.Facebook分享图片####
    用户必须安装 7.0 或更高版本的原生 Android 版 Facebook 应用才能分享。
	接口定义：
	public void SDKFacebookSharePicture (Activity activity, ShareInfo shareInfo, Bitmap imageBitmap, SDKInterfaceShareListener callback)
	参数：Bitmap imageBitmap 传入图片的bitmap

	UpdateInfo同上说明

#####a.调用示例代码#####

	File dir = this.getExternalFilesDir("picture");
            File sharePicture = new File(dir, "sharePicture.png");
            Uri uri = Uri.fromFile(sharePicture);
            Bitmap bitmap = MediaStore.Images.Media.getBitmap(this.getContentResolver(), uri);

    ShareInfo shareInfo = new ShareInfo();
        shareInfo.uid = "10000";
        shareInfo.serverId = "1";
        shareInfo.roleId = "123";
        shareInfo.shareId = "maipage";

        MyExternalInterface.getInstance().SDKFacebookSharePicture (this,shareInfo, bitmap,new SDKInterfaceShareListener(){
			@Override
            public void shareSuccess(String s) {
                Log.d(TAG, "s==" + s);
            }

            @Override
            public void shareFail(String s) {
                Log.d(TAG, "s==" + s);
            }
	});

## 6.Firebase推送 ##
####1.在Firebase创建的应用下载json文件####
 <img src="../images/Android_9.png" width = "550" height = "400" alt="Android_9" align=center />
在AndroidManifest.xml 的application节点下加入

    <service
          android:name="com.myBest.sdk.service.MyFirebaseMessagingService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.firebase.MESSAGING_EVENT" />
            </intent-filter>
  	</service>

####2.在 Android 13+ 上请求运行时通知权限####
Android 13 引入了用于显示通知的新运行时权限。这会影响在 Android 13 或更高版本上运行且使用 FCM 通知的所有应用。

默认情况下，FCM SDK（23.0.6 或更高版本）包含清单中定义的POST_NOTIFICATIONS权限。但是，您的应用还需要通过常量android.permission.POST_NOTIFICATIONS请求此权限的运行时版本。在用户授予此权限之前，您的应用将无法显示通知。

在请求权限的方法中判断Android版本13+以上加上请求通知的权限 Manifest.permission.POST_NOTIFICATIONS

    // This is only necessary for API level >= 33 (TIRAMISU)
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)

## 7.配置Google登录 ##
拷贝credentials.json文件放在同样的目录位置
<img src="../images/Android_10.png" width = "390" height = "290" alt="Android_10" align=center />

    	<!--google 登录配置-->
        <meta-data
            android:name="Google_SingIn_Key"
            android:value="@string/google_singin_key"></meta-data>
和Facebook配置一样，具体值写在string.xml里
