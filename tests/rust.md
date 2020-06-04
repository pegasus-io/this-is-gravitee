# Tests



## Gravitee `latest` (before relase 3)

# Tests de l'API `Gravitee APIM`


* Scénario `User Story` complète  :

```bash
# https://docs.gravitee.io/am/2.x/management-api/index.html : la belle interface graphique de l'API
# Obtenir un token 'Gravitee AM API'
#
# ---
# 192.168.1.28 am.gravitee.io apim.gravitee.io gravitee.io
# ---
#
export GRAVITEE_USER_NAME=admin
export GRAVITEE_USER_PWD=admin
export GRAVITEE_APIM_API_HOST=apim.gravitee.io

curl -X POST -k  -u ${GRAVITEE_USER_NAME}:${GRAVITEE_USER_PWD}  https://${GRAVITEE_APIM_API_HOST}:443/management/user/login | jq .
curl -X POST -k  -u ${GRAVITEE_USER_NAME}:${GRAVITEE_USER_PWD}  https://${GRAVITEE_APIM_API_HOST}:443/management/user/login | tee ./my.gravitee-apim.api.token.json


# --
# MAIS ATTENTION ! LE TOKEN EXPIRE TRES RAPIDEMENT !!! :) dans ce cas, faire un logout / login :
#
curl -X POST -k  -u ${GRAVITEE_USER_NAME}:${GRAVITEE_USER_PWD}  https://${GRAVITEE_APIM_API_HOST}:443/management/user/logout | jq .
curl -X POST -k  -u ${GRAVITEE_USER_NAME}:${GRAVITEE_USER_PWD}  https://${GRAVITEE_APIM_API_HOST}:443/management/user/login | tee ./my.gravitee-apim.api.token.json

# ça, ça marche : j'ai bien obtenu un [GRAVITEE_APIM_API_TOKEN]
#
# --
export GRAVITEE_APIM_API_TOKEN=$(cat ./my.gravitee-apim.api.token.json | jq -r '.token')
echo "GRAVITEE_APIM_API_TOKEN=[${GRAVITEE_APIM_API_TOKEN}]"


# --
# ci dessous ça marche :
# Comment afficher les détails d'info les plus fins, pour
# un utilisateur donné, d'une API gérée par [Gravtiee APIM]
#
export URL_APPEL_GRAVITEE_AM_API="https://${GRAVITEE_APIM_API_HOST}:443/management/users/${GRAVITEE_USER_NAME}"
curl -X GET -k -H 'Accept: application/json' -H "Authorization: Bearer ${GRAVITEE_APIM_API_TOKEN}" "${URL_APPEL_GRAVITEE_AM_API}" | tee apporte| jq .
echo ''
echo " So the [${GRAVITEE_USER_NAME}] user is not a user, as this [Gravitee AIM API] Endpoints understand"
echo " Those are the users of the APIs managed by [Gravitee APIM]"
echo ''

# --
# ci-dessous : comment lister les utilisateurs d'API gérées par [Gravitee APIM].
export URL_APPEL_GRAVITEE_AM_API="https://${GRAVITEE_APIM_API_HOST}:443/management/users"
curl -X GET -k -H 'Accept: application/json' -H "Authorization: Bearer ${GRAVITEE_APIM_API_TOKEN}" "${URL_APPEL_GRAVITEE_AM_API}" | tee apporte| jq .

# --
# ci dessous : comment lister les ressources externes configurées, dispnibles.
export URL_APPEL_GRAVITEE_AM_API="https://${GRAVITEE_APIM_API_HOST}:443/management/resources"

curl -X GET -k -H 'Accept: application/json' -H "Authorization: Bearer ${GRAVITEE_APIM_API_TOKEN}" "${URL_APPEL_GRAVITEE_AM_API}" | tee apporte | jq .

# --
# ci dessous : comment lister les ressources externes configurées, dispnibles.
export URL_APPEL_GRAVITEE_AM_API="https://${GRAVITEE_APIM_API_HOST}:443/platform/analytics"

curl -X GET -k -H 'Accept: application/json' -H "Authorization: Bearer ${GRAVITEE_APIM_API_TOKEN}" "${URL_APPEL_GRAVITEE_AM_API}" | tee apporte | jq .


```





# Rebbot Tests de l'API `Gravitee AM`


* Scenario :
  * [`Gravitee APIM`] créer une API, nommee `apiVerte`
  * [`Gravitee APIM`] créer un subscribe plan, nommé `offreplatinum`, pour l' `apiVerte`.
  * [`Gravitee AM`] créer un client, de cleint ID `jblClientIDvert`
  * [`Gravitee APIM`] créer une application , nommee `appliVerte`, associé au client `jblClientIDvert`, avec une sécurisation de type `API_KEY`,
  * [`Gravitee APIM`] avec l'application `appliVerte`, souscrire au subscribe plan `offreplatinum`, de l' `apiVerte`


* implémentation :

```bash

# -------------------------------------------------------------------------
# ENV 'Gravitee AM API'
# -------------------------------------------------------------------------
#
export GRAVITEE_AM_USER_NAME=admin
export GRAVITEE_AM_USER_PWD=adminadmin
export GRAVITEE_AM_API_HOST=am.gravitee.io

# -------------------------------------------------------------------------
# ENV 'Gravitee AM APIM'
# -------------------------------------------------------------------------
#
export GRAVITEE_APIM_USER_NAME=admin
export GRAVITEE_APIM_USER_PWD=admin
export GRAVITEE_APIM_API_HOST=apim.gravitee.io

# ---
# Obtenir un token 'Gravitee AM API'
# ---

curl -X POST -k  -u ${GRAVITEE_AM_USER_NAME}:${GRAVITEE_AM_USER_PWD}  https://${GRAVITEE_AM_API_HOST}:443/admin/token | jq .
curl -X POST -k  -u ${GRAVITEE_AM_USER_NAME}:${GRAVITEE_AM_USER_PWD}  https://${GRAVITEE_AM_API_HOST}:443/admin/token | tee ./my.gravitee-am.api.token.json

export GRAVITEE_AM_API_TOKEN=$(cat ./my.gravitee-am.api.token.json | jq -r '.access_token')

echo "GRAVITEE_AM_API_TOKEN=[${GRAVITEE_AM_API_TOKEN}]"

```



# Tests de l'API `Gravitee AM`


* Appeler l'API `Gravitee AM`, avec `curl`, une fois que l'on dispose d'un Token Valide :
* Appeler l'API `Gravitee AM`, avec `curl`, une fois que l'on dispose d'un Token Valide :

```bash
# https://docs.gravitee.io/am/2.x/management-api/index.html : la belle interface graphique de l'API
# Obtenir un token 'Gravitee AM API'
#
export GRAVITEE_USER_NAME=admin
export GRAVITEE_USER_PWD=adminadmin
export GRAVITEE_AM_API_HOST=gravitee-am.pegasusio.io
export GRAVITEE_AM_API_HOST=am.gravitee.io

curl -X POST -k  -u ${GRAVITEE_USER_NAME}:${GRAVITEE_USER_PWD}  https://${GRAVITEE_AM_API_HOST}:443/admin/token | jq .
curl -X POST -k  -u ${GRAVITEE_USER_NAME}:${GRAVITEE_USER_PWD}  https://${GRAVITEE_AM_API_HOST}:443/admin/token | tee ./my.gravitee-am.api.token.json

export GRAVITEE_AM_API_TOKEN=$(cat ./my.gravitee-am.api.token.json | jq -r '.access_token')

# aficher les infos de son propre user gravitee
curl -k -H 'Accept: application/json' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" https://${GRAVITEE_AM_API_HOST}:443/management/user | jq .

# Lister les "security domains", sortes de realms , pour les "clients" au sens de Gravitee AM : Un même domaine peut être associé à plusieurs clients.
curl -k -H 'Accept: application/json' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET https://${GRAVITEE_AM_API_HOST}:443/management/domains | jq .

curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET "https://${GRAVITEE_AM_API_HOST}:443/management/domains" | tail -n 1 | jq .

# --- créer un "domaine" gravitee, de nom "voyonsdomaine"
curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' --data '{"name":"voyonsdomaine"}' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X POST "https://${GRAVITEE_AM_API_HOST}:443/management/domains"

# --- ré-afficher les du domaine gravitee qui vient d'être créé
curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' --data '{"name":"voyonsdomaine", "enabled" : true}' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET "https://${GRAVITEE_AM_API_HOST}:443/management/domains/" | tail -n 1  | jq '.[]'

# --- enabling gravitee security domain "voyonsdomaine"
curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' --data '{"name":"voyonsdomaine", "enabled" : true}' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X PUT "https://${GRAVITEE_AM_API_HOST}:443/management/domains/voyonsdomaine"

# --- ré-afficher les infos du domaine gravitee qui vient d'être créé
curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' --data '{"name":"voyonsdomaine", "enabled" : true}' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET "https://${GRAVITEE_AM_API_HOST}:443/management/domains/" | tail -n 1  | jq '.[]'

# --- créer un "client" gravitee
# Client ID du client, derrière est retourné le cleint secret
export GRAVITEE_AM_CLIENT_ID=jblClientID
export GRAVITEE_SEC_DOMAIN=voyonsdomaine

echo "Attention, le ClientSecret ne sera visible que mainrtenant, il ne le sera plus jamais accessible (il faudra détruire le client et le re-créer, pour retrouver une paire complète clinetId / ClientSecret)"

curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' --data "{\"clientId\":\"${GRAVITEE_AM_CLIENT_ID}\"}" -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X POST "https://${GRAVITEE_AM_API_HOST}:443/management/domains/voyonsdomaine/clients" | tail -n 1 | jq . | tee ./clientFullInfos.gravitee

cat ./clientFullInfos.gravitee | jq .

# Lister les clients Gravitee
curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET "https://${GRAVITEE_AM_API_HOST}:443/management/domains/${GRAVITEE_SEC_DOMAIN}/clients" | tail -n 1 | jq .

export GRAVITEE_AM_CLIENT_ID=$(cat ./clientFullInfos.gravitee | jq .[].clientId | awk -F '"' '{print $2}')
export GRAVITEE_AM_CLIENT_SECRET=$(cat ./clientFullInfos.gravitee | jq .[].clientSecret| awk -F '"' '{print $2}')

export GRAVITEE_AM_CLIENT_UID=b23b5d79-18e2-405f-bb5d-7918e2f05f21
export GRAVITEE_AM_CLIENT_UID=$(cat ./clientFullInfos.gravitee | jq .[].id| awk -F '"' '{print $2}')

echo " GRAVITEE_AM_CLIENT_ID=[${GRAVITEE_AM_CLIENT_ID}]"
echo " GRAVITEE_AM_CLIENT_UID=[${GRAVITEE_AM_CLIENT_UID}]"
echo " GRAVITEE_CLIENT_SECRET=[${GRAVITEE_CLIENT_SECRET}]"

curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X DELETE "https://${GRAVITEE_AM_API_HOST}:443/management/domains/${GRAVITEE_SEC_DOMAIN}/clients/${GRAVITEE_AM_CLIENT_UID}" | tail -n 1 | jq .

# --- renouveler le clientSecret
export URLAMOI="https://${GRAVITEE_AM_API_HOST}:443/management/domains/${GRAVITEE_SEC_DOMAIN}/clients/${GRAVITEE_AM_CLIENT_UID}/secret/_renew"

curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json'  -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X POST "${URLAMOI}" | tail -n 1 | jq . | tee ./clientFullInfos.renewed.clientSecret.gravitee

# Lister les clients Gravitee

curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET "https://${GRAVITEE_AM_API_HOST}:443/management/domains/${GRAVITEE_SEC_DOMAIN}/clients" | tail -n 1 | jq .

export GRAVITEE_AM_CLIENT_SECRET=$(cat ./clientFullInfos.renewed.clientSecret.gravitee | jq .clientSecret | awk -F '"' '{print $2}')
echo "After renewing Client Secret for [${GRAVITEE_AM_CLIENT_UID}] Gravitee Client, in security domain [${GRAVITEE_SEC_DOMAIN}] client full infos are : "
cat ./clientFullInfos.renewed.clientSecret.gravitee | jq .
echo " renewed GRAVITEE_AM_CLIENT_SECRET=[${GRAVITEE_AM_CLIENT_SECRET}]"
echo "Previously, ClientSecret for [${GRAVITEE_AM_CLIENT_UID}] Gravitee Client, in security domain [${GRAVITEE_SEC_DOMAIN}] was : "
cat ./clientFullInfos.renewed.clientSecret.gravitee | jq .

# ---
# Seul le secret a été renouvelé ...
# export GRAVITEE_AM_CLIENT_ID=$(cat ./clientFullInfos.renewed.clientSecret.gravitee | jq .[].clientId| awk -F '"' '{print $2}')
export GRAVITEE_AM_CLIENT_SECRET=$(cat ./clientFullInfos.renewed.clientSecret.gravitee | jq .clientSecret| awk -F '"' '{print $2}')



#
# https://am.gravitee.io:443/management/domains/voyonsdomaine/clients/86e156ad-042d-4d52-a156-ad042dbd52a1/secret/_renew
# ---
# ----  https://docs.gravitee.io/am/2.x/am_quickstart_secure_apis.html : voilà comment crééer le Oauth2 lient derrière
# ---
# https://graviteeio-am-gateway-host/:securityDomainPath/oauth/token
# curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json'  -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET "${URLAMOI}" | tail -n 1 | jq .
# ---
# --- CONFIGURING an [Oauth2 client] over the 'Gravitee Client'
# ---
# The API Endpoint for xwhich Oauth2 will act is  :  https://am.gravitee.io:443/un-endpoint-api-imaginaire
# https://docs.gravitee.io/am/2.x/management-api/index.html#operation/update

# ---
#
# [GRAVITEE AM API Endpoint] : https://docs.gravitee.io/am/2.x/management-api/index.html#operation/update
# ---


export GRAVITEE_AM_CLIENT_UID=86e156ad-042d-4d52-a156-ad042dbd52a1
export GRAVITEE_AM_CLIENT_UID=$(cat ./clientFullInfos.gravitee | jq .[].id| awk -F '"' '{print $2}')
export CURRENT_GRAVITEE_AM_CLIENT_ID=$(curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET "https://${GRAVITEE_AM_API_HOST}:443/management/domains/${GRAVITEE_SEC_DOMAIN}/clients" | tail -n 1 | jq . | jq --arg CLIENT_UID "${GRAVITEE_AM_CLIENT_UID}" '.[]|select(.id==$CLIENT_UID)'|jq '.clientId'|awk -F '"' '{print $2}')
export URL_APPEL_GRAVITEE_AM_API="https://${GRAVITEE_AM_API_HOST}:443/management/domains/${GRAVITEE_SEC_DOMAIN}/clients/${GRAVITEE_AM_CLIENT_UID}"

echo "GRAVITEE_AM_CLIENT_UID=${GRAVITEE_AM_CLIENT_UID}"
echo "CURRENT_GRAVITEE_AM_CLIENT_ID=${CURRENT_GRAVITEE_AM_CLIENT_ID}"
echo "URL_APPEL_GRAVITEE_AM_API=${URL_APPEL_GRAVITEE_AM_API}"

# --------------
# --- preparing payload
export OAUTH2_REDIRECT_URI=https://api.mycompany.io:443/b2c
export OAUTH2_REDIRECT_URI=https://saint-nectaire.mycompany.io:443/tls

export PAYLOAD_APPEL_API="{ \
  \"redirectUris\": [ \"https://saint-nectaire.mycompany.io:443/tls\", \"https://saint-nectaire.mycompany.io:8000/notls\" ], \
  \"authorizedGrantTypes\": [ \"authorization_code\", \"implicit\", \"client_credentials\" ], \
  \"responseTypes\": [ \"CODE\", \"TOKEN\" ] }"

echo "PAYLOAD_APPEL_API=${PAYLOAD_APPEL_API}"

curl  -ivk -H 'Accept: application/json' -H 'Content-Type: application/json' --data "${PAYLOAD_APPEL_API}" -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X PUT "${URL_APPEL_GRAVITEE_AM_API}" | tail -n 1 | jq .

# --- #
# we have to replay to force saving [authorizedGrantTypes] alone
export PAYLOAD_APPEL_API="{  \"authorizedGrantTypes\": [ \"authorization_code\", \"implicit\", \"client_credentials\" ] }"


echo "PAYLOAD_APPEL_API=${PAYLOAD_APPEL_API}"

curl  -ivk -H 'Accept: application/json' -H 'Content-Type: application/json' --data "${PAYLOAD_APPEL_API}" -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X PUT "${URL_APPEL_GRAVITEE_AM_API}" | tail -n 1 | jq .

# --- #
# we have to replay to force saving [scopes] alone
# ---
# Scopes :
# ---

export PAYLOAD_APPEL_API="{  \"enhanceScopesWithUserPermissions\": true, \"scopes\": [ \"dcr\", \"dcr_admin\", \"profile\", \"roles\", \"scim\", \"address\", \"openid\", \"openid\", \"phone\", \"offline_access\", \"email\", \"consent_admin\" ] }"



echo "PAYLOAD_APPEL_API=${PAYLOAD_APPEL_API}"

curl -ivk -H 'Accept: application/json' -H 'Content-Type: application/json' --data "${PAYLOAD_APPEL_API}" -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X PUT "${URL_APPEL_GRAVITEE_AM_API}" | tail -n 1 | jq .


# --- #
# we have to enable Default Identity Provider  ?
# to force saving [scopes] alone
# ---
# Scopes :
# ---


# --- #
# Configuration of the Default Identity Provider
#  {"enableCredentials":false} => {"enableCredentials":true}
#
export URL_APPEL_GRAVITEE_AM_API="https://${GRAVITEE_AM_API_HOST}:443/management/domains/${GRAVITEE_SEC_DOMAIN}/identities/default-idp-${GRAVITEE_SEC_DOMAIN}"
curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET "${URL_APPEL_GRAVITEE_AM_API}" | tail -n 1 | jq '.'

export GRAVITEE_AM_DOMAIN_ID_PROVIDER_CONFIG=$(curl -ivk  -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET "${URL_APPEL_GRAVITEE_AM_API}" | tail -n 1 | jq '.configuration')


# export NEW_ID_PROVIDER_CONFIGURATION=$(echo -n ${GRAVITEE_AM_DOMAIN_ID_PROVIDER_CONFIG} | sed  "s#false#true#g" | awk -F '"' '{for (i = 0; i <= NF ; i++) {if ( i == NF ) {printf $i } else {printf $i "\""}};}')
export NEW_ID_PROVIDER_CONFIGURATION=$(echo -n ${GRAVITEE_AM_DOMAIN_ID_PROVIDER_CONFIG} | sed  "s#false#true#g" -)
echo ""
echo "NEW_ID_PROVIDER_CONFIGURATION=[$NEW_ID_PROVIDER_CONFIGURATION]"
echo ""
# \"{\\"uri\\":\\"mongodb://gravitee-am-mongo-mongodb-replicaset-client.default.svc.cluster.local:27017/gravitee?&replicaSet=rs0&connectTimeoutMS=30000\\",\\"host\\":\\"localhost\\",\\"port\\":27017,\\"enableCredentials\\":true,\\"database\\":\\"gravitee-am\\",\\"usersCollection\\":\\"idp_users_voyonsdomaine\\",\\"findUserByUsernameQuery\\":\\"{username: ?}\\",\\"usernameField\\":\\"username\\",\\"passwordField\\":\\"password\\",\\"passwordEncoder\\":\\"BCrypt\\"}\"

export PAYLOAD_APPEL_API="{  \"configuration\": ${NEW_ID_PROVIDER_CONFIGURATION} }"

export MONGODB_HOST_IN_K8S_CLUSTER=gravitee-am-mongo-mongodb-replicaset-client.default.svc.cluster.local

export MONGODB_HOST_IN_K8S_CLUSTER=mongo
export MONGODB_PORT_IN_K8S_CLUSTER=27017
export MONGODB_REPLICASET_NAME=rs0
export GRAVITEE_AM_HELM_RELEASE_NAME=gravitee-am
# export PAYLOAD_APPEL_API="{  \"configuration\": \"{\\\"uri\\\":\\\"mongodb://${MONGODB_HOST_IN_K8S_CLUSTER}:${MONGODB_PORT_IN_K8S_CLUSTER}/gravitee?&replicaSet=${MONGODB_REPLICASET_NAME}&connectTimeoutMS=30000\\\",\\\"host\\\":\\\"localhost\\\",\\\"port\\\":${MONGODB_PORT_IN_K8S_CLUSTER},\\\"enableCredentials\\\":true,\\\"database\\\":\\\"${GRAVITEE_AM_HELM_RELEASE_NAME}\\\",\\\"usersCollection\\\":\\\"idp_users_voyonsdomaine\\\",\\\"findUserByUsernameQuery\\\":\\\"{username:?}\\\",\\\"usernameField\\\":\\\"username\\\",\\\"passwordField\\\":\\\"password\\\",\\\"passwordEncoder\\\": \\\"BCrypt\\\"} \" , \"name\": \"myDefaultIdentityProvider\"} "
export PAYLOAD_APPEL_API="{  \"configuration\": \"{\\\"uri\\\":\\\"mongodb://${MONGODB_HOST_IN_K8S_CLUSTER}:${MONGODB_PORT_IN_K8S_CLUSTER}/gravitee?&connectTimeoutMS=30000\\\",\\\"host\\\":\\\"localhost\\\",\\\"port\\\":${MONGODB_PORT_IN_K8S_CLUSTER},\\\"enableCredentials\\\":true,\\\"database\\\":\\\"${GRAVITEE_AM_HELM_RELEASE_NAME}\\\",\\\"usersCollection\\\":\\\"idp_users_voyonsdomaine\\\",\\\"findUserByUsernameQuery\\\":\\\"{username:?}\\\",\\\"usernameField\\\":\\\"username\\\",\\\"passwordField\\\":\\\"password\\\",\\\"passwordEncoder\\\": \\\"BCrypt\\\"} \" , \"name\": \"myDefaultIdentityProvider\"} "



# celle là marche
# [name] est obligatoire, et sa valeur est complètement libre : le nom sera mis à jour en conséquence de la valeur fournie.
# export PAYLOAD_APPEL_API="{  \"configuration\": \"{\\\"enableCredentials\\\":true}\", \"name\": \"jblIdentityProvider\"}"


curl -ivk -H 'Accept: application/json' -H 'Content-Type: application/json' --data "${PAYLOAD_APPEL_API}" -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X PUT "${URL_APPEL_GRAVITEE_AM_API}" | tail -n 1 | jq .
echo "PAYLOAD_APPEL_API=[${PAYLOAD_APPEL_API}]"





echo ""
echo "----------------------------------------------------------------------------------------------------"
echo "La Configuration OAuth2 est terminée, on peut maintenant demander un [ACCESS TOKEN] pour "
echo "accédéder à la [Rest API My Awesome API], en s'authentifiant avec cet [ACCESS TOKEN]"
echo "----------------------------------------------------------------------------------------------------"
echo "Cet [ACCESS TOKEN] sera associé au [Gravitee AM Client] de clientId [${CURRENT_GRAVITEE_AM_CLIENT_ID}] et d'Id [${GRAVITEE_AM_CLIENT_UID}] "
echo "----------------------------------------------------------------------------------------------------"
echo "Via [Gravitee APIM] : "
echo "  + On déclarera l'API My Awesome API, qui apparaîtra parmi les API gérées par [Gravitee APIM], dans sa [Web UI]"
echo "  + Puis on associera le [Gravitee AM Client] de clientId [${CURRENT_GRAVITEE_AM_CLIENT_ID}], à notre API"
echo ""
echo " SEULEMENT ALORS, l'ACESS TOKEN permttra de consommer l'API My Awesome API, gérée par [Gravitee APIM] "
echo "----------------------------------------------------------------------------------------------------"
echo " À ce stade, on sait donc créer des API Token, mais ceux ci ne sont reliés à aucune ressource derrière, pour l'instant."
echo ""
echo ""


# ---
# - Ici : UNE API au moins, doit avoir
# --- + au moins UNE API, doit avoir été déclarée avec Gravitee APIM
# --- + au moins UNE API, doit avoir été déclarée avec Gravitee APIM, avec une
# --- + configuration "Security Domain" impliquant le client Gravitee AM [${CURRENT_GRAVITEE_AM_CLIENT_ID}]
# --- +
#
#
# --- Finally creating an API ACCESS TOKEN from Gravitee AM
echo ""
echo " A ce Stade, avant de pouvoir obtenir de [Gravitee AM], un [ACCESS TOKEN], il faut : "
echo ""
echo "# ---  NECESSITE DE L'APIM POUR POUVOIR OBTENIR DES [ACCESS TOKEN] CONFIRMEE!!!!   "
echo ""
echo "# --- + qu'au moins UNE API, doit avoir été déclarée avec Gravitee APIM"
echo "# --- + qu'au moins UNE API, doit avoir été déclarée avec Gravitee APIM, avec une"
echo "# ---   configuration \"Security Domain\" impliquant le client Gravitee AM [${CURRENT_GRAVITEE_AM_CLIENT_ID}]"
echo "# --- "
echo ""
read -p "Pressez la touche entrée pour exécuter la commande [curl] qui vous obtiendra un [ACCESS_TOKEN]" ATTENTE_DECLAREZ_SOUS_APIM_UNE_API


export URL_APPEL_GRAVITEE_AM_API="https://${GRAVITEE_AM_API_HOST}:443/management/domains/${GRAVITEE_SEC_DOMAIN}/oauth/token?grant_type=client_credentials&scope=read&client_id=${GRAVITEE_AM_CLIENT_ID}&client_secret=${GRAVITEE_AM_CLIENT_SECRET}"
curl -ivk -H 'Accept: application/json' -H 'Content-Type: application/json' --data "${PAYLOAD_APPEL_API}" -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X POST "${URL_APPEL_GRAVITEE_AM_API}" | tail -n 1 | tee ./finally.GRAVITEE_ACCESS_TOKEN.token
curl -ivk -H 'Accept: application/json' -H 'Content-Type: application/json' --data "${PAYLOAD_APPEL_API}" -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}" -X GET "${URL_APPEL_GRAVITEE_AM_API}"

echo "# --- "
echo ""
echo " Voici votre [ACCESS TOKEN] : "
echo ""
echo "# --- "
echo ""
cat ./obtention.access_token.gravitee.am.token | jq .
echo ""
echo "# --- "

# https://docs.gravitee.io/am/2.x/am_userguide_create_client.html
# et https://docs.gravitee.io/am/2.x/am_quickstart_register_app.html
# et https://docs.gravitee.io/am/1.x/am_quickstart_register_app.html


####  autre essai access token
# https://docs.gravitee.io/am/2.x/am_userguide_dynamic_client_registration.html#register_new_client

curl  -H "Authorization: Bearer ${GRAVITEE_AM_API_TOKEN}"  -X POST -ivk "https://${GRAVITEE_AM_API_HOST}/${GRAVITEE_SEC_DOMAIN}/oauth/token?grant_type=client_credentials&scope=dcr_admin&client_id=${GRAVITEE_AM_CLIENT_ID}&client_secret=${GRAVITEE_AM_CLIENT_SECRET}"


```
* partie proxy dans APIM : aller configurer le Endpoint SSL "Trust all CA" pour le ceert. SSL / TLS de randomuser.me/api

# Annexe : Containers releases

https://github.com/gravitee-io/release/tree/master/upgrades/3.x/3.0.0#docker


# ANNEXE : Docuementation

#### APIM AM before 3

Using web Ui , I get an API KEY for my API, and I try but unauthorized  (Gravitee AM 2.10.9   and APIM 1.30.11 ) :

```bash
~/labops$ curl -ik -H "Authorization: Bearer 8b17e62b-fbfe-4508-a275-0f6f7815fa36" https://apim.gravitee.io/jblapi
HTTP/2 401
content-type: application/json
x-gravitee-transaction-id: 395191ed-cbd2-4e9f-9191-edcbd21e9ffa
content-length: 49
date: Wed, 03 Jun 2020 15:55:43 GMT

{"message":"Unauthorized","http_status_code":401}
```

* J'ssaiie d'exécuter https://docs.gravitee.io/apim/1.x/apim_quickstart_consume.html  after  https://docs.gravitee.io/apim/1.x/apim_quickstart_publish.html  mais pour l'instant je n'y arrive pas.
