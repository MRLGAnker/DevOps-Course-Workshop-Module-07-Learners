FROM mcr.microsoft.com/dotnet/sdk:5.0 as build
WORKDIR /source

RUN apt-get update && apt-get install -y curl && curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs
COPY . /source
RUN dotnet restore

WORKDIR /source/DotnetTemplate.Web
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "DotnetTemplate.Web.dll"]