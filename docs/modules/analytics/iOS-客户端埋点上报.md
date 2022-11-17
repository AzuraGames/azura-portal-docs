# iOS客户端埋点上报

## 1.在 _- (void)applicationDidBecomeActive:(UIApplication *)application_ 方法中调用上报激活事件
> *请先初始化 SDK 可参考 **iOS登录***

- 调用示例如下:
```OC
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [ROCSdkManager activateApp];
}
```

## 2.其它自定义埋点上报
### 接口对象参数包含字段说明:
| 参数      |  类型  | 说明   |
| :-------- | :----: | :------ |
| eventName | 字符串 | 事件名（埋点文档中对应的事件名，⚠️不能自定义） |
| dic  | 字符串 | 包含携带参数的对象，具体各个点需要携带的参数请参考埋点文档|

- 调用示例如下:
```OC
[ROCSdkManager azlEventName:⚠️#事件名#⚠️ 
					callbackParameter:nil];

[ROCSdkManager azlEventName:⚠️#事件名#⚠️ 
					callbackParameter:@{@"uid":@"xxx", 
														  @"serverid":@"xxx", 
														  @"playerid":@"xxx",
                  					  }];
```



