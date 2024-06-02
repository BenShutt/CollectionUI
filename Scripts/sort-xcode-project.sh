#!/usr/bin/env bash

#
# Script: sort-xcode-project.sh
# Usage: ./sort-xcode-project.sh
#
# Sorts the ".pbxproj" project file in the ".xcodeproj" 
# directory alphabetically.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Get directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Path to ".pbxproj" project file in the ".xcodeproj" directory
PROJECT_FILE="${SCRIPT_DIR}/../CollectionUI.xcodeproj/project.pbxproj"

# Perl script to sort the file alphabetically
PERL_SCRIPT="${SCRIPT_DIR}/alphabetically-sort-xcode-project.pl"

# Run the script
perl "${PERL_SCRIPT}" "${PROJECT_FILE}"