## Go-CQHTTP&HarukaBot Docker

[![Docker](https://img.shields.io/docker/cloud/automated/xzsk2/gocqhttp-docker)](https://hub.docker.com/repository/docker/xzsk2/gocqhttp-docker)

[Mrs4s/go-cqhttp](https://github.com/Mrs4s/go-cqhttp) 和[SK-415/HarukaBot](https://github.com/SK-415/HarukaBot)的Docker启动环境

```compose
docker compose:
version: '3'
services:
    qqbot:
        restart: always
        volumes:
            - ./cqdata:/cqdata
            - ./haruka_bot:/haruka_bot
        image: 'fall2wish/harukabot_gocq:latest'
```

首次启动后

```bash
docker exec -it qqbot /bin/bash
/cqdata/go-cqhttp
```

输入3（使用反代服务）后关闭docker。
更改/cqdata内的config.yml，

参考[go-cqhttp 帮助中心](https://docs.go-cqhttp.org/guide/config.html)和[Haruka-Bot文档-安装 go-cqhttp部分](https://haruka-bot.sk415.icu/install/install-go-cqhttp.html#%E5%AE%89%E8%A3%85-go-cqhttp)

##示例
```yml
account:
  uin: 1233456 # 机器人QQ账号

servers:
  - ws-reverse:
      universal: ws://127.0.0.1:8080/onebot/v11/ws
```

重新启动docker，进入容器

```bash
docker exec -it qqbot /bin/bash
cd /cqdata
/app/go-cqhttp
```

按提示登录后可正常使用

#感谢：
[GitHub:Mrs4s/Go-CQHTTP](https://github.com/Mrs4s/go-cqhttp)

[GitHub:sakarie9/Go-CQHTTP-Docker](https://github.com/sakarie9/Go-CQHTTP-Docker)

[GitHub:SK-415/HarukaBot](https://github.com/SK-415/HarukaBot)

[dockerhub:theinkstain/haruka-bot](https://hub.docker.com/r/theinkstain/haruka-bot)
