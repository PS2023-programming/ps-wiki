# 上手指南

以下将简要介绍问题求解编程实验的上手流程。

!!! info "Unix Shell 环境"
    从 2023 级开始，问题求解编程部分的实验要求在 Unix Shell 环境下完成。这是为了让大家在面对此后将修读的《计算机系统基础》《操作系统》等课程的实验时有一定的 Shell 使用基础，能够更好的生存下来。

!!! Warning "Windows XP/Vista/7/8/8.1 用户请注意"

    微软已经终止了对 Windows XP/Vista/7/8/8.1 的支持，因此本讲义可能涉及的 Windows 系统的较新软件、特性可能在这些系统上不可用。
    
    如果你正在使用这些版本的 Windows，请尝试升级至 Windows 10 或更新的 Windows 版本。如果你的电脑不支持新版 Windows，请尝试（但不限于）用其他方式配置所需环境，更换更新的电脑，安装 Linux 发行版，手动安装 Windows 功能，使用虚拟机运行新版 Windows 等方法。

    如果你正在使用更老的 Windows 版本作为工作环境，请务必更换操作系统或设备。

!!! Warning "MacOS 用户请注意"
    笔者从未使用过 MacOS，所以并不了解 MacOS 如何配置必须的环境，请自行阅读[相关教程](https://sourabhbajaj.com/mac-setup/)。
    
    另外针对 MacOS 用户需要提醒的是，若你未来计划修读课程《数字逻辑与计算机组成实验》，则可能需要准备一台 Windows/Linux 备用机以安装所需的 Vivado 软件。

    但后续课程实验将尽力提供对于 MacOS 环境的兼容性（会在 MacBook 上进行测试）。

## 环境配置

### 安装 MSYS2

!!! info "Linux 用户请注意"

    若你使用 Linux 发行版，则不需要安装 MSYS2。

!!! quote "一言"
    All problems in computer science can be solved by another level of indirection.<br/>
    （计算机科学领域的所有问题都可以通过增加一个中间层解决）
    <div style="text-align:right"> —— David Wheeler </div>

!!! question "为什么不使用自带的命令行工具 `cmd` 或 `powershell`？"

    因为这些命令行工具承自 MS-DOS，具有不同于 Unix Shell 的语法和各种实用程序。你们此后的大部分课程实验都将是在 Linux 环境下进行的，因此使用 Unix Shell 可以更好地为你们将来的课程打下基础。

??? question "什么是 MSYS2"

    MSYS2 基于 Cygwin, Cygwin 是一套能

    Git for Windows 也内置了一套 MSYS2

首先从[官网](https://www.msys2.org/)或者[南大镜像源](https://mirror.nju.edu.cn/mirrorz-help/msys2/?mirror=NJU)下载 MSYS2 安装包并安装。

### 将 MSYS 配置到 Windows 终端

??? question "什么是 Windows 终端？"

    Windows 终端是微软推出的全新一代，并默认支持虚拟终端控制序列（即 ANSI 转义序列，这对于我们的项目进行是必需的！）我们假定所有使用 Windows 平台的读者都可以使用 Windows 终端。

打开 Windows 终端，在标签页下拉菜单中选择设置，点击添加新配置文件。

在名称中输入 `MSYS2`，在命令行一栏中输入：

```plain
$MSYS_PATH\msys2_shell.cmd -defterm -no-start -use-full-path -here -msys2
```

并在图标一栏中选择：

```plain
$MSYS_PATH\msys2.ico
```




### 将 MSYS 配置到 VSCode 终端

??? question "什么是 VSCode？"

### 用 `pacman` 安装工具

我们接下来安装一些完成课程实验必要的工具：

```shell
pacman -S mingw-w64-x86_64-toolchain make git vim man
```

以上命令将为你安装 mingw-w64 工具链、自动化构建工具 GNU make、版本控制系统 git、编辑器 Vim、以及文档查询工具 man。

如果在安装过程中报错了，请检查你的网络环境。如果你确信你的网络环境没有问题，可以使用[南大镜像源](https://mirror.nju.edu.cn/mirrorz-help/msys2/?mirror=NJU)。

!!! question "还是报错怎么办？"
    你需要学会提问。许多讲义都会推荐[提问的智慧](https://github.com/ryanhanwu/How-To-Ask-Questions-The-Smart-Way) 作为

要检查 mingw-w64 工具链是否安装成功，可以执行以下命令：

```shell
g++ --version
```

对于其他工具同理。

!!! info "Linux 用户请注意"

    如果你使用 Linux 发行版，请使用该发行版自带的包管理器安装这些软件，注意 mingw 工具链需要换成 `g++` 和 `binutils`。

!!! question "什么是 `pacman`？"

    `pacman` 是 MSYS2 内建的包管理器。包管理器的作用类似于「应用商店」，负责处理各种软件（只要官方仓库里有）。在安装时需要确保

!!! question "什么是 Vim？"

    Vim 是一个命令行文件编辑器。它可以完全不依赖鼠标和 GUI 而运作，仅靠键盘快捷键实现光标跳转、模式切换、复制粘贴、查找替换等功能。同时，受益于 Vim 内建的 Vimscript 为交互语言的接口，用户可通过 `.vimrc` 为 Vim 配置自定义配置和功能强大的插件。

    Neovim 是 Vim 的一个重构版本，致力于成为 Vim 的超集，它完全兼容 Vim 的各种配置，并可以使用 Lua 这种通用程序设计语言进行配置调整和插件开发。

## 上手实验

### 编译和运行程序

接下来我们来学习如何使用 Unix shell 环境编译和运行程序。顺便借机熟悉一下 Unix shell 以及其包含的若干命令行工具的使用。

在 Windows 终端中打开 MINGW64 Shell，输入 `cd ~` 将目录切换至自己的家目录。

!!! question "这是在干什么？"

    当你打开 shell 时，它总在文件系统的某个特定目录工作，使用 `pwd` 即可看到自己所在的目录，`~` 是家目录的缩写，你的家目录一般是 `/home/$Username`，使用 `realpath ~` 以得到家目录的真实路径名。<br />

    上文要求你输入的命令即是将你当前的工作目录切换至你的家目录，以便于后续新建程序。

!!! question "如何获取帮助？"

    讲义不可能事无巨细地讲述每个命令，因此获取离线或联机帮助是必须的。在遇到不懂的命令时，你当然可以求助于搜索引擎以获取有关于该命令的信息。不过，使用 Shell 内建的 `help` 或 `man` 命令可以帮助你得到命令的信息。<br />
    
    试试键入 `help cd` 或 `man pwd`。

    如果你使用 Linux 发行版，可以试试安装 `tldr` 来获取更加简单的提示。

    如果你可以访问大语言模型聊天机器人，那么也可以试试向它提问。

输入 `vim hello.cpp`，进入 Vim 编辑页面。

!!! tip "在进入 Vim 之前"

    你可能会问：等等，我还不会使用 Vim 呢！

    在使用上述命令之前，试试在终端中键入 `vimtutor`，在接下来出现的界面中你将学会 vim 的基本操作。

    注意：不必将教程进行到最后，学习到能编辑并保存一个文件即可。

在 `vim` 界面中按下 `i` 进入编辑模式并键入一段代码：

```cpp
#include <cstdio>
int main() {
    puts("Hello, Problem Solving!");
    return 0;
}
```

点击 `Esc`，输入 `:wq` 保存文件并退出。

!!! Warning "你是否跳过了学习 Vim 的使用？"

    如果你没有去学习 Vim 的基本操作而直接按照讲义给的详细操作说明完成了刚刚的步骤，那么值得提醒的是：提供如此详细的操作说明并不是讲义的义务。在你们未来可能修读的《计算机系统基础》的课程中，遑论如此基础直接的操作，就算是一个实验任务，你所能得到的也只是几句模棱两可的指导。
    
    *我翻遍整个实验讲义一查，这讲义没有操作说明，歪歪斜斜的每页上都写着「STFW、RTFM、RTFSC」几个缩写。我横竖睡不着，仔细看了半夜，才从字缝里看出字来，满本都写着一句话「[别像弱智一样提问](https://github.com/tangx/Stop-Ask-Questions-The-Stupid-Ways/blob/master/README.md)」！*

    <div style="text-align:right">——《PA 日记》</div>
    
接下来再输入：`g++ hello.cpp -o hello; ./hello`。

如果一切顺利，屏幕上将出现 `Hello, Problem Solving!`。

恭喜你，第一次通过命令行编译并运行了一段 C++ 程序！ ~~（但我相信你们很多人早就不是第一次了）~~

!!! note "进一步学习"
    刚刚编译程序使用的是 GNU Compiler Collection (GCC) 套件的一部分（如果你使用的是 MSYS2 环境，那么你使用的是 GCC 的 mingw-w64 版本）。
    
    `g++` 是 GCC 中的一个强大的 C++ 编译器。若想获取更多 `g++` 的使用方法，试试键入 `man g++`。 

!!! note "使用 VSCode 完成实验"

    事实上，使用 VSCode 代替 Vim 作为编辑器，并使用 VSCode 的内建终端或插件（如 Code Runner）也可以完成上述操作。

    至于使用 VSCode 还是 Vim 作为你们的日常编辑环境，这就见仁见智了。大家可以自行选择。


