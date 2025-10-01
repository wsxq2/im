# im
基于 Rime 定制的五笔输入法，以在各平台获得相同的输入体验

Rime 本身只是一个 [lib](https://github.com/rime/librime)，提供输入法框架，并非输入法本身，每个平台都有相应的输入法实现（下面只列一些我用到的）：

* Windows: [Weasel]
* Linux: [ibus-rime](https://github.com/rime/ibus-rime)
* Android: [Trime]

Rime 使用 [plum](https://github.com/rime/plum/tree/master) 管理输入法方案（如五笔等），但也可不使用它，直接 copy 相关配置文件即可。

本仓库主要使用 [wubi](https://github.com/rime/rime-wubi)，它依赖于 [pinyin-simp](https://github.com/rime/rime-pinyin-simp)，所以对这两个方案使用 git submodule 引用，以减少配置文件。

## 相关资料

[Rime]:

* [UserGuide · rime/home Wiki](https://github.com/rime/home/wiki/UserGuide)
* [CustomizationGuide · rime/home Wiki](https://github.com/rime/home/wiki/CustomizationGuide)
* [RimeWithSchemata · rime/home Wiki](https://github.com/rime/home/wiki/RimeWithSchemata)

[Trime]:

* [UserGuide · osfans/trime Wiki](https://github.com/osfans/trime/wiki/UserGuide)
* [trime.yaml 詳解 · osfans/trime Wiki](https://github.com/osfans/trime/wiki/trime.yaml-%E8%A9%B3%E8%A7%A3)

[Weasel]:

* [weasel.yaml 速查 · rime/weasel Wiki](https://github.com/rime/weasel/wiki/weasel.yaml-%E9%80%9F%E6%9F%A5)

实战：

* [使用 Trime 在 Android 上输入五笔 \| wzyboy’s blog](https://wzyboy.im/post/1251.html)
* [KyleBing/rime-wubi86-jidian: 86五笔极点码表 for 鼠须管(macOS)、小狼毫(Windows)、中州韵(Ubuntu) 、仓（iOS）、同文（Android）](https://github.com/KyleBing/rime-wubi86-jidian)
* [ssnhd/rime: Rime Squirrel 鼠须管配置文件（朙月拼音、小鹤双拼、自然码双拼）](https://github.com/ssnhd/rime)

## 使用方法

### Linux

首先安装 ibus-rime：

```
sudo apt install ibus-rime
```

然后复制配置文件：

```
make linux
```

然后在设置中添加该输入法：Settings - Keyboard - Input Sources - 加号 - 搜索 Chinese(Rime) 并添加，然后使用`<Win+Space>`快捷键切换到该输入法。

如果没有桌面但需要通过 X11 打开 GUI 应用输入中文，则可以使用以下命令配置并启动输入法：

```bash
# 配置环境变量及启动相关程序
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
ibus-daemon -drx
# 稍等一下（例如 10s）再执行以下命令
ibus engine rime
```

为了方便使用，可以将以上命令写入到 `~/.bashrc`：

```bash
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# start ibus-daemon
function sid() {
    if ! pgrep -x ibus-daemon > /dev/null; then
        (eval "$(dbus-launch --sh-syntax)" && ibus-daemon -drxR && sleep 10 && ibus engine rime) &
    fi
}
```

后续直接执行 `sid` 即可准备就绪，准备就绪后即可打开相关 GUI 应用。

### Windows

首先下载安装 [Weasel]。然后在 Git Bash 中执行以下命令复制配置文件：

```bash
make windows
```

遇到过的问题：

1. 复制内容后切换到另一窗口中，输入字符异常（不管中英文）？参见 <https://github.com/rime/weasel/issues/1656#issuecomment-3178362487>
1. 微软官方的拼音输入法也有个奇怪的现象，即在 github issue 处中文模式下输入第一个字符时异常，原因未知。

### android

准备工作：

1. 从官网下载安装 [F-Droid](https://f-droid.org/en/)。F-Droid 是一个安卓下的包管理工具，用于安装 Google Play 无法安装的某些程序。
2. 从 F-Droid 安装 [termux](https://termux.dev/en/)。

   > 注意，虽然从 Google Play 也能安装，但那个版本不稳定，[官方也不推荐](https://github.com/termux/termux-app?tab=readme-ov-file#google-play-store-experimental-branch)。

   安装完成后需要配置储存访问权限，直接在 termux 中执行以下命令即可：

   ```bash
   termux-setup-storage
   ```

   详见 <https://wiki.termux.com/wiki/Termux-setup-storage>

   此外还需要安装一些包：

   ```bash
   pkg install git openssh make neovim -y
   ```

3. 从 F-Droid 安装 [Trime]。

使用步骤：

1. 打开 Trime App，启用该输入法并切换到该输入法
1. 打开 Termux 并执行以下命令以完成文件复制：

   ```
   make android
   ```

1. 进入 Trime App 启用五笔方案并点击部署

具体可参考[官方图解](https://user-images.githubusercontent.com/16501929/39121157-583bfda6-4723-11e8-9cf0-b08718ca127e.jpg)

[Weasel]: https://github.com/rime/weasel
[Trime]: https://github.com/osfans/trime
[Rime]: https://github.com/rime/librime
