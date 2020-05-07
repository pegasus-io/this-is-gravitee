#!/bin/bash

echo ""
echo "Hi [$(whoami)], be advised you must be an admin (allowed to run 'sudo'), to execute this [$0] script"
echo ""

theMidnightSpecial () {
# Je suis l'opérateur
export QUISUISJE=$(whoami)
sudo sysctl -w vm.max_map_count=262144

sudo ulimit -n 65535

# ulimit -n 65535
# sudo sh -c "ulimit -n 65535 && exec su ${QUISUISJE} && exit 0;"
# donnée par david brassely "pour tout lancr d'un coup

# --- # --- #
# Cette commande m'a permis de générer le docker-compose original
# curl -L http://bit.ly/graviteeio-platform | bash -s -- --am_version=2.10.11 --apim_version=1.30.8 | tee start.log
}


regenerateTheWholeStackOnFiles () {

echo "Download required files ..."


mkdir -p traefik/certs ; mkdir -p traefik/config ; mkdir -p mongo/docker-entrypoint-initdb.d ; mkdir -p gravitee

curl -Lf https://raw.githubusercontent.com/gravitee-io/gravitee-docker/master/platform/docker-compose.yml -o "docker-compose.yml"

cd mongo/docker-entrypoint-initdb.d && { curl -Lf https://raw.githubusercontent.com/gravitee-io/gravitee-docker/master/platform/mongo/docker-entrypoint-initdb.d/create-index.js -o "create-index.js" ; cd -; }
cd traefik/certs && { curl -Lf https://raw.githubusercontent.com/gravitee-io/gravitee-docker/master/platform/traefik/certs/gio-selfsigned.crt -o "gio-selfsigned.crt" ; cd -; }

cd traefik/certs && { curl -Lf https://raw.githubusercontent.com/gravitee-io/gravitee-docker/master/platform/traefik/certs/gio-selfsigned.key -o "gio-selfsigned.key" ; cd -; }

cd traefik/config && { curl -Lf https://raw.githubusercontent.com/gravitee-io/gravitee-docker/master/platform/traefik/config/traefik.toml -o "traefik.toml" ; cd -; }

cd gravitee && { curl -Lf https://raw.githubusercontent.com/gravitee-io/gravitee-docker/master/platform/gravitee/cacerts -o "cacerts" ; cd -; }

}

theMidnightSpecial

# regenerateTheWholeStackOnFiles
# chown -R $(whoami):$(whoami) $(pwd)
export QUISUISJE=$(whoami)
sudo chown -R ${QUISUISJE}:${QUISUISJE} $(pwd)


# ++ Ajout de la configuration UID GID explicitement hérié
#    de l'utilsiateur linux non-root exécutant docker sur l'hôte de
#    conteneurisation
# ++ Adding configuration that make the UID and GID  of
#      the user inside Elastic Container, inherit from UID and GID
#      of the linux non-root user executing docker on host

echo 'OPERATOR_UID=OPERATOR_UID_JINJA2_VAR' > ./.env.template
echo 'OPERATOR_GID=OPERATOR_GID_JINJA2_VAR' >> ./.env.template

if [ -f ./.env ]; then
  echo "An existing $(pwd)/.env was found and saved to $(pwd)/.env.previous "
  echo "Beware : next time you run this script, $(pwd)/.env.previous will be deleted. "
  if [ -f ./.env.previous ]; then
    rm ./.env.previous
  fi;
  cp ./.env ./.env.previous
  rm ./.env
fi;

cp ./.env.template ./.env

sed -i "s#OPERATOR_UID_JINJA2_VAR#$(id -u)#g" ./.env
sed -i "s#OPERATOR_GID_JINJA2_VAR#$(id -g)#g" ./.env


echo "also have to add a line in docker-compose.yml to elasticsearch service def. : "
cat ./docker-compose.yml | grep -v ':/' |grep -A8 'elasticsearch:'


cat docker-compose.yml | grep -v ':/' |grep -C10 'ulimits:'
# inserting line just before "ulimits:"
sed -i '/ulimits:/i\ \ \ \ user: "${OPERATOR_UID}:${OPERATOR_GID}"' ./docker-compose.yml

echo

echo "The Launch Gravitee.io API Platform  Pulumi recipe is now generated..."

# + gitops



docker-compose pull
# ---
# I make the process sleep for a few seconds, while in
# the background, gravitee stack is booting up until
# elasticsearch bumps on fs permissions issue
# then I do reset permissions on host
# and I don't even have to restart anything, elastic stack
# boots up immediately
# ---
docker-compose up -d && sleep 7s && sudo chmod a+rw -R ./data
docker-composer logs -f

# --- work cycle
# docker-compose down --rmi all && docker system prune -f --all && docker system prune -f --volumes && docker-compose up -d && docker-compose logs -f

