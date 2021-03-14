#!/bin/bash

main() {
    # These files here are the only ones that need to be executed to prepare the
    # database. They create views in the db
    for file in PRIVATE/{3-h 3-j 3-l}.sql; do
        echo Executing $file ...
        ./do sql "$file"
    done
}

[[ ${BASH_SOURCE[0]} == $0 ]] && main $@
