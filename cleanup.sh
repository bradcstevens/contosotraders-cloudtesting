
az group delete -n rg-contoso-traders-lab -y --no-wait
az group delete -n '${{ env.RESOURCE_GROUP_NAME }}${{ vars.SUFFIX }}' -y --no-wait
az deployment sub delete -n createResourceGroup --no-wait