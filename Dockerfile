# 1. Base on Node + Alpine for minimal size
FROM node:22-alpine

# 2. Add bash (so your .sh scripts run reliably) and install global CLIs
RUN apk add --no-cache bash \
    && npm install -g sass typescript

# 3. Set working directory for your mounted project
WORKDIR /src

# 4. Run whatever script is in the project root
#    – if the project’s build-frontend.sh isn’t executable, you can still
#      run it via bash.
ENTRYPOINT ["bash", "./build-frontend.sh"]
