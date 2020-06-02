# Tests


## Gravitee (before relase 3)

```bash

# https://docs.gravitee.io/am/2.x/management-api/index.html : la belle interface graphique de l'API
# Obtenir un token 'Gravitee AM API'
#
export GRAVITEE_USER_NAME=admin
export GRAVITEE_USER_PWD=admin
export GRAVITEE_APIM_API_HOST=am.gravitee.io

curl -X POST -k  -u ${GRAVITEE_USER_NAME}:${GRAVITEE_USER_PWD}  https://${GRAVITEE_APIM_API_HOST}:443/management/user/login | jq .
curl -X POST -k  -u ${GRAVITEE_USER_NAME}:${GRAVITEE_USER_PWD}  https://${GRAVITEE_APIM_API_HOST}:443/management/user/login | tee ./my.gravitee-apim.api.token.json

# --
# MAIS ATTENTION ! LE TOKEN EXPIRE TRES RAPIDEMENT !!! :) dans ce cas, faire un logout / login :
#

https://docs.gravitee.io/am/current/am_management_api_documentation.html
```

## Gravitee relase 3

* https://docs.gravitee.io/am/current/am_management_api_documentation.html

* test :

```bash

# https://docs.gravitee.io/am/2.x/management-api/index.html : la belle interface graphique de l'API
# Obtenir un token 'Gravitee AM API'
#
export GRAVITEE_USER_NAME=admin
export GRAVITEE_USER_PWD=admin
export GRAVITEE_APIM_API_HOST=am.gravitee.io

curl -X POST -k  -u ${GRAVITEE_USER_NAME}:${GRAVITEE_USER_PWD}  https://${GRAVITEE_APIM_API_HOST}:443/management/auth/token | jq .
curl -X POST -k  -u ${GRAVITEE_USER_NAME}:${GRAVITEE_USER_PWD}  https://${GRAVITEE_APIM_API_HOST}:443/management/auth/token | tee ./my.gravitee-apim.api.token.json

# --
# MAIS ATTENTION ! LE TOKEN EXPIRE TRES RAPIDEMENT !!! :) dans ce cas, faire un logout / login :
#

POST http(s)://${GRAVITEE_APIM_API_HOST}/management/auth/token HTTP/1.1

curl -X POST \
  http(s)://${GRAVITEE_APIM_API_HOST}/management/auth/token \
  -H 'authorization: Basic base64(admin:adminadmin)' \


```
