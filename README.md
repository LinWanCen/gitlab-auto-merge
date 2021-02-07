# gitlab-auto-merge

线上自动创建并接受 GitLab 合并请求，不拉代码快速合并

Auto create and accept MR (merge requests) for GitLab online


## 使用指南

### 配置秘钥

edit and upload
```
/etc/profile/gitlab_api.sh
```

### 放置文件与授权

upload and change mode for run permission
```
/var/lib/jenkins/workspace/tool/createMR.sh
/var/lib/jenkins/workspace/tool/acceptMR.sh
chmod 755 /var/lib/jenkins/workspace/tool/createMR.sh
chmod 755 /var/lib/jenkins/workspace/tool/acceptMR.sh
```

### Jenkins 执行脚本

create item set run shell
```shell
source /etc/profile 1>/dev/null 2>&1
export CI_PROJECT_ID=你的项目数字ID
export CI_COMMIT_REF_NAME=源分支名
export TARGET_BRANCH=目标分支名
/var/lib/jenkins/workspace/tool/createMR.sh
/var/lib/jenkins/workspace/tool/acceptMR.sh
```