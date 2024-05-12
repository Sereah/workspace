#!/bin/bash

file1="/home/luna/.gitconfig"
file2="/home/luna/.gitconfig_gm"
file3="/home/luna/.gitconfig_my"

current_content=""

# 获取文件1的当前内容
get_current_content() {
    current_content=$(cat $file1)
}

# 将文件2的内容复制到文件1
copy_file2_to_file1() {
    cp $file2 $file1
}

# 将文件3的内容复制到文件1
copy_file3_to_file1() {
    cp $file3 $file1
}

# 显示当前文件1的内容是文件2还是文件3
show_current_content() {
    get_current_content
    echo "当前文件1的内容是："
    echo "$current_content"
}

# 提示选择是否切换到另一个文件的内容
prompt_switch_file() {
    echo "是否切换到另一个文件的内容？(y/n)"
    read choice
    case "$choice" in
        y|Y)
            switch_file_content ;;
        n|N)
            echo "退出"
            exit 0 ;;
        *)
            echo "无效的选项，请重新输入"
            prompt_switch_file ;;
    esac
}

# 切换到另一个文件的内容
switch_file_content() {
    if [ "$current_content" = "$(cat $file2)" ]; then
        copy_file3_to_file1
    else
        copy_file2_to_file1
    fi
    echo "切换完成"
}

# 主函数
main() {
    show_current_content
    prompt_switch_file
}

# 执行主函数
main

