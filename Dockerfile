# 编译
FROM node:20.19.5-alpine3.21 AS build
WORKDIR /app
COPY . .
RUN npm config set registry https://registry.npmmirror.com && \
    npm install && \
    npm run build && \
    chmod -R 777 /app/dist

FROM lipanski/docker-static-website:2.6.0

# 静态文件路径 /home/static
COPY --from=build /app/dist /home/static/

ENTRYPOINT ["/busybox-httpd", "-f", "-v"]
CMD [ "-p", "5150" ]

# 暴露端口
EXPOSE 5150

LABEL 原项目地址="https://github.com/setube/vue-xiuxiangame"
LABEL 镜像制作者="https://space.bilibili.com/17547201"
LABEL GitHub主页="https://github.com/Firfr/xiuxiangame"
LABEL Gitee主页="https://gitee.com/firfe/xiuxiangame"

# docker buildx build --platform linux/amd64 --tag firfe/xiuxiangame:2025.09.27 --output type=docker .

# docker buildx build --platform linux/arm64 --tag firfe/xiuxiangame:2025.09.27-arm64 --output type=docker .
