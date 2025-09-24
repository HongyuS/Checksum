# Checksum - 文件校验和计算器

一个简洁优雅的 macOS 文件校验和计算器，支持多种哈希算法。

[English](README_EN.md) | 中文

## 功能特性

- 🔍 **多种哈希算法支持** - MD5、SHA1、SHA256、SHA384、SHA512
- 🎯 **拖放支持** - 直接拖拽文件到应用窗口
- 📊 **实时进度显示** - 大文件处理时显示计算进度
- 🔍 **哈希值比较** - 输入已知哈希值进行校验
- 📋 **一键复制** - 点击按钮即可复制哈希值到剪贴板
- 🎨 **优雅界面** - 采用原生 macOS 设计风格
- 📁 **文件信息显示** - 显示文件名、大小和图标

## 系统要求

### 运行系统要求

- macOS 15.1+

### 开发系统要求

- macOS 15.7+
- Swift 6+
- Xcode 26+

## 安装方式

### 从源代码构建

1. 克隆仓库：
```bash
git clone https://github.com/HongyuS/Checksum.git
cd Checksum
```

2. 使用 Xcode 打开项目：
```bash
open Checksum.xcodeproj
```

3. 构建并运行应用

## 使用方法

### 计算文件哈希值

1. **方式一：拖放文件**
   - 将文件直接拖拽到应用的拖放区域

2. **方式二：点击选择**
   - 点击拖放区域，在文件选择对话框中选择文件

3. **查看结果**
   - 应用会显示文件信息（名称、大小、图标）
   - 选择你需要的哈希算法类型（MD5、SHA1、SHA256、SHA384、SHA512）
   - 查看计算出的哈希值

### 验证哈希值

1. 在哈希值比较区域输入或粘贴已知的哈希值
2. 应用会自动检测输入的哈希值类型
3. 显示匹配结果（✓ 匹配 或 ✗ 不匹配）

### 复制哈希值

点击哈希值旁边的复制按钮 📋，即可将哈希值复制到系统剪贴板。

## 技术栈

- **SwiftUI** - 现代化的 UI 框架
- **CryptoKit** - 系统级加密库，提供安全的哈希计算
- **AppKit** - macOS 原生功能集成
- **Foundation** - 核心框架支持
- **UniformTypeIdentifiers** - 文件类型识别

## 项目结构

```
Checksum/
├── ChecksumApp.swift              # 应用入口
├── ChecksumViewModel.swift        # 核心业务逻辑
├── HashResult.swift              # 哈希结果模型
├── HashComparisonResult.swift    # 比较结果模型
└── View/
    ├── ContentView.swift         # 主界面
    ├── DropZoneView.swift        # 拖放区域组件
    ├── HashResultView.swift      # 结果显示组件
    ├── HashProgressView.swift    # 进度显示组件
    ├── HashRow.swift            # 哈希值行组件
    └── HashCompareView.swift    # 比较功能组件
```

## 开发

### 环境设置

1. 确保安装了 Xcode 26+ 或更高版本
2. macOS 15.7+ 或更高版本的开发环境

### 运行测试

```bash
# 在 Xcode 中运行测试
⌘ + U
```

### 代码风格

项目遵循 Swift 官方代码风格规范。

## 贡献

欢迎提交 Issue 和 Pull Request！

1. Fork 这个仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的修改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开一个 Pull Request

## 许可证

本项目基于 MIT 许可证开源。详见 [LICENSE](LICENSE) 文件。

## 作者

**Hongyu Shi** - 初始开发

