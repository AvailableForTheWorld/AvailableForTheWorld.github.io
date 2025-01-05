---
layout: post
title: Jekyll Tutorial
date: 2025-01-05 23:50:00 +0800
tags: [tutorial]
---

# what's jekyll

jekyll 是一个集成在[GitHub Pages](https://docs.github.com/zh/pages)中的静态站点生成器，通过极其简单的语法和规则构建整个静态站点，作为一个想要免费使用 GitHub Pages 搭建博客的人来说，jekyll 是不二之选。

# why jekyll

1. Github Pages 的内置集成，官方推荐使用 jekyll 作为 GitHub Pages 的静态站点生成器
2. 不用使用繁杂的 Github Actions 即可自动触发 GitHub Pages 的 CICD
3. 对比其他生成器，轻量，学习成本非常低，是最有性价比的博客生成器
4. 以 markdown 为内容载体
5. 丰富的主题样式可供选择，极简配置主题，无需你手动写样式
6. ruby 的配置模式以及工程化对程序员友好

# 45 分钟指南

## 5 分钟下载/安装

1. 安装 ruby installer
   [RubyInstaller](https://rubyinstaller.org/downloads/)

选择最新版带有 DEVKIT 的 Ruby 版本
![image.png](https://s2.loli.net/2024/12/03/sRDB5tZyLjrAh7E.png) 2. 安装完成后，在命令行输入`ridk` , 你可以看到会有 ruby install 的样式 icon 显示，此时在命令行输入`ridk install` 并且选择 MSYS2 and MINGW development toolchain, 键入 3，即下图
![image.png](https://s2.loli.net/2024/12/03/2VzlOoMSvugYIqG.png)

如果出现`错误：无法初始化事务处理 (无法锁定数据库) 错误：无法锁定数据库：Permission denied` 请使用管理员身份运行。

3. 通过 gem 安装 jekyll 以及 bundler
   命令行输入`gem install jekyll bundler`

## 3 分钟项目搭建

### 2 分钟初始化项目

1. 运行

```shell
bundle init
```

此时会生成 gem file， 里面会自带一行代码：

```gem
source "https://rubygems.org"
```

2. 这个是指定包管理的依赖所配置的源，由于国外服务器访问速度受限的缘故，在没有科学上网工具的情况下，建议换镜像源：

```gem
source "https://mirrors.tuna.tsinghua.edu.cn/rubygems/"
```

3. 此时我们需要在当前文件(Gemfile)中写入安装主要依赖

```gem
gem "jekyll"
```

> 这里的 jekyll 是项目本地依赖而不是之前 gem install 的全局依赖，如果项目中（Gemfile 中）有这个依赖优先用项目依赖中的版本

4. 此时命令行运行

```shell
bundle
```

将安装所有 Gemfile 中的依赖

### 1 分钟运行空项目

1. 创建根文件

```html:index.html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Home</title>
  </head>
  <body>
    <h1>Hello World!</h1>
  </body>
</html>
```

2. 打包初始化项目

命令行运行

```shell
jekyll build
```

此时 jekyll 会将当前根目录以及其所有子目录相关代码打包生成`_site`目录，这里面就是打包后的文件（由于咱们初始化项目看不出来打包痕迹，后面随着内容增加以后，里面的文件会被压缩）

此时目录结构如下

```tree
.
├── _site
│   └── index.html
├── Gemfile
├── Gemfile.lock
└── index.html
```

3. 运行项目

命令行执行

```shell
jekyll serve --livereload --port 3456
```

这里 livereload 是热更新（即每次修改代码都会自动更新，建议加上）--port 指定运行端口 3456

访问`http://localhost:3456/
即可生成初始化项目

## 30 分钟 jekyll 实践指南

### 文件组成

由于 jekyll 是针对 markdown 格式的静态生成器，所以他能将所有以 md/markdown 结尾文件为 markdown 格式的页面视为 html 文件，可以将 markdown 文件当作页面处理。由于 markdown 文件简单易用行，我们可以将除了根文件`index.html`以及后续所说的 layouts 等相关配置型文件使用 html 以外，其余页面使用 md 格式简易处理。

### Front Matter

其被叫做：前置信息，这个是用于写入一些类似于 html 中的 meta 数据，来标识整个文件的信息。在 jekyll 中，每一个 yml/markdown/html 文件都可以在文件开头以如下形式引入：

```
---
变量名：变量值
---
```

### Layout

前端有个叫做 layout 的概念，称为布局，意思是页面的结构模板，我们通过引用/继承布局来快速实现页面结构，所以，现在我们在根目录创建`_layouts`文件夹，在里面创建一个 default.html 文件来表示我们的默认布局，内容如下

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>&#123;&#123; page.title &#125;&#125;</title>
  </head>
  <body>
    &#123;&#123; include navigation.html &#125;&#125; &#123;&#123; content &#125;&#125;
  </body>
</html>
```

此时目录如下

```text:tree.txt
.
├── _layouts
│   └── default.html
├── _site
│   ├── about.html
│   └── index.html
├── about.md
├── Gemfile
├── Gemfile.lock
└── index.html
```

这里面用双花括号括起来的是 jekyll 自带的系统变量，如：

1. page
   page 变量表示整个页面的信息，page.title 会获取页面 Front Matter 中的 title

2. content
   content 变量表示整个页面的内容，比如处在 markdown 文件中的所有文本

使用 layout

这里我们在根目录中创建一个关于的 page，使用 markdown 形式：

```markdown:about.md
---
layout: default
title: About
---

This is XXX. A software developer.
```

访问`http://localhost:3456/about/` 此时我们会看到 about 页面渲染出来，并且页面 tab 标签的 title 也变为了 About

### includes

此时我们发现一个问题：我们很难知道整个项目有什么页面，即：没有导航栏支撑，页面全靠用户手动输入特别麻烦，所以，我们使用 includes 来把整个导航栏加入到 layout 中

includes 被称作重用代码片段，通过将重复的内容抽取到 `_includes` 文件夹中，我们可以在多个页面中轻松插入这些内容，减少重复工作并使代码更加简洁和易于维护。

创建`_includes`文件夹及其在其添加`navigation.html`：

```html:_includes/navigation.html
<nav>
  <a href="/" &#123;&#123; if page.url == "/" &#125;&#125;style="color: red;"&#123;&#123; endif &#125;&#125;>
    Home
  </a>
  <a href="/about.html" &#123;&#123; if page.url == "/about.html" &#125;&#125;style="color: red;"&#123;&#123; endif &#125;&#125;>
    About
  </a>
</nav>
```

由于是代码片段，`navigation.html`不需要保留完整的 html 文件格式，只需要相应的标签片段即可
此时目录格式：

```text:tree.txt
.
├── _includes
│   └── navigation.html
├── _layouts
│   └── default.html
├── _site
│   ├── about.html
│   └── index.html
├── about.md
├── Gemfile
├── Gemfile.lock
└── index.html
```

并且在`default.html`layout 中增加 include 语法：

```html:_layouts/default.html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>&#123;&#123; page.title &#125;&#125;</title>
  </head>
  <body>
    &#123;&#123; include navigation.html &#125;&#125; &#123;&#123; content &#125;&#125;
  </body>
</html>
```

此处&#123;&#123; &#125;&#125; 是专为 jekyll 自带语法的标识符，`include`将引入_includes 目录中的文件作为代码片段使用。

我们访问任意链接（home、about）即可发现页面首部增加了导航栏，点击仍以链接即可跳转

另外我们可以通过 jekyll 系统变量来设置样式，使导航栏的地址出现聚焦态， 这里修改`navigation.html`中的代码：

```html:_includes/navigation.html
<nav>
  <a href="/" &#123;&#123; if page.url == "/" &#125;&#125;style="color: red;"&#123;&#123; endif &#125;&#125;>
    Home
  </a>
  <a href="/about.html" &#123;&#123; if page.url == "/about.html" &#125;&#125;style="color: red;"&#123;&#123; endif &#125;&#125;>
    About
  </a>
</nav>
```

其中 jekyll 的 if 条件判断的语法通过条件判断开始符&#123;&#123; if xxx &#125;&#125;以及结束符&#123;&#123; endif &#125;&#125; 来进行判断，另外如果需要多个 if 判断可以在其中加入&#123;&#123; elsif xxx &#125;&#125; 以及&#123;&#123; else &#125;&#125; 如下：

```html:_includes/navigation.html
<nav>
  <a href="/"
     &#123;&#123; if page.url == "/" &#125;&#125;style="color: red;"&#123;&#123; elsif page.url == "/home.html" &#125;&#125;style="color: blue;"&#123;&#123; else &#125;&#125;style="color: black;"&#123;&#123; endif &#125;&#125;>
    Home
  </a>
  <a href="/about.html"
     &#123;&#123; if page.url == "/about.html" &#125;&#125;style="color: orange;"&#123;&#123; elsif page.url == "/info.html" &#125;&#125;style="color: green;"&#123;&#123; endif &#125;&#125;>
    About
  </a>
</nav>
```

### Data Files

但是我们仍然发现这种配置十分麻烦，需要不断给 navigation 添加各种各样链接， 我们可以通过数据存储文件(Data Files)的方式来配置文件，这种文件配置信息一般存放在`_data`文件夹下，这种配置信息一般存为 yml 格式文件，于是我们创建 `_data/navigation.yml`, 如下：

```yaml:_data/navigation.yml
- name: Home
  link: /
- name: About
  link: /about.html
```

`_data`文件夹中的信息是由 jekyll 系统变量`site.data`访问，如上面的数组化结构即`site.data.navigation`, 此时我们修改原来的 navigation 文件,`_includes/navigation.html`：

```html:_includes/navigation.html
<nav>
  &#123;&#123; for item in site.data.navigation &#125;&#125;
    <a href="{{ item.link }}" &#123;&#123; if page.url == item.link &#125;&#125;style="color: red;"&#123;&#123; endif &#125;&#125;>
      &#123;&#123; item.name &#125;&#125;
    </a>
  &#123;&#123; endfor &#125;&#125;
</nav>
```

这里我们使用了 jekyll 中的 for in 循环语法，大大简化后期导航栏数据量剧增的逻辑

### Assets

此时我们发现样式编辑挺麻烦的，需要对某个链接的 tag 加入行内样式。但其实，jekyll 自带预编译器 sass 支持，我们可以将所有样式/图片文件/js 脚本这里文件放置于 assets 目录中，如下：

```text:tree.txt
.
├── assets
│   ├── css
│   ├── images
│   └── js
...
```

jekyll 处理 sass 默认会找`_sass`对应的文件，我们创建`_sass/main.scss`：

```scss
.current {
  color: green;
}
```

在`assets/css/styles.scss` 我们写入：

```scss
---
---

/* Import styles */
@import 'minima';
@import 'main';
```

并将样式引入到 default 布局中去，`_layouts/default.html`：

```html:_layouts/default.html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>&#123;&#123; page.title &#125;&#125;</title>
    <link rel="stylesheet" href="/assets/css/styles.css" />
  </head>
  <body>
    &#123;&#123; include navigation.html &#125;&#125; &#123;&#123; content &#125;&#125;
  </body>
</html>
```

此时我们可以应用我们所写的样式到 navigation 中，`navigation.html`：

```html:_includes/navigation.html
<nav>
  &#123;&#123; for item in site.data.navigation &#125;&#125;
    <a href="{{ item.link }}" &#123;&#123; if page.url == item.link &#125;&#125;class="current"&#123;&#123; endif &#125;&#125;>&#123;&#123; item.name &#125;&#125;</a>
  &#123;&#123; endfor &#125;&#125;
</nav>
```

页面的聚焦导航链接的样式即变成了绿色

### Blogging

接下来就到我们的博客编写环节，jekyll 默认在`_posts`存放所有博客路径，并且以`日期-文件名.md`的默认格式命名来解析博客内容

1. 我们创造一个博客例子, `_posts/2025-01-05-init.md`：

```markdown:_posts/2025-01-05-init.md
---
layout: default
author: Norman Chen
---

This is a test post.
```

2. 增加一个文章的布局，`_layouts/post.html`, 如下：

```html:_layouts/post.html
---
layout: default
---

<h1>&#123;&#123; page.title &#125;&#125;</h1>
<p>&#123;&#123; page.date | date_to_string &#125;&#125; - &#123;&#123; page.author &#125;&#125;</p>

&#123;&#123; content &#125;&#125;
```

其中 ｜ 类似于 Linux 里面的管道运算符，将左侧数据通过右侧方法加工处理。 `date_to_string` 是 jekyll 自带的日期转字符串的方法。

3. 我们在根目录增加一个 blog 页面来渲染整个博客页面，`blog.md`：

```markdown:blog.md
---
layout: default
title: Blog
---

<h1>Latest Posts</h1>

<ul>
  &#123;&#123; for post in site.posts &#125;&#125;
    <li>
      <h2><a href="{{ post.url }}">&#123;&#123; post.title &#125;&#125;</a></h2>
      &#123;&#123; post.excerpt &#125;&#125;
    </li>
  &#123;&#123; endfor &#125;&#125;
</ul>
```

其中 jekyll 通过`site.posts`获取`_posts`中所有文章内容生成一个数组结构，每一项包含： 1. url 标识每个文章地址 2. title 可以自动从文章名中获取 3. excerpt 则截取 markdown 中第一段的内容

4. 修改 data files 里面的 blog 页面配置：

```yaml:_data/navigation.yml
- name: Home
  link: /
- name: About
  link: /about.html
- name: Blog
  link: /blog.html
```

此时我们自己在多创建几个博客页面，就能在项目中的 Blog 页面中分别看到对应信息了。

### Collections

以上是所有 jekyll 基础内容，不过从上述内容我们发现，类似于`_layouts`,`_includes`这些都是 jekyll 指定好了的系统级集合，如果我们需要自己的集合并在页面中使用则需要自己配置.
我们需要在项目根目录中创建一个项目配置文件,比如创建一个作者集合用于标识文章的不同作者：

```yaml:_config.yml
collections:
  authors:
```

改写了根目录的配置需要重启项目，CTRL+C 打断项目进程再执行：

```shell
jekyll serve --livereload --port 3456
```

此时我们需要给这个类型加入作者的信息，比如，创建`_authors/jill.md`：

```markdown:_authors/jill.md
---
short_name: jill
name: Jill Smith
position: Chief Editor
---

Jill is an avid fruit grower based in the south of France.
```

以及`_authors/ted.md`：

```markdown:_authors/ted.md
---
short_name: ted
name: Ted Doe
position: Writer
---

Ted has been eating fruit since he was baby.
```

我们创建一个新的页面来显示全体作者，`staff.md`：

```markdown:staff.md
---
layout: default
title: Staff
---

<h1>Staff</h1>

<ul>
 &#123;&#123; for author in site.authors &#125;&#125;
   <li>
      <h2><a href="{{ author.url }}">&#123;&#123; author.name &#125;&#125;</a></h2>
     <h2>&#123;&#123; author.name &#125;&#125;</h2>
     <h3>&#123;&#123; author.position &#125;&#125;</h3>
     <p>&#123;&#123; author.content | markdownify &#125;&#125;</p>
   </li>
 &#123;&#123; endfor &#125;&#125;
</ul>
```

这里面使用了管道运算符 markdown 格式化来处理 author 的文本信息
从根目录配置的 authors 可以直接从 site 通过`site.authors`访问

修改导航配置数据，`_data/navigation.yml`：

```yaml:_data/navigation.yml
- name: Home
  link: /
- name: About
  link: /about.html
- name: Blog
  link: /blog.html
- name: Staff
  link: /staff.html
```

但此时我们发现配置的 staff 页面没有我们刚刚设置的内容，这是由于在\_config.yml 配置的集合字段默认不会给页面中展示，所以我们需要修改配置打开它，`_config.yml`：

```yaml:_config.yml
collections:
  authors:
    output: true

defaults:
  - scope:
      path: ''
      type: 'authors'
    values:
      layout: 'author'
  - scope:
      path: ''
      type: 'posts'
    values:
      layout: 'post'
  - scope:
      path: ''
    values:
      layout: 'default'
```

重启以后不在需要在页面上配置 layout 布局 Front Matter 了（所有原先在 Front Matter 上吗配置的 layout 均可以移除）

## 2 分钟 GitHub Pages 项目部署

项目部署非常简单,只需要两步

1. 新建 github.io 项目仓库
   以用户名.gitlab.io 的名称创建 GitHub 仓库（这里由于我创建过所以无法新建仓库）
   ![image.png](https://s2.loli.net/2025/01/05/TpCbrkX5wWy7PKj.png)

2. 指定对应的文件夹并保存
   ![image.png](https://s2.loli.net/2025/01/05/Nb2tOQREG34uIga.png)

当项目在当前所选分支（此为 main 分支）上并以当前子目录（从图中看出我是将整个项目放置于子目录的 docs 文件夹中，这个因个人想法而异，当你的 git 地址与项目重合后可以选择 root 作为当前分支子文件夹路径，如下图）
![image.png](https://s2.loli.net/2025/01/05/IvSaex4NUbykTHg.png)

此时选择右侧上方 Visit site 按钮即可进入到对应链接。

## 5 分钟主题选择

配置博客最有成就感的就是主题配置了

这里使用 minima 这一主题进行配置：

1. 修改原来的依赖安装

```text:Gemfile
source "https://mirrors.tuna.tsinghua.edu.cn/rubygems/"

# Use github-pages gem which will provide the correct Jekyll version
gem "github-pages", "~> 228"
gem "minima", "~> 2.5.1"
gem "faraday-retry"
gem "kramdown-parser-gfm"
gem "webrick"
gem "wdm", ">= 0.1.0" if Gem.win_platform?

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem "jekyll-seo-tag", "~> 2.8"
end
```

这里一开始只需新增 minima 依赖但是其又依赖后面几项才能保证稳定运行，所以均加上

2. 在`_config.yml`中进行主题配置

```yaml:_config.yml
domain: ～～～～替换成你的域名～～～～
url: ～～～～替换成你的链接～～～～
baseurl: ""
title: my blog
email: ～～～～替换成你的邮箱～～～～
description: >- # this means to ignore newlines until "baseurl:"
  for blog posts
github_username: jekyll

# Theme settings
theme: minima
plugins:
  - jekyll-feed
  - jekyll-seo-tag

# Minima specific settings
minima:
  date_format: '%b %-d, %Y'
  social_links:
    github: jekyll

# Build settings
sass:
  sass_dir: _sass
```

3. 在 css 中引入 minima 样式

```scss
---
---

/* Import styles */
@import 'minima';
@import 'main';
```

等项目部署完成（不到 1 分钟）即可访问带有主题的链接

&#123;&#123; ... &#125;&#125;

# Layout Examples

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>&#123;&#123; page.title &#125;&#125;</title>
  </head>
  <body>
    &#123;&#123; content &#125;&#125;
  </body>
</html>
```

# Navigation Examples

```html
<nav>
  <a href="/" &#123;&#123; if page.url == "/" &#125;&#125;style="color: red;"&#123;&#123; endif &#125;&#125;>
    Home
  </a>
  <a href="/about.html" &#123;&#123; if page.url == "/about.html" &#125;&#125;style="color: red;"&#123;&#123; endif &#125;&#125;>
    About
  </a>
</nav>
```

# Multiple Conditions Example

```html
<nav>
  <a href="/"
     &#123;&#123; if page.url == "/" &#125;&#125;style="color: red;"&#123;&#123; elsif page.url == "/home.html" &#125;&#125;style="color: blue;"&#123;&#123; else &#125;&#125;style="color: black;"&#123;&#123; endif &#125;&#125;>
    Home
  </a>
  <a href="/about.html"
     &#123;&#123; if page.url == "/about.html" &#125;&#125;style="color: orange;"&#123;&#123; elsif page.url == "/info.html" &#125;&#125;style="color: green;"&#123;&#123; endif &#125;&#125;>
    About
  </a>
</nav>
```

# Data Files Example

```html
<nav>
  &#123;&#123; for item in site.data.navigation &#125;&#125;
    <a href="{{ item.link }}" &#123;&#123; if page.url == item.link &#125;&#125;style="color: red;"&#123;&#123; endif &#125;&#125;>
      &#123;&#123; item.name &#125;&#125;
    </a>
  &#123;&#123; endfor &#125;&#125;
</nav>
```

# Blog Post Example

```html
<h1>&#123;&#123; page.title &#125;&#125;</h1>
<p>&#123;&#123; page.date | date_to_string &#125;&#125; - &#123;&#123; page.author &#125;&#125;</p>

&#123;&#123; content &#125;&#125;
```

# Blog List Example

```html
<ul>
  &#123;&#123; for post in site.posts &#125;&#125;
  <li>
    <h2><a href="{{ post.url }}">&#123;&#123; post.title &#125;&#125;</a></h2>
    &#123;&#123; post.excerpt &#125;&#125;
  </li>
  &#123;&#123; endfor &#125;&#125;
</ul>
```

# Collection Example

```html
<ul>
  &#123;&#123; for author in site.authors &#125;&#125;
  <li>
    <h2><a href="{{ author.url }}">&#123;&#123; author.name &#125;&#125;</a></h2>
    <h3>&#123;&#123; author.position &#125;&#125;</h3>
    <p>&#123;&#123; author.content | markdownify &#125;&#125;</p>
  </li>
  &#123;&#123; endfor &#125;&#125;
</ul>
```

# Configuration Examples

```yaml
collections:
  authors:
    output: true

defaults:
  - scope:
      path: ''
      type: 'authors'
    values:
      layout: 'author'
  - scope:
      path: ''
      type: 'posts'
    values:
      layout: 'post'
  - scope:
      path: ''
    values:
      layout: 'default'
```
&#123;&#123; ... &#125;&#125;
