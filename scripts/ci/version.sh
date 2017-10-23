#!/usr/bin/env bash

# Update the version strings in the source code

# Input:
#   $1 - the version string, if omitted, use ${BUILD_BUILDID}

version=$1

if [ -z ${version} ]; then
    version=${BUILD_BUILDID}
fi

if [ -z ${version} ]; then
    echo 'Missing version string'
    exit 1
fi

echo "Add dev version suffix: $version"

platform=`uname`

echo "Platform: $platform"

for each in $(find . -name setup.py); do
    if [ "$platform" == "Darwin" ]; then
        sed -i "" "s/^VERSION = [\"']\(.*\)[\"']/VERSION = \"\1.dev$version\"/" ${each}
    else
        sed -i "s/^VERSION = [\"']\(.*\)[\"']/VERSION = \"\1.dev$version\"/" ${each}
    fi
done

for each in $(find . -name version.py); do
    if [ "$platform" == "Darwin" ]; then
        sed -i "" "s/^VERSION = [\"']\(.*\)[\"']/VERSION = \"\1.dev$version\"/" ${each}
    else
        sed -i "s/^VERSION = [\"']\(.*\)[\"']/VERSION = \"\1.dev$version\"/" ${each}
    fi
done
