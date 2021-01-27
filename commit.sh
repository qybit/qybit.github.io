#!/bin/bash

# 博客发布项目仓库 和 博客源码项目必须在同级目录

start_time=`date --date='0 days ago' "+%Y-%m-%d %H:%M:%S"`
echo "hugo 打包文件中...."

# 删除 除 .git目录和commit.sh 之外的所有文件和文件夹
rm -rf `ls | egrep -v '(.git|commit.sh)'`

# 先进入 my_blog 博客源代码目录
cd ..
cd my_blog/

# 开始提交源代码
cur_time= time=$(date "+%Y-%m-%d %H:%M:%S")
git add .
git commit -m "auto commit on ${cur_time}"
git push
# 源码保存完毕
echo "源码保存完毕"

# 删除所有内容
rm -rf public/*

# 编译
hugo

# 将 public 下所有文件 全部转移到 qybit下
mv ./public/* ../qybit/

cd ..
cd qybit/


git add .
git commit -m "auto commit on ${cur_time}"
git push

finish_time=`date --date='0 days ago' "+%Y-%m-%d %H:%M:%S"`
duration=$(($(($(date +%s -d "$finish_time")-$(date +%s -d "$start_time")))))
echo "共计耗时：${duration}秒"