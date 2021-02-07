#!/usr/bin/env bash
set -e

# https://docs.gitlab.com/ee/api/merge_requests.html#list-project-merge-requests

echo "
curl \"${GITLAB_API_URL}/${CI_PROJECT_ID}/merge_requests?state=opened&source_branch=${CI_COMMIT_REF_NAME}\"
  --header \"PRIVATE-TOKEN:${GITLAB_PRIVATE_TOKEN}\"
  --silent 
"

listMR=`curl "${GITLAB_API_URL}/${CI_PROJECT_ID}/merge_requests?state=opened&source_branch=${CI_COMMIT_REF_NAME}" \
  --header "PRIVATE-TOKEN:${GITLAB_PRIVATE_TOKEN}" \
  --silent`

echo "$listMR
"

listMR_iid=$(echo $listMR | cut -d ':' -f 3 | cut -d ',' -f 1)

if [[ $listMR_iid != *[0-9] ]]; then
  exit 1
fi


# https://docs.gitlab.com/ee/api/merge_requests.html#accept-mr

echo "
curl -X PUT \"${GITLAB_API_URL}/${CI_PROJECT_ID}/merge_requests/$listMR_iid/merge\"
    --header \"PRIVATE-TOKEN: ******\"
    --silent
"

acceptMR=`curl -X PUT "${GITLAB_API_URL}/${CI_PROJECT_ID}/merge_requests/$listMR_iid/merge" \
  --header "PRIVATE-TOKEN: ${GITLAB_PRIVATE_TOKEN}" \
  --silent`

echo "$acceptMR
"

acceptMR_iid=$(echo $acceptMR | cut -d ':' -f 3 | cut -d ',' -f 1)

if [[ $acceptMR_iid != *[0-9] ]]; then
  exit 1
fi