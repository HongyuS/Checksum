# HashHawk

一个简洁优雅的 macOS 文件校验和计算器。

[English](README.en.md) | 中文

## 功能特性

- 🔍 **一次读取，生成五种哈希值**：MD5、SHA1、SHA256、SHA384、SHA512
- 🎯 **拖放与文件选择**：支持直接拖入文件，也支持通过右上角按钮打开或替换文件
- 📊 **实时进度显示**：大文件计算时显示处理进度
- 📁 **文件信息展示**：显示文件图标、名称、大小，并可查看完整路径
- 🧪 **哈希值比对**：输入或粘贴任意支持算法的哈希值，自动匹配并显示结果
- 📋 **一键复制**：可直接复制当前选中的哈希结果
- 🌍 **双语本地化**：内置英文与简体中文界面文案
- 🛡️ **沙盒文件访问**：基于用户选择文件的只读权限访问

## 系统要求

### 运行要求

- macOS 26+

### 开发要求

- macOS 26+
- Swift 6+
- Xcode 26+

## 安装与运行

### 从源代码构建

1. 克隆仓库
2. 使用 Xcode 打开 `HashHawk.xcodeproj`
3. 选择 `HashHawk` scheme 后构建并运行

## 使用方法

### 计算文件哈希值

1. **拖放文件**
   - 将文件拖到左侧拖放区域

2. **打开文件**
   - 点击窗口右上角的 **Open File** / **打开文件** 按钮选择文件

3. **查看结果**
   - 应用会自动开始计算哈希值
   - 顶部显示文件图标、名称和大小
   - 点击文件名旁的信息按钮可查看完整路径
   - 在结果卡片中切换 MD5、SHA1、SHA256、SHA384、SHA512

### 验证哈希值

1. 在比对输入框中输入或粘贴哈希值
2. 应用会自动忽略首尾空白、空格并统一大小写后进行比对
3. 若输入值与当前文件的任一支持算法结果一致，将显示匹配状态及对应算法类型
4. 可使用清除按钮快速重置比对输入

### 复制哈希值

点击结果区域中的 **Copy / 复制** 按钮，即可将当前显示的哈希值复制到系统剪贴板。

## 技术栈

- **SwiftUI**：构建 macOS 原生界面
- **Observation**：驱动视图模型状态更新
- **CryptoKit**：流式计算多种哈希算法
- **AppKit**：文件图标、剪贴板等 macOS 原生能力
- **UniformTypeIdentifiers**：文件类型识别
- **Swift Testing**：单元测试

## 项目结构

```text
Checksum/
├── HashHawk/
│   ├── HashHawkApp.swift              # 应用入口
│   ├── HashHawkViewModel.swift        # 文件选择、哈希计算与比对逻辑
│   ├── AppLocalization.swift          # 本地化辅助方法
│   ├── HashHawkLayout.swift           # 布局常量
│   ├── HashResult.swift               # 哈希结果模型
│   ├── HashComparisonResult.swift     # 比对结果模型
│   ├── HashType.swift                 # 哈希算法枚举
│   ├── MainContentState.swift         # 主内容状态模型
│   ├── Localizable.xcstrings          # 英文 / 简中字符串目录
│   └── View/
│       ├── ContentView.swift          # 根视图，包含文件导入入口
│       ├── DropZoneView.swift         # 左侧拖放与打开文件区域
│       ├── MainContentView.swift      # 右侧主内容容器
│       ├── MainContentStateView.swift # 空状态、进度、错误与结果切换
│       ├── SelectedFileInfoView.swift # 文件信息卡片
│       ├── HashResultView.swift       # 哈希结果卡片
│       ├── HashTypeSelectorView.swift # 哈希算法切换控件
│       ├── HashRow.swift              # 哈希值展示与复制
│       └── HashCompareView.swift      # 哈希比对区域
├── HashHawk.xcodeproj/                # Xcode 工程
├── HashHawkTests/                     # 单元测试
└── HashHawkUITests/                   # UI 测试
```

## 开发说明

### 测试

- 在 Xcode 中使用 `⌘ + U` 运行测试
- 当前单元测试覆盖哈希比对、状态重置、文件元数据刷新与字符串目录校验

### 本地化

- 应用文案集中维护在 `HashHawk/Localizable.xcstrings`
- 当前提供英文（`en`）和简体中文（`zh-Hans`）

### 代码风格

项目遵循 Swift 官方代码风格，并优先使用现代 SwiftUI / Observation API。

## 贡献

欢迎提交 Issue 和 Pull Request。

1. Fork 本仓库
2. 创建特性分支
3. 提交修改
4. 推送分支
5. 发起 Pull Request

## 许可证

本项目基于 MIT 许可证开源，详见 [LICENSE](LICENSE)。

## 作者

Hongyu Shi
