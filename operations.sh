#!/bin/bash

echo ""
echo "Hi [$(whoami)], be advised you must be an admin (allowed to run 'sudo'), to execute this [$0] script"
echo ""

./elastic-system-setup.sh

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


cat ./docker-compose.yml | grep -v ':/' |grep -A8 'elasticsearch:'
cat docker-compose.yml | grep -v ':/' |grep -C10 'ulimits:'
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
docker-compose -f docker-compose.gravitee3.yml up -d && sleep 7s && sudo chmod a+rw -R ./data
docker-compose -f docker-compose.gravitee3.yml logs -f

# --- work cycle
# docker-compose down --rmi all && docker system prune -f --all && docker system prune -f --volumes && docker-compose up -d && docker-compose logs -f
