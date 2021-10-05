#!/bin/bash
url_link='https://mirrors.tuna.tsinghua.edu.cn/epel//7/SRPMS/Packages/v/'
for i in `cat rpmlist`;
do
 wget  --no-check-certificate $url_link/$i -P packages/
done
