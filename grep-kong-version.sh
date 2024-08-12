#!/usr/bin/env bash

# unofficial strict mode
set -euo pipefail

KONG_SOURCE_LOCATION=${KONG_SOURCE_LOCATION:-kong/}

kong_version=`echo $KONG_SOURCE_LOCATION/kong-*.rockspec | sed 's,.*/,,' | cut -d- -f2`

echo "$kong_version"
