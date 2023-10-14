# 基础设施

**「工欲善其事，必先利其器。」**

## 编程与基础设施

在计算机的世界遨游的同时，相信你一定注意到了一个事实：我们站在巨人的肩膀上。我们所面对的计算机不是冷冰冰的门电路的组合，我们为计算机编程用的也不是纺织导线的技术。事实上，我们使用计算机娱乐也好，编程也罢，都利用着前人用千万行代码筑成的操作系统、应用软件生态。

作为人类智慧和工业的结晶，计算机在一瞬之间处理着无数的指令，海量的细节。它精细、高速处理和操作信息的能力远远超过人类。前人已经通过高级程序语言和丰富的命令行工具为我们提供了完善的编程接口，使得我们可以有效利用计算机的处理能力帮助我们完成大量繁复的工作，这个过程就是在**建设基础设施**。

简单举个例子，项目通过 `make` 脚本代码为大家自动化了编译和启动的流程。你可以通过 `make clean; make compile -n` 来观察 `make` 脚本为你省去的功夫，想想你需要多少时间来手动输入这些代码？如果你一学期编译项目几百次，那么浪费的时间将是海量的。好的基础设施能够提高开发效率。[「时间就是金钱，效率就是生命」](https://zh.wikipedia.org/wiki/%E6%97%B6%E9%97%B4%E5%B0%B1%E6%98%AF%E9%87%91%E9%92%B1%EF%BC%8C%E6%95%88%E7%8E%87%E5%B0%B1%E6%98%AF%E7%94%9F%E5%91%BD)。基础设施的重要性可见一斑。

本部分受到 PA 讲义的启发，详见其[简易调试器](https://nju-projectn.github.io/ics-pa-gitbook/ics2022/1.4.html)一节。

???+ note "掌握编程思维"

    理论部分的教学中强调教会大家[计算思维](https://zh.wikipedia.org/wiki/%E8%AE%A1%E7%AE%97%E6%80%9D%E7%BB%B4)，而编程思维作为计算思维中的重要实践外化，也是程设部分竭力要教会大家的。大家应当学会做到如下两点：

    + 学会利用已有的抽象完成看似困难的工作（比如利用 [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) 框架搭建问题求解讲义网站）。
    + 尝试利用计算机的力量自动化自己的工作流程（不一定要通过狭义编程，比如使用 [Power Automate](https://learn.microsoft.com/zh-tw/power-automate/)）。

???+ note "探索计算机系统的原则：深入浅出"

    `make -n` 不执行真实的命令，而是仅输出它想要执行的命令。这是一种反抽象，把抽象的细节展开显示的命令。此种命令的存在折射出探索计算机系统时「深入」和「浅出」原则的对立统一。

    计算机系统利用逐级抽象省去了大量人力工作的同时，也省去了大量水面下的细节（即所谓「透明」）。但鉴于「计算机科学与技术」专业的培养要求和更好利用计算机系统进行工作的现实需要，我们需要时刻问问自己「这个效果是怎么实现的？每个抽象层级都做了些什么？」。只有理解了这些，在开发和调试时才能通行无碍。
    
    而在实际操作中，我们则要继续利用我们对计算机系统的理解进一步进行抽象，透明化繁复的细节。此之谓「深入」而「浅出」。事实上，在大家后续学习计算机系统系列课程的过程中，也都离不开这样的原则。
    

## 认识游戏启动器

闲话说了太多，我们赶快进入正题吧。

???+ question "为什么老讲这么多大道理？"

    我国的老话说：授人以鱼不如授人以渔。传统地，鱼可以理解为成果，而渔可以理解为方法。
    
    但高中哲学知识告诉我们，方法也许也只是「鱼」，真正在我们认知和改变世界中起着「渔」的作用的应当是方法之上的方法论（methodology）。对于我们的教学而言，完成项目只是训练手段，而藉由这种手段实现的目的则是教会大家如何开发一个项目，而更进一步地，我们希望能一定程度地教会大家*如何编程*。

    当然，真正的心得还是要在实践中获取，平淡的文字也难以传达深刻的体会。如果你对编程毫无经验，那看完一段段的大道理也许会懵逼——*但这是正常的，不必惊慌。*在完成项目后，抑或是完成 PA 以后，甚至是本科毕业以后，你也许会多少会想起这些大道理。某种意义上，我们写这么多大道理，提供的也是一种「回味」。

在上一部分你应当已经拉取并运行了框架代码。事实上，框架代码编译为两个独立的可执行程序。一个是游戏主体，另一个则是游戏启动器。在你先前执行的两条命令中， `make compile` 编译的是游戏本身，而 `make shell` 会编译并运行游戏启动器。

在第零阶段，我们的主要任务是完善游戏启动器的功能，使得它可以：

+ 在启动器运行时重新编译游戏（全部重编译/增量重编译）。
+ 可选以调试模式启动游戏（运行 gdbserver 并启动调试端口）。
+ 可选用 gdb 连接上正在运行的游戏进程（无论是否用调试模式打开）或用 gdb 连接调试模式的 gdbserver。

!!! Warning "Linux 用户请注意"
    由于部分发行版不会在安装 gdb 的同时安装 gdbserver，你可能需要手动安装 gdbserver。

要完成上述任务，我们必须理解游戏启动器的源代码。幸运的是，启动器是一个单文件 C 程序，理解起来较为容易。它在项目中的位置是 `wrapper/shell.c`[^1]。

`shell.c` 在大部分代码经过封装的前提下仍有一百多行，阅读起来也并不容易。幸运的是，我们可以根据我们使用它的经验和 `main()` 函数的行为理解它执行的流程。

启动器的 `main()` 函数只做了一件事：调用了 `cmd_mainloop()` 函数。而这个函数所做的事情要复杂一些，它进入了一个无限循环等待的用户的输入，每得到用户的一行输入，就进行解析，并根据解析结果执行特定的任务。

## 完成重编译命令

## 完成调试模式

## 作业提交

在完成以上任务后，你需要提交第零阶段作业。

!!! Warning "请仔细阅读要求"

    经历过中学阶段教育的大家应该懂得，无论作业完成情况如何，**没交就是没做**。
    
    且由于项目的工程性质，提交项目作业的流程可能对于没有经验的同学比较复杂，但按要求提交作业对于我们的批改工作进行是至关重要的（我们可能使用脚本来对你的作业进行评分）。

    **因此，我们不对任何由于没有按要求进行提交的得分损失负责。**

!!! Warning "请不要拖延作业"

    第零阶段作业**不接受补交**。
    
    如果你没有在 Hard ddl 前提交第零阶段作业，你将失去该阶段的所有分数（约占项目 15%）。

!!! Warning "请遵守学术诚信"

    若你的项目被定性为抄袭，被记零分的「本次作业」将是**整个第一学期项目**而不是单个阶段。


须提交的作业包含两个部分，一是完成第零阶段后工程的压缩包，二是实验报告。

请把要求的所有文件提交到[这个链接](https://box.nju.edu.cn/u/d/39bef7a8b0eb4229b899/)，**不要重复提交重名的文件**。

### 提交工程压缩包

!!! Warning "请谨慎操作项目文件"

    如果你没有相关经验，建议你在进行作业提交**前**备份项目文件夹，以免意外删除或毁坏项目文件夹的内容。


在提交工程压缩包之前，请**务必在 git 中提交更改**，例如运行：

```
git add .
git commit -m "finish phase0"
```

工程压缩包须使用 `.tar.gz` 格式，并应以 `$(STU_ID)_PSPJ0_$(PLATFORM)_$(VERSION).tar.gz` 命名。

其中 `$(STU_ID)` 应替换为你的学号，`$(PLATFORM)` 应替换为你使用的平台（`PLATFORM := windows | linux`）。该压缩包的体积不应超过 10 MB，若包太大请在上传前运行 `make clean`。

`VERSION` 是你给提交文件指定的版本号（0~99），我们将只处理版本号最大的压缩包。

例如，一位学号为 `211240088` 的同学在 linux 完成了第零阶段工程后，他应当将工程压缩包命名为 `211240088_PSPJ0_linux_0.tar.gz`。

具体地，你可以通过在工程的直接父级路径运行下述命令来获得工程压缩包：

```shell
make -c $(FOLDER_NAME) clean
tar -czvf $(STU_ID)_PSPJ0_$(PLATFORM)_$(VERSION).tar.gz $(FOLDER_NAME)
```

其中 `$(FOLDER_NAME)` 应替换为你项目文件夹的名字。

我们在接受到你的压缩包后，会去除文件名中的 `_$(VERSION)`，并在你使用的平台上依次运行：

```shell
tar -xzvf $(STU_ID)_PSPJ0_$(PLATFORM).tar.gz
cd $(STU_ID)_PSPJ0_$(PLATFORM)
git reset --hard HEAD
cp path/to/std_makefile Makefile
make clean
make shell
```

如果其中的任何一步发生错误，本阶段的工程得分按零分计算。

!!! Warning "请谨慎修改 Makefile"

    我们会用我们的 Makefile 替换你的 Makefile，如果你的 Makefile 行为与我们不同可能会导致测试时出现错误。

    **如果我们发现你为通过项目评分恶意修改了 Makefile，视同抄袭。**

在进入 `shell` 界面后，我们按如下得分点计算项目得分（得分点比例待定）：

+ 运行 `compile` 后能够编译游戏。
+ 编译游戏后，运行 `game` 与 `log` 后表现正常。
+ `debug` 指令能够附加到正在运行的游戏上。
+ 游戏能够以调试模式启动（`game -g`）。
+ `debug -r` 指令能够正确附加到正在运行的调试模式游戏上。

我们还会检查你的代码，如果你的代码不符合编码规范可能会被酌情扣分。

### 提交实验报告

实验报告须使用 Markdown 撰写，并命名为 `$(STU_ID)_PSPJ0_$(VERSION).md`。

??? question "什么是 Markdown"

    Markdown 是一种轻量级的标记语言，你很容易通过搜索[教程](https://markdown.com.cn/basic-syntax/)学会它。

实验报告没有特定的格式要求，只需要可读并含有要求必做的内容即可，但不得包含图片和超链接，文件大小不得超过 6 KB（约 2000 字）。

我们要求你完成的必做内容包括：

+ **如实介绍**你项目的完成情况（可以参考我们设置的得分点，**只要结果不要过程**）。
+ 完成如下思考题：
    + 将输出的前景色设为非高亮绿色，背景色设为非高亮白色的 ANSI 转义序列是什么？
    + 阅读程序闪退时输出的日志，游戏为什么会闪退？闪退时执行了什么代码？
    + 执行 `make shell` 时，编译 `shell.c` 的命令是什么？
    + 如何使用 gdb 定位到程序闪退执行到的那行代码？
    + `shell.c` 中的 `*strchr(str, '\n') = '\0'` 是什么意思？
    + `shell.c` 中的 `cmd = strtok(NULL, " ")` 是什么意思？
    + `cmd_table[]` 的结构体类型的每个成员分别是什么意思？都分别在什么时候用到了？

本项目的第零阶段到此结束。

[^1]:致谢：你现在看到的启动器源代码是 2021 级匡亚明学院计算机方向的孙飞宇同学友情帮助编写的。