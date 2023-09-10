# 理论环境配置

本页面会提供一些理论部分需要用到的编程环境的配置指南。

**本指南是非官方的，仅供参考。**

本页面的所有环境配置都基于 Windows 的 MSYS2 环境，在[上手指南](../quickstart/#msys2)中已经介绍过。

!!! info "Linux 用户请注意"
    请使用你所使用的发行版的包管理器安装这些软件/工具。

!!! info "MacOS 用户请注意"
    请使用 [homebrew](https://brew.sh/) 安装这些软件/工具。

其实本页提到的绝大部分包你可以在 [MSYS2 包列表](https://packages.msys2.org/)找到，而不用我来列出。

## Latex

### 安装 Tex Live

```shell
pacman -S mingw-w64-x86_64-texlive-full
```

要验证是否安装成功，输入 `xelatex --version`（后面同理，不再重复）。

此后你就可以通过 `xelatex example.tex` 来编译任何 `.tex` 文件啦。

???+ question "为什么要用 xelatex"

    因为它对中文的支持最好，如果换用其他的编译器可能会在你输入中文的时候出现编译错误。

### 结合 VSCode

现在你可以使用 Tex Live 自带的 IDE 来进行编辑和编译 `.tex` 文件。但我不推荐你这样做，而是使用安装了 Latex Workshop 拓展的 VSCode 来进行编辑和编译。

在 VSCode 中安装该拓展后，你需要对其进行配置。

在 `Settings.json` 中，增加一个 `tool`：

```json
"latex-workshop.latex.tools": [
  {
    "name": "xelatex",
    "command": "xelatex",         // 使用 xelatex
    // 以下是你希望拓展运行该工具时添加的参数
    "args": [
      "-synctex=1",               // 用 SyncTex 生成源文档标记信息
      "-interaction=nonstopmode", // 报错时不停下
      "-file-line-error",         // 在报错中添加行号
      "-shell-escape",            // 允许执行 shell 命令
      "%DOCFILE%"                 // 这是一个传入变量，表示目标文件名
    ]
  },
]
```

???+ question "如何打开这个文件？"
    按 `Ctrl+Shift+P` 打开命令面板，输入 Preferences: Open User Settings (JSON)，回车。

    注意：*讲义不会在许多地方重复这种细节。如果你发现讲义提到的操作细节你不太会，请首先在网上搜索。*


当你对 `example.tex` 运行该 `tool` 时，拓展将会自动执行 `xelatex -synctex=1 -interaction=nonstopmode -file-line-error -shell-escape example.tex`。

你可以通过 `xelatex --help` 或 `man xelatex` 来探索 `args` 可以加入的更多参数。

Latex Workshop 并不直接使用 `tool`，我们需要添加一个指定 `tool` 使用的 `recipe`。

继续在 `Settings.json` 中增加一个 `recipe`：

```json
"latex-workshop.latex.recipes": [
  {
    "name": "xelatex",
    "tools": [
      "xelatex"
    ]
  }
]
```

???+ note "阅读文档"
    Latex Workshop 的配置较为复杂。若遇到类似的需要复杂配置的拓展，你可以通过查看拓展信息中的文档来深入学习。
    
    例如，Latex Workshop 的文档就在[此处](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile)。

    当然，你也可以在中文互联网上诸如[「配置 VSCode + Tex Live 2020 环境」](https://zhuanlan.zhihu.com/p/58811994)的帖子上找到现成的配置，但是它们往往容易出现少量的不兼容问题（往往是因为路径硬编码，或者它们本身就是错的），而使得你一头雾水，事倍功半。~~别问我怎么知道~~

## Coq

Windows 用户可以在[官网](https://coq.inria.fr/download)下载 coq（无法通过包管理器安装，需要自己配置环境变量）。

其他系统用户可以在[这里](https://repology.org/project/coq/versions)查看你们的包管理器中 coq 的包名。

在[这里](https://coq.inria.fr/refman/index.html)阅读 coq 的教程。

## Haskell

Haskell 不能通过 MSYS2 的包管理器安装。相反 Windows 平台的 Haskell 环境通常有一个自己的包管理器并集成了 MSYS2（类似 Git for Windows），如果复用你自己的 MSYS2 可能会导致和 pacman 安装的其他包冲突。

具体的配置流程详见[这篇帖子](https://zhuanlan.zhihu.com/p/559892399)。


## Prolog

幸运的是 Swi-prolog 在 MSYS2 包仓库中存在，因此我们执行：

```shell
pacman -S mingw-w64-x86_64-swi-prolog
```

执行 `swipl --version` 验证安装。

