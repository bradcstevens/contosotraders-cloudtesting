# Register Azure Resource Providers
az provider register -n Microsoft.OperationsManagement -c
az provider register -n Microsoft.Cdn -c
az provider register -n Microsoft.Chaos -c

# Create SPN 
az ad sp create-for-rbac \
    -n contosotraders-sp \
    --role Owner \
    --scopes /subscriptions/$AZ_SUBSCRIPTION_ID \
    --sdk-auth

# Login with SPN to Azure
az login --service-principal \
    -u $SPN_CLIENT_ID \
    -p $SPN_CLIENT_SECRET \
    --tenant $AZ_TENANT_ID

# Setup Dotnet
apt update
apt upgrade -y
apt install -y software-properties-common
add-apt-repository ppa:dotnet/backports

wget https://download.visualstudio.microsoft.com/download/pr/3e408891-74af-4ccb-9ce8-895f6806a97d/3a589bbf6e264059544cef47be672540/dotnet-sdk-7.0.410-linux-arm64.tar.gz
mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-7.0.410-linux-arm64.tar.gz -C $HOME/dotnet
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

dotnet --info


# Run the Products API Locally
cd src/ContosoTraders.Api.Products/
dotnet user-secrets set "KeyVaultEndpoint" "$KV_ENDPOINT"
dotnet build && dotnet run

cd src/ContosoTraders.Api.Carts
dotnet user-secrets set "KeyVaultEndpoint" "$KV_ENDPOINT"
dotnet build && dotnet run

cd src/ContosoTraders.UI.Website/
npm install
set REACT_APP_APIURL=https://localhost:62300/v1
set REACT_APP_APIURLSHOPPINGCART=https://localhost:62400/v1
set REACT_APP_BASEURLFORPLAYWRIGHTTESTING=http://localhost:3000
npm run start