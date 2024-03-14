#!/bin/sh

if echo "${WP_ADMIN_USR}" | tr '[:upper:]' '[:lower:]' | grep -q 'admin'; then
   echo "--- PASSWORD SHOULD NOT CONTAIN ADMIN ---"
   echo "--- ADMIN ACCOUNT SET TO 'LORD_BOZO' ----"
   export WP_ADMIN_USR="LORD_BOZO"
fi
