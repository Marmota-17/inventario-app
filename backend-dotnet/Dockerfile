# Etapa de build con SDK .NET 9
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copiar archivos de solución y proyecto
COPY *.sln ./
COPY API/*.csproj ./API/
RUN dotnet restore "API/API.csproj"

# Copiar todo el código y publicar
COPY . ./
WORKDIR /src/API
RUN dotnet publish "API.csproj" -c Release -o /app/publish

# Etapa de runtime con ASP.NET Core
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish ./
EXPOSE 5043
ENTRYPOINT ["dotnet", "API.dll"]