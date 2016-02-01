#!/bin/sh
#######################################

install_marvel_agent() {
  log "Installing Marvel Agent and Trial License."
  /usr/share/elasticsearch/bin/plugin install license
  /usr/share/elasticsearch/bin/plugin install marvel-agent
}

# Marvel support check
if [[ ${MARVEL_SUPPORT} == "true" || ${MARVEL_SUPPORT} == "yes" ]]; then
  install_marvel_agent
fi
