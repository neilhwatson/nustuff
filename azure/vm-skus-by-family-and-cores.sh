az vm list-skus --location eastus --subscription 'Aiven Azprod' --query \
  "[?resourceType=='virtualMachines'] \
  | [?family=='standardESv5Family' || family=='standardEPSv5Family' || family=='standardMSFamily'] \
  | [].{family:family, name:name, vCPUs:capabilities[?name=='vCPUs'].value | [0].to_number(@)} \
  | [?vCPUs > \`32\`] | sort_by(@, &family)" --output table

