# iOS登录
阿组拉SDK支持多种登录方式
- 游客登录
- 苹果登录
-  Facebook登录
-  Yeeha平台邮箱登录

---
# 登录实现
## 1. SDK初始化
### 1.0 在 _- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions_ 方法中初始化SDK

| 参数   | 类型 |     说明 |
| :--: | :---: | :-- |
| isProduction | bool | 线上为 YES , 测试为NO, ⚠️提审时需设置为YES |

```OC
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.


    [[ROCSdkManager manager] initConfig:isProduction
                            application:application
                          launchOptions:launchOptions];
               
    return YES;
}
```
### 1.1 在  _- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options_  方法中实现SDK对应方法
```OC
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options API_AVAILABLE(ios(9.0)){
    BOOL log = [[ROCSdkManager manager] application:app
                                            openURL:url
                                            options:options];
    return log; 
}
```

---
## 2. 登录模块
### 2.1 展示登录界面
> *界面中含有登录、注册、忘记密码功能。 账号的切换、注销请参考 **3. 账号管理模块***
```OC
[ROCSdkManager showLogin];
```

### 2.2 登录事件回调
> *登录失败 SDK 已做提示功能, 无需再做处理*
- 返回键值对对象dic，包含字段如下:
| 参数   | 类型 |     说明 |
| :-- | :---: | :-- |
| username | 字符串 | 账号username |
| uid | 字符串 | 账号uid |
| subId | 字符串 | Yeeha平台子账号ID |
| mainId | 字符串 | Yeeha平台ID |
| gameSign | 字符串 | 登录验证用 |
| loginTime | 字符串 | 登录验证用 |
| token | 字符串 | 登录验证用 |
| channel | 字符串 | 支付时会用到  用户来源:如iOS、安卓等 |
| loginWay | 字符串 | 登录方式  0:apple登录 1:游客登录 2:Fb登录 3:账号密码登录 |
| fbBind | 字符串 | 0:未绑定  1:已绑定 |
| twitterBind | 字符串 | 0:未绑定  1:已绑定 |
```OC
[ROCSdkManager manager].loginSuccessBlock = ^(NSDictionary * _Nonnull dic) {
     NSLog(@"登录成功:%@",dic);
};
```

### 2.3 登录界面移除
> *登录成功SDK会自动移除界面，所以通常用不到这个接口*
```OC
[ROCSdkManager removeLoginVC];
```

---
## 3. 账号管理模块
### 3.1 展示账号管理界面
> *界面中含有修改密码、绑定邮箱、绑定Facebook、账号的切换和注销功能*
```OC
[ROCSdkManager showAcc];
```

### 3.2 事件回调
#### 3.2.1 切换账号回调
> * *玩家已确认切换账号，需要对接方实现游戏的初始化工作，初始化到刚启动应用时的状态*
> * *玩家删除账号也走该回调，不需要额外处理逻辑，同切换账号一套处理代码即可*
```OC
[ROCSdkManager manager].changeAccBlock = ^{
    NSLog(@"确认了要切换账号");
};
```

#### 3.2.2 关闭账号管理界面回调
> *玩家关闭了账号管理界面，通常用不到这个回调*
```OC
[ROCSdkManager manager].changeAccBlock = ^{
    NSLog(@"确认了要切换账号");
};
```

