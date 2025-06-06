> 版权归作者所有，如有转发，请注明文章出处：<https://cyrus-studio.github.io/blog/>

# FART 脱壳



fartthread 方法在 app 启动的时候（ActivityThread）开启 fart 线程，休眠 60 秒，等待 app 启动完成后自动开始遍历 ClassLoader 的 类列表，发起主动调用。



FART 脱壳结束得到的文件列表（分 Execute 与 主动调用两类）：

1. Execute 脱壳点得到的 dex (*_dex_file_execute.dex）和 dex 中的所有类列表（ txt 文件）

1. 主动调用时 dump 得到的 dex (*_dex_file.dex）和此时 dex 中的所有类列表，以及该 dex 中所有函数的 CodeItem（ bin 文件）

```
wayne:/data/data/com.cyrus.example/cyrus # ls
1321896_class_list.txt         1437648_dex_file_execute.dex   1488168_class_list_execute.txt 1605504_ins_4714.bin
1321896_class_list_execute.txt 1437648_ins_4714.bin           1488168_dex_file.dex           198768_class_list.txt
1321896_dex_file.dex           1448488_class_list.txt         1488168_dex_file_execute.dex   198768_class_list_execute.txt
1321896_dex_file_execute.dex   1448488_class_list_execute.txt 1488168_ins_4714.bin           198768_dex_file.dex
1321896_ins_4714.bin           1448488_dex_file.dex           1496608_class_list.txt         198768_dex_file_execute.dex
1351008_class_list.txt         1448488_dex_file_execute.dex   1496608_class_list_execute.txt 198768_ins_4714.bin
1351008_class_list_execute.txt 1448488_ins_4714.bin           1496608_dex_file.dex           3782924_class_list_execute.txt
1351008_dex_file.dex           1461504_class_list.txt         1496608_dex_file_execute.dex   3782924_dex_file_execute.dex
1351008_dex_file_execute.dex   1461504_class_list_execute.txt 1496608_ins_4714.bin           400440_class_list_execute.txt
1351008_ins_4714.bin           1461504_dex_file.dex           1537456_class_list.txt         400440_dex_file_execute.dex
1403328_class_list.txt         1461504_dex_file_execute.dex   1537456_class_list_execute.txt 4376620_class_list_execute.txt
1403328_class_list_execute.txt 1461504_ins_4714.bin           1537456_dex_file.dex           4376620_dex_file_execute.dex
1403328_dex_file.dex           1472352_class_list.txt         1537456_dex_file_execute.dex   590624_class_list.txt
1403328_dex_file_execute.dex   1472352_class_list_execute.txt 1537456_ins_4714.bin           590624_class_list_execute.txt
1403328_ins_4714.bin           1472352_dex_file.dex           1571616_class_list.txt         590624_dex_file.dex
1423432_class_list.txt         1472352_dex_file_execute.dex   1571616_class_list_execute.txt 590624_dex_file_execute.dex
1423432_class_list_execute.txt 1472352_ins_4714.bin           1571616_dex_file.dex           590624_ins_4714.bin
1423432_dex_file.dex           1481472_class_list.txt         1571616_dex_file_execute.dex   7387912_class_list_execute.txt
1423432_dex_file_execute.dex   1481472_class_list_execute.txt 1571616_ins_4714.bin           7387912_dex_file_execute.dex
1423432_ins_4714.bin           1481472_dex_file.dex           1605504_class_list.txt         8391596_class_list_execute.txt
1437648_class_list.txt         1481472_dex_file_execute.dex   1605504_class_list_execute.txt 8391596_dex_file_execute.dex
1437648_class_list_execute.txt 1481472_ins_4714.bin           1605504_dex_file.dex           9085048_class_list_execute.txt
1437648_dex_file.dex           1488168_class_list.txt         1605504_dex_file_execute.dex   9085048_dex_file_execute.dex
```


关于 FART 的详细介绍参考下面的文章：

- [FART 自动化脱壳框架简介与脱壳点的选择](https://cyrus-studio.github.io/blog/posts/fart-%E8%87%AA%E5%8A%A8%E5%8C%96%E8%84%B1%E5%A3%B3%E6%A1%86%E6%9E%B6%E7%AE%80%E4%BB%8B%E4%B8%8E%E8%84%B1%E5%A3%B3%E7%82%B9%E7%9A%84%E9%80%89%E6%8B%A9/)

- [FART 主动调用组件设计和源码分析](https://cyrus-studio.github.io/blog/posts/fart-%E4%B8%BB%E5%8A%A8%E8%B0%83%E7%94%A8%E7%BB%84%E4%BB%B6%E8%AE%BE%E8%AE%A1%E5%92%8C%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90/)

- [移植 FART 到 Android 10 实现自动化脱壳](https://cyrus-studio.github.io/blog/posts/%E7%A7%BB%E6%A4%8D-fart-%E5%88%B0-android-10-%E5%AE%9E%E7%8E%B0%E8%87%AA%E5%8A%A8%E5%8C%96%E8%84%B1%E5%A3%B3/)

- [FART 自动化脱壳框架一些 bug 修复记录](https://cyrus-studio.github.io/blog/posts/fart-%E8%87%AA%E5%8A%A8%E5%8C%96%E8%84%B1%E5%A3%B3%E6%A1%86%E6%9E%B6%E4%B8%80%E4%BA%9B-bug-%E4%BF%AE%E5%A4%8D%E8%AE%B0%E5%BD%95/)

- [使用 Frida 增强 FART：实现更强大的 Android 脱壳能力](https://cyrus-studio.github.io/blog/posts/%E4%BD%BF%E7%94%A8-frida-%E5%A2%9E%E5%BC%BA-fart%E5%AE%9E%E7%8E%B0%E6%9B%B4%E5%BC%BA%E5%A4%A7%E7%9A%84-android-%E8%84%B1%E5%A3%B3%E8%83%BD%E5%8A%9B/)

- [攻防 FART 脱壳：特征检测识别 + 对抗绕过全解析](https://cyrus-studio.github.io/blog/posts/%E6%94%BB%E9%98%B2-fart-%E8%84%B1%E5%A3%B3%E7%89%B9%E5%BE%81%E6%A3%80%E6%B5%8B%E8%AF%86%E5%88%AB-+-%E5%AF%B9%E6%8A%97%E7%BB%95%E8%BF%87%E5%85%A8%E8%A7%A3%E6%9E%90/)

- [FART 精准脱壳：通过配置文件控制脱壳节奏与范围](https://cyrus-studio.github.io/blog/posts/fart-%E7%B2%BE%E5%87%86%E8%84%B1%E5%A3%B3%E9%80%9A%E8%BF%87%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E6%8E%A7%E5%88%B6%E8%84%B1%E5%A3%B3%E8%8A%82%E5%A5%8F%E4%B8%8E%E8%8C%83%E5%9B%B4/)



# FART 生成的 bin 文件（CodeItem）格式



5元组填充：

```
{name:函数名, method_idx:函数索引, offset:偏移, code_item_len:长度, ins:函数体CodeItem的base64字符串};
```
其中：method_idx 和 ins 是必须的，其他不是必要的，但是可以作为参考。即只需要 method_idx 进行区分函数以及该函数的 CodeItem 内容即可。



修复组件就是通过读取 bin 文件的 method_idx 和 ins 进行 dex 的修复的。



只要符合 bin 文件 5 元组的规范都可以使用 FART 修复组件进行 dex 函数的修复。



# 某电商APP脱壳



## 1. 脱壳前准备



编写一个 bat 实现如下功能：

1. 禁止加载 cdex，清空 /data/app/com.shizhuang.duapp-fTxemmnM8l6298xbBELksQ==/oat/arm64 目录下的所有文件

1. 解决 frida 反调试，删除 /data/app/com.shizhuang.duapp-fTxemmnM8l6298xbBELksQ==/lib/arm64/libmsaoaidsec.so

1. 询问是否清空 /data/data/com.shizhuang.duapp/cyrus 目录下的所有文件？如果是就清空

1. 最后 pause



unpack_before.bat

```
@echo off

:: 启用超级管理员权限
adb root

:: 设置变量
set PACKAGE_NAME=com.shizhuang.duapp
set APK_DIR=/data/app/com.shizhuang.duapp-fTxemmnM8l6298xbBELksQ==
set LIB_DIR=%APK_DIR%/lib/arm64
set OAT_DIR=%APK_DIR%/oat/arm64
set CYRUS_DIR=/data/data/%PACKAGE_NAME%/cyrus

:: 步骤 1
echo 【1】禁止加载 cdex，清空 OAT 文件...
adb shell "rm -rf \"%OAT_DIR%\"/*"
echo 已清空 %OAT_DIR%
echo.

:: 步骤 2
echo 【2】解决 Frida 反调试，删除 libmsaoaidsec.so ...
adb shell "rm -f \"%LIB_DIR%/libmsaoaidsec.so\""
echo 已删除 libmsaoaidsec.so
echo.

:: 步骤 3
set /p INPUT=【3】是否清空 cyrus 配置目录？[%CYRUS_DIR%] [y/N]：

if /i "%INPUT%"=="y" (
    echo 正在清空 cyrus...
    adb shell "rm -rf \"%CYRUS_DIR%\"/*"
    echo 已清空 %CYRUS_DIR%
) else (
    echo 跳过清空 cyrus 配置目录
)

echo.
echo 所有操作已完成。
pause
```


执行脚本



![word/media/image1.png](https://gitee.com/cyrus-studio/images/raw/master/dd6706e472c9a81d1ebd52fd95e7112e.png)


## 2. 开始脱壳



通过 frida 脚本配合 FART 精准对目标类脱壳

```
// 前缀过滤逻辑
function shouldLoadClass(name) {
    return name.startsWith("ff.")
}

function hookLoadClassAndInvoke() {
    const ActivityThread = Java.use('android.app.ActivityThread');

    if (ActivityThread.dispatchClassTask) {
        ActivityThread.dispatchClassTask.implementation = function (classloader, className, method) {
            if (shouldLoadClass(className)) {
                console.log('[load] dispatchClassTask: ' + className);
                return this.dispatchClassTask(classloader, className, method); // 正常调用
            }
            console.log('[skip] dispatchClassTask: ' + className);
            return; // 不调用原函数
        };
    } else {
        console.log('[-] ActivityThread.dispatchClassTask not found');
    }
}

function fartOnDexclassloader() {
    var DexClassLoader = Java.use("dalvik.system.DexClassLoader");
    var ActivityThread = Java.use("android.app.ActivityThread");

    DexClassLoader.$init.overload(
        'java.lang.String',     // dexPath
        'java.lang.String',     // optimizedDirectory
        'java.lang.String',     // librarySearchPath
        'java.lang.ClassLoader' // parent
    ).implementation = function (dexPath, optimizedDirectory, libPath, parent) {
        console.log("[+] DexClassLoader created:");
        console.log("    |- dexPath: " + dexPath);
        console.log("    |- optimizedDirectory: " + optimizedDirectory);
        console.log("    |- libPath: " + libPath);

        var cl = this.$init(dexPath, optimizedDirectory, libPath, parent);

        // 调用 startCodeInspection 方法
        try {
            console.log("[*] Calling fartWithClassLoader...");
            ActivityThread.startCodeInspectionWithCL(this);
            console.log("[+] fartWithClassLoader finished.");
        } catch (e) {
            console.error("[-] Error calling fartWithClassLoader:", e);
        }

        return cl;
    };
}

function invokeAllClassloaders() {
    try {
        // 获取 ActivityThread 类
        var ActivityThread = Java.use("android.app.ActivityThread");

        Java.enumerateClassLoaders({
            onMatch: function (loader) {
                try {
                    // 过滤掉 BootClassLoader
                    if (loader.toString().includes("BootClassLoader")) {
                        console.log("[-] 跳过 BootClassLoader");
                        return;
                    }

                    // 调用 fartWithClassLoader
                    console.log("[*] 调用 startCodeInspectionWithCL -> " + loader);
                    ActivityThread.startCodeInspectionWithCL(loader);
                } catch (e) {
                    console.error("[-] 调用失败: " + e);
                }
            },
            onComplete: function () {
                console.log("[*] 枚举并调用完毕");
            }
        });
    } catch (err) {
        console.error("[-] 脚本执行异常: " + err);
    }
}


setImmediate(function () {
    Java.perform(function () {
        // 过滤需要主动调用的类
        hookLoadClassAndInvoke()
        // 解决局部变量的 ClassLoader 枚举不出来问题
        fartOnDexclassloader()
        // 解决非双亲委派关系下动态加载的 dex 脱壳问题
        invokeAllClassloaders()
    })
})
```
源码：[https://github.com/CYRUS-STUDIO/frida_fart](https://github.com/CYRUS-STUDIO/frida_fart)



执行 frida 脚本

```
frida -H 127.0.0.1:1234 -F -l fart_filter.js -o log.txt
```


参考：

- [移植 FART 到 Android 10 实现自动化脱壳](https://cyrus-studio.github.io/blog/posts/%E7%A7%BB%E6%A4%8D-fart-%E5%88%B0-android-10-%E5%AE%9E%E7%8E%B0%E8%87%AA%E5%8A%A8%E5%8C%96%E8%84%B1%E5%A3%B3/)

- [使用 Frida 增强 FART：实现更强大的 Android 脱壳能力](https://cyrus-studio.github.io/blog/posts/%E4%BD%BF%E7%94%A8-frida-%E5%A2%9E%E5%BC%BA-fart%E5%AE%9E%E7%8E%B0%E6%9B%B4%E5%BC%BA%E5%A4%A7%E7%9A%84-android-%E8%84%B1%E5%A3%B3%E8%83%BD%E5%8A%9B/)

- [攻防 FART 脱壳：特征检测识别 + 对抗绕过全解析](https://cyrus-studio.github.io/blog/posts/%E6%94%BB%E9%98%B2-fart-%E8%84%B1%E5%A3%B3%E7%89%B9%E5%BE%81%E6%A3%80%E6%B5%8B%E8%AF%86%E5%88%AB-+-%E5%AF%B9%E6%8A%97%E7%BB%95%E8%BF%87%E5%85%A8%E8%A7%A3%E6%9E%90/)



## 3. 脱壳完成



脱壳文件列表

```
1|wayne:/data/data/com.shizhuang.duapp/cyrus # ls
10637856_class_list_execute.txt 12300396_class_list_execute.txt 12888744_dex_file_execute.dex  8324572_class_list.txt
10637856_dex_file_execute.dex   12300396_dex_file_execute.dex   3273924_class_list_execute.txt 8324572_class_list_execute.txt
11125808_class_list_execute.txt 12319700_class_list_execute.txt 3273924_dex_file_execute.dex   8324572_dex_file.dex
11125808_dex_file_execute.dex   12319700_dex_file_execute.dex   3782924_class_list_execute.txt 8324572_dex_file_execute.dex
11994176_class_list.txt         12587972_class_list_execute.txt 3782924_dex_file_execute.dex   8324572_ins_8950.bin
11994176_class_list_execute.txt 12587972_dex_file_execute.dex   400440_class_list_execute.txt  8391604_class_list_execute.txt
11994176_dex_file.dex           12590752_class_list_execute.txt 400440_dex_file_execute.dex    8391604_dex_file_execute.dex
11994176_dex_file_execute.dex   12590752_dex_file_execute.dex   4376620_class_list_execute.txt 8681372_class_list_execute.txt
11994176_ins_8950.bin           12592256_class_list_execute.txt 4376620_dex_file_execute.dex   8681372_dex_file_execute.dex
12081268_class_list_execute.txt 12592256_dex_file_execute.dex   7387912_class_list_execute.txt 9085048_class_list_execute.txt
12081268_dex_file_execute.dex   1260244_class_list_execute.txt  7387912_dex_file_execute.dex   9085048_dex_file_execute.dex
12213596_class_list_execute.txt 1260244_dex_file_execute.dex    8183732_class_list_execute.txt
12213596_dex_file_execute.dex   12888744_class_list_execute.txt 8183732_dex_file_execute.dex
```


通过 grep -rl 命令查找目标类所在的 dex 是 11994176_ 开头的 dex

```
wayne:/data/data/com.shizhuang.duapp/cyrus # grep -rl "ff.l0" *.txt
11994176_class_list.txt
11994176_class_list_execute.txt
```


所以，需要使用 11994176_ins_8950.bin 修复 11994176_dex_file.dex

```
wayne:/data/data/com.shizhuang.duapp/cyrus # ls -hl 11994176_*
-rw------- 1 u0_a139 u0_a139 612K 2025-06-04 09:55 11994176_class_list.txt
-rw------- 1 u0_a139 u0_a139 612K 2025-06-04 09:54 11994176_class_list_execute.txt
-rw------- 1 u0_a139 u0_a139  11M 2025-06-04 09:55 11994176_dex_file.dex
-rw------- 1 u0_a139 u0_a139  11M 2025-06-04 09:54 11994176_dex_file_execute.dex
-rw------- 1 u0_a139 u0_a139 114K 2025-06-04 09:55 11994176_ins_8950.bin
```


先把脱壳文件拉取到本地

```
adb pull /data/data/com.shizhuang.duapp/cyrus
```


# 迁移 fart.py 到 python3



fart.py 是用于解析dex文件，将 bin 的 CodeItem 修复打印 的 python 脚本。但 fart.py 是基于 pythion2 的。



迁移到 python3，主要修改如下：

- 使用 range 替换 xrange

- print 写法变化

- 在 Python 3 中，访问 bytes[i] 得到的是 int（不再是字符），所以不需要再用 ord()。

- 将所有 dict.has_key(key) 替换成 key in dict

- 把 '[' in name 改成 b'[' in name



源码地址：[https://github.com/CYRUS-STUDIO/FART/blob/master/fart3.py](https://github.com/CYRUS-STUDIO/FART/blob/master/fart3.py)



但 fart.py 仅仅是打印，并没有把 CodeItem 真正修复到 dex



![word/media/image2.png](https://gitee.com/cyrus-studio/images/raw/master/1c482381de1035d5e5982b614c3347b3.png)


# 使用 dexfixer 修复 dex



dexfixer 项目来源于 [Youpk，](https://github.com/youlor/unpacker)支持对 fart 的脱壳结果进行修复合并到 dex。



开源地址：[https://github.com/dqzg12300/dexfixer](https://github.com/dqzg12300/dexfixer)



使用 dexfixer 修复

```
java -jar ./dexfixer.jar dexpath binpath outpath
```


目前 dexfixer 项目是基于 eclipse 的，我把它迁移到了 IDEA。



开源地址：[https://github.com/CYRUS-STUDIO/FartFixer](https://github.com/CYRUS-STUDIO/FartFixer)



把源码 clone 到本地后，导入到 IDEA，编辑运行配置，添加运行参数（添加 dex、bin、修复后的dex文件路径）

```
D:\Python\anti-app\abc\cyrus\11994176_dex_file.dex 
D:\Python\anti-app\abc\cyrus\11994176_ins_8950.bin 
D:\Python\anti-app\abc\cyrus\11994176_dex_file_fix.dex
```


![word/media/image3.png](https://gitee.com/cyrus-studio/images/raw/master/24aa33e362da1cebffad20b67087dbf5.png)


运行 com.android.dx.unpacker.DexFixer 的 main 函数



![word/media/image4.png](https://gitee.com/cyrus-studio/images/raw/master/b7981b3efbe7f2171f44f20462769270.png)


修复完成



![word/media/image5.png](https://gitee.com/cyrus-studio/images/raw/master/dad98ece9ce6ff93dc0f1a777b437be2.png)


# 使用 IntelliJ IDEA 导出 FartFixer.jar



## 1. 配置 Artifacts

- 点击菜单栏 File → Project Structure（或快捷键 Ctrl+Alt+Shift+S）。

- 在左侧选择 Artifacts，点击右上角的 + → JAR → From modules with dependencies。

- 在弹出框中选择主类（DexFixer），点击 OK。



![word/media/image6.png](https://gitee.com/cyrus-studio/images/raw/master/db42932736caadc2d36a4454bff7d904.png)


## 2. 构建 Artifact

- 点击 Build → Build Artifacts...。

- 选择你刚刚配置的 Artifact → Build。

- 构建完成后，在 out/artifacts/xxx.jar 目录下可找到 JAR 文件。



![word/media/image7.png](https://gitee.com/cyrus-studio/images/raw/master/a8518dc6e6b772624e9ea370e56fe7fc.png)


# 使用 FartFixer.jar 修复 dex



执行下面命令修复 dex

```
java -jar ./FartFixer.jar dexpath binpath outpath
```


效果如下：



![word/media/image8.png](https://gitee.com/cyrus-studio/images/raw/master/7f947a4e590553ed7d9ea728fb23f9b3.png)


# 批量自动修复 dex



编写一个辅助脚本，实现批量自动修复 dex，功能如下：

- 提示用户输入一个 bin 文件所在目录；

- 查找该目录下所有以 .bin 结尾的文件（如 11994176_ins_8950.bin）；

- 通过 bin 文件名前缀（如 11994176_）在同目录中查找对应的 dex 文件（如 11994176_dex_file.dex）；

- 在 dex 所在目录下创建 fix 目录；

- 调用 java -jar ./FartFixer.jar 修复 dex，输出到 fix/ 目录。

```
java -jar ./FartFixer.jar dexpath binpath outpath
```


FartFixer.bat（Windows）

```
@echo off
setlocal enabledelayedexpansion

:: 输入 bin 文件目录
set /p BIN_DIR=请输入 bin 文件所在目录:

:: 判断目录是否存在
if not exist "%BIN_DIR%" (
    echo 错误：目录 %BIN_DIR% 不存在
    pause
    exit /b
)

:: 遍历 bin 文件
for %%B in ("%BIN_DIR%\*.bin") do (
    set "BIN_FILE=%%~nxB"
    set "PREFIX="
    set "BIN_PATH=%%~fB"

    :: 提取前缀，比如 11994176_
    for /f "tokens=1 delims=_" %%P in ("%%~nB") do (
        set "PREFIX=%%P_"
    )

    :: 查找匹配的 dex 文件
    for %%D in ("%BIN_DIR%\!PREFIX!*.dex") do (
        set "DEX_FILE=%%~nxD"
        set "DEX_PATH=%%~fD"

        :: 创建 fix 目录
        set "FIX_DIR=%%~dpDfix"
        if not exist "!FIX_DIR!" (
            mkdir "!FIX_DIR!"
        )

        :: 构造输出路径
        set "FIXED_DEX=!FIX_DIR!\!DEX_FILE:_file=_file_fix!"

        echo 修复 !DEX_FILE!，使用 !BIN_FILE! ...
        java -jar ./FartFixer.jar "!DEX_PATH!" "!BIN_PATH!" "!FIXED_DEX!"
    )
)

echo 全部修复完成。
pause
```


FartFixer.sh（Linux / macOS）

```
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <bin_dir>"
    exit 1
fi

BIN_DIR="$1"

# 查找所有 .bin 文件
find "$BIN_DIR" -type f -name "*.bin" | while read BIN_PATH; do
    BIN_FILE=$(basename "$BIN_PATH")
    PREFIX="${BIN_FILE%%_*}_"  # 提取前缀，例如 11994176_

    # 查找对应的 dex 文件
    find "$BIN_DIR" -type f -name "${PREFIX}*.dex" | while read DEX_PATH; do
        DEX_FILE=$(basename "$DEX_PATH")
        DEX_DIR=$(dirname "$DEX_PATH")

        # 创建 fix 目录
        FIX_DIR="$DEX_DIR/fix"
        mkdir -p "$FIX_DIR"

        # 构造输出路径
        FIXED_DEX="$FIX_DIR/${DEX_FILE/_file/_file_fix}"

        echo "修复 $DEX_FILE，使用 $BIN_FILE ..."
        java -jar ./FartFixer.jar "$DEX_PATH" "$BIN_PATH" "$FIXED_DEX"
    done
done
```


添加执行权限：

```
chmod +x FartFixer.sh
```


运行脚本，输入 bin 文件目录



![word/media/image9.png](https://gitee.com/cyrus-studio/images/raw/master/701274db4842ff77acb6cfdaee6ecb7f.png)


修复成功，修复后的 dex 在 fix 目录下



![word/media/image10.png](https://gitee.com/cyrus-studio/images/raw/master/f852e1dff98a06ad6437d802c4aaee9f.png)


# dex2jar



[dex2jar](https://github.com/pxb1988/dex2jar) 是一个将 Android 的 .dex 文件转换为 Java 的 .jar 文件的工具，方便反编译和分析 APK。



开源地址：[https://github.com/pxb1988/dex2jar](https://github.com/pxb1988/dex2jar)



下载 Release 版本 dex2jar：[https://github.com/pxb1988/dex2jar/releases](https://github.com/pxb1988/dex2jar/releases)



通过 ./d2j-dex2jar.bat 或 ./d2j-dex2jar.sh 把 dex 文件转换为 jar

```
(base) PS D:\Python\anti-app\dex2jar> ./d2j-dex2jar.bat -f D:\Python\anti-app\abc\cyrus\11994176_dex_file.dex
dex2jar D:\Python\anti-app\abc\cyrus\11994176_dex_file.dex -> .\11994176_dex_file-dex2jar.jar
```


脚本中实际调用的是 com.googlecode.dex2jar.tools.Dex2jarCmd



![word/media/image11.png](https://gitee.com/cyrus-studio/images/raw/master/7783b789650e0b2c632480303b0c4232.png)


Dex2jarCmd 中各参数说明如下：

```
package com.googlecode.dex2jar.tools;

import com.googlecode.d2j.dex.Dex2jar;
import com.googlecode.d2j.reader.BaseDexFileReader;
import com.googlecode.d2j.reader.DexFileReader;
import com.googlecode.d2j.reader.MultiDexFileReader;
import com.googlecode.dex2jar.ir.ET;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;

@BaseCmd.Syntax(cmd = "d2j-dex2jar", syntax = "[options] <file0> [file1 ... fileN]", desc = "convert dex to jar")
public class Dex2jarCmd extends BaseCmd {

    public static void main(String... args) {
        new Dex2jarCmd().doMain(args);
    }

    // 异常信息输出文件路径
    @Opt(opt = "e", longOpt = "exception-file", description = "detail exception file, default is $current_dir/[file-name]-error.zip", argName = "file")
    private Path exceptionFile;

    // 是否强制覆盖已有文件
    @Opt(opt = "f", longOpt = "force", hasArg = false, description = "force overwrite")
    private boolean forceOverwrite = false;

    // 是否不处理异常
    @Opt(opt = "n", longOpt = "not-handle-exception", hasArg = false, description = "not handle any exceptions thrown by dex2jar")
    private boolean notHandleException = false;

    // jar 输出路径
    @Opt(opt = "o", longOpt = "output", description = "output .jar file, default is $current_dir/[file-name]-dex2jar.jar", argName = "out-jar-file")
    private Path output;

    // 是否复用寄存器（对可读性有影响）
    @Opt(opt = "r", longOpt = "reuse-reg", hasArg = false, description = "reuse register while generate java .class file")
    private boolean reuseReg = false;

    // 是否按拓扑排序生成代码（提高可读性）
    @Opt(opt = "s", hasArg = false, description = "same with --topological-sort/-ts")
    private boolean topologicalSort1 = false;

    @Opt(opt = "ts", longOpt = "topological-sort", hasArg = false, description = "sort block by topological, that will generate more readable code, default enabled")
    private boolean topologicalSort = false;

    // 是否翻译 debug 信息
    @Opt(opt = "d", longOpt = "debug-info", hasArg = false, description = "translate debug info")
    private boolean debugInfo = false;

    // 是否打印中间 IR（中间表示）
    @Opt(opt = "p", longOpt = "print-ir", hasArg = false, description = "print ir to System.out")
    private boolean printIR = false;

    // 是否优化 synchronized 块
    @Opt(opt = "os", longOpt = "optmize-synchronized", hasArg = false, description = "optimize-synchronized")
    private boolean optmizeSynchronized = false;

    // 是否跳过异常块
    @Opt(longOpt = "skip-exceptions", hasArg = false, description = "skip-exceptions")
    private boolean skipExceptions = false;

    // 不生成代码（只提取结构）
    @Opt(opt = "nc", longOpt = "no-code", hasArg = false, description = "")
    private boolean noCode = false;

    @Override
    protected void doCommandLine() throws Exception {
        if (remainingArgs.length == 0) {
            usage(); // 没有参数则显示用法
            return;
        }

        if ((exceptionFile != null || output != null) && remainingArgs.length != 1) {
            System.err.println("-e/-o can only used with one file");
            return;
        }
        if (debugInfo && reuseReg) {
            System.err.println("-d/-r can not use together");
            return;
        }

        Path currentDir = new File(".").toPath();

        // 如果指定了输出文件且文件已存在，默认不覆盖
        if (output != null) {
            if (Files.exists(output) && !forceOverwrite) {
                System.err.println(output + " exists, use --force to overwrite");
                return;
            }
        } else {
            for (String fileName : remainingArgs) {
                Path file = currentDir.resolve(getBaseName(new File(fileName).toPath()) + "-dex2jar.jar");
                if (Files.exists(file) && !forceOverwrite) {
                    System.err.println(file + " exists, use --force to overwrite");
                    return;
                }
            }
        }

        // 处理每个 dex 文件
        for (String fileName : remainingArgs) {
            String baseName = getBaseName(new File(fileName).toPath());
            Path file = output == null ? currentDir.resolve(baseName + "-dex2jar.jar") : output;
            System.err.println("dex2jar " + fileName + " -> " + file);

            // 打开 .dex 文件
            BaseDexFileReader reader = MultiDexFileReader.open(Files.readAllBytes(new File(fileName).toPath()));

            // 创建异常处理器（可选）
            BaksmaliBaseDexExceptionHandler handler = notHandleException ? null : new BaksmaliBaseDexExceptionHandler();

            // 执行 dex 到 jar 的转换
            Dex2jar.from(reader)
                    .withExceptionHandler(handler)
                    .reUseReg(reuseReg)
                    .topoLogicalSort()
                    .skipDebug(!debugInfo)
                    .optimizeSynchronized(this.optmizeSynchronized)
                    .printIR(printIR)
                    .noCode(noCode)
                    .skipExceptions(skipExceptions)
                    .to(file);

            // 如果有异常，保存异常信息到文件
            if (!notHandleException && handler.hasException()) {
                Path errorFile = exceptionFile == null
                        ? currentDir.resolve(baseName + "-error.zip")
                        : exceptionFile;
                System.err.println("Detail Error Information in File " + errorFile);
                System.err.println(BaksmaliBaseDexExceptionHandler.REPORT_MESSAGE);
                handler.dump(errorFile, originalArgs);
            }
        }
    }

    @Override
    protected String getVersionString() {
        return "reader-" + DexFileReader.class.getPackage().getImplementationVersion() + ", translator-"
                + Dex2jar.class.getPackage().getImplementationVersion() + ", ir-"
                + ET.class.getPackage().getImplementationVersion();
    }
}
```


# 批量 dex2jar


编写一个批处理脚本用于批量转换 dex 文件，功能如下：

- 提示用户输入一个 .dex 文件目录；

- 查找该目录下的所有 .dex 文件（支持子目录）；

- 对每个 .dex 文件调用 ./d2j-dex2jar.bat 进行转换；

- 输出的 .jar 文件保存在 ${dex目录}\jar 文件夹下。



dex2jar.bat（Windows）

```
@echo off
setlocal enabledelayedexpansion

:: 提示输入 dex 文件目录
set /p dex_dir=请输入 dex 文件所在的目录（绝对路径或相对路径）:

:: 判断目录是否存在
if not exist "%dex_dir%" (
    echo 目录不存在: %dex_dir%
    pause
    exit /b
)

:: 创建输出 jar 目录
set "jar_dir=%dex_dir%\jar"
if not exist "%jar_dir%" (
    mkdir "%jar_dir%"
)

:: 查找所有 dex 文件
for /r "%dex_dir%" %%f in (*.dex) do (
    set "dex_file=%%f"
    set "file_name=%%~nf"
    echo 正在转换: !dex_file!

    :: 构造输出路径
    set "out_jar=%jar_dir%\!file_name!.jar"

    :: 调用 dex2jar 脚本
    call ./d2j-dex2jar.bat -f -o "!out_jar!" "!dex_file!"
)

echo 所有 dex 文件已转换完成，jar 输出目录: %jar_dir%
pause
```


dex2jar.sh（Linux / macOS）

```
#!/bin/bash

# 读取用户输入的 dex 文件目录
read -p "请输入 dex 文件所在目录: " dex_dir

# 判断目录是否存在
if [ ! -d "$dex_dir" ]; then
    echo "目录不存在: $dex_dir"
    exit 1
fi

# 创建输出 jar 目录
jar_dir="$dex_dir/jar"
mkdir -p "$jar_dir"

# 遍历 dex 文件并转换为 jar
find "$dex_dir" -type f -name "*.dex" | while read dex_file; do
    file_name=$(basename "$dex_file" .dex)
    out_jar="$jar_dir/${file_name}.jar"

    echo "正在转换: $dex_file"
    ./d2j-dex2jar.sh -f -o "$out_jar" "$dex_file"
done

echo "所有 dex 文件已转换完成，jar 输出目录: $jar_dir"
```


给脚本添加执行权限：

```
chmod +x dex2jar.sh
```


运行脚本，输入 dex 目录



![word/media/image12.png](https://gitee.com/cyrus-studio/images/raw/master/48a566f726de7f44c8e3a41e1611a378.png)


转换完成



![word/media/image13.png](https://gitee.com/cyrus-studio/images/raw/master/b7c921ff687b33251dd158d03ca82861.png)


# 使用 jadx 反编译 jar



直接把 jar 文件拖入 jadx 可以看到被抽取的类和函数都已经修复好了。



![word/media/image14.png](https://gitee.com/cyrus-studio/images/raw/master/fb83e087e30945f71531650b35071927.png)


# 完整源码



开源地址：

- [https://github.com/CYRUS-STUDIO/FartFixer](https://github.com/CYRUS-STUDIO/FartFixer)

- [https://github.com/CYRUS-STUDIO/dex2jar](https://github.com/CYRUS-STUDIO/dex2jar)



