FROM mcr.microsoft.com/dotnet/core/sdk:3 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o publish

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3
WORKDIR /app
COPY --from=build-env /app/publish .
ENTRYPOINT ["dotnet", "ApdataTimecardFixer.dll"]
