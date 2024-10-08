

az provider register -n Microsoft.OperationsManagement -c
az provider register -n Microsoft.Cdn -c
az provider register -n Microsoft.Chaos -c

az ad sp create-for-rbac \
    -n contosotraders-sp \
    --role Owner \
    --scopes /subscriptions/$AZ_SUBSCRIPTION_ID \
    --sdk-auth