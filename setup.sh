

az provider register -n Microsoft.OperationsManagement -c
az provider register -n Microsoft.Cdn -c
az provider register -n Microsoft.Chaos -c

az ad sp create-for-rbac \
    -n contosotraders-sp \
    --role Owner \
    --scopes /subscriptions/3523b0e6-bb53-4e87-8340-25c416e26093 \
    --sdk-auth