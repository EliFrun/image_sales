#!/bin/bash
rails new ./ \
    --skip-sprockets \
    --skip-javascript \
    --skip-turbolinks \
    --skip-test \
    --skip-action-mailer \
    --skip-yarn \
    --no-rc \
    --skip-system-test \
    --skip-coffee \
    --skip-listen \
    --skip-spring \
    --skip-sprockets \
    --skip-action-cable \
    --api

# ultra barebones starter project
# only need rest-api functionality