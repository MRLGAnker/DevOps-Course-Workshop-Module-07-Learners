FROM mcr.microsoft.com/dotnet/sdk:5.0 as base

WORKDIR /app
RUN apt-get update && apt-get install -y curl && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs
COPY . /app
RUN dotnet build
WORKDIR /app/DotnetTemplate.Web
RUN npm install && npm run build
ENTRYPOINT [ "dotnet" ,"run" ]