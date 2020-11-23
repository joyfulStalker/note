[TOC]

[返回目录](./README.MD)

# 一：基础部分

## 1、小知识点

```
finally是可以信任的,经过测试，哪怕是发生了OutofMemoryError，finally块中的语句执行也能够得到保证。
```

```java
-- 手机号脱敏
StringBuilder sb = new StringBuilder("15555555555");
String mobileNumer = sb.replace(3, 7, "****").toString();
```
```
空格 &ensp; 
它叫“半角空格”，此空格有个相当稳健的特性，就是其占据的宽度正好是1/2个中文宽度，而且基本上不受字体影响。
```

```java
//java前台与后台之间时间格式转换
//接收参数转换
public Response<Void> WBO1(@DateTimeFormat(pattern="yyyy-MM-dd") Date AppointmentDate){
    return null;
}

@ApiModelProperty(value = "活动发布时间")
@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
private Date publishTime;

//设置locale可以改变字符集
@JsonFormat(pattern = "yyyy年MM月dd日 HH:mm a", locale = "en", timezone = "GMT+8")
```



# 二：Spring



# 三：mybatis







