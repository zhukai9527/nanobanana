# 基于官方 Deno 镜像
FROM denoland/deno:alpine-1.39.2

# 设置工作目录
WORKDIR /app

# 设置Deno中国镜像源
ENV DENO_DIR=/app/.deno
ENV DENO_MIRROR=https://mirror.deno.com/

# 复制项目文件到容器
COPY . .

# 设置默认环境变量（可被覆盖）
ENV OPENROUTER_API_KEY=""
ENV MODELSCOPE_API_KEY=""
ENV MODELSCOPE_BASE_URL="https://api-inference.modelscope.cn/" 

# 预缓存依赖（使用镜像源）
RUN deno cache --reload main.ts

# 对 Deno 进行权限声明
# --allow-env 允许访问环境变量
# --allow-net 允许网络访问
# --allow-read 允许读取文件（如 serveDir）
# --allow-write 允许写入（如缓存等）
# --unstable 支持部分新 API
# --allow-ffi 解决部分依赖 Deno 的第三方库
# --allow-run 如需运行外部命令则开启
CMD deno run --allow-env --allow-net --allow-read --unstable main.ts

# 暴露端口（默认 8000，可按需更改）
EXPOSE 8000
