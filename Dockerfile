# 1. Base on Node + Alpine for minimal size
FROM mcr.microsoft.com/dotnet/sdk:9.0

RUN set -uex; \
    apt-get update; \
    apt-get install -y ca-certificates curl gnupg; \
    mkdir -p /etc/apt/keyrings; \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
    | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg; \
    NODE_MAJOR=22; \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" \
    > /etc/apt/sources.list.d/nodesource.list; \
    apt-get update; \
    apt-get install nodejs bash findutils -y; \
    npm install -g sass typescript;

# 2. Set working directory for your mounted project
WORKDIR /src

# 3. Run whatever script is in the project root
#    – if the project’s build-frontend.sh isn’t executable, you can still
#      run it via bash.
ENTRYPOINT ["bash", "./build-frontend.sh"]
