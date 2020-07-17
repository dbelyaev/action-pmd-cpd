#!/bin/bash
set -e

if [ -n "${GITHUB_WORKSPACE}" ] ; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

#echo Printing something to log
#printenv
pmd -R pmd-ruleset.xml -d "${INPUT_WORKDIR}" -f xml \  
  | reviewdog -f=pmd \
      -name="pmd" \
      -reporter="${INPUT_REPORTER:-github-pr-check}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
      -level="${INPUT_LEVEL}" \
      ${INPUT_REVIEWDOG_FLAGS}

#exec java -jar /checkstyle.jar -c "${INPUT_CHECKSTYLE_CONFIG}" "${INPUT_WORKDIR}" -f xml \
#  | reviewdog -f=checkstyle \
#      -name="checkstyle" \
#      -reporter="${INPUT_REPORTER:-github-pr-check}" \
#      -filter-mode="${INPUT_FILTER_MODE}" \
#      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
#      -level="${INPUT_LEVEL}" \
#      ${INPUT_REVIEWDOG_FLAGS}