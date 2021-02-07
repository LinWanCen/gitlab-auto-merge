#!/usr/bin/env bash
set -e

# https://docs.gitlab.com/ee/api/merge_requests.html#create-mr

echo "
  curl -X POST \"${GITLAB_API_URL}/${CI_PROJECT_ID}/merge_requests\"
    --header \"PRIVATE-TOKEN: ******\"
    --header \"Content-Type: application/json\"
    --data
      \"{
        \\\"id\\\": ${CI_PROJECT_ID},
        \\\"source_branch\\\": \\\"${CI_COMMIT_REF_NAME}\\\",
        \\\"target_branch\\\": \\\"${TARGET_BRANCH}\\\",
        \\\"title\\\": \\\"jenkins auto merge requests\\\",
        \\\"assignee_id\\\":\\\"${GITLAB_USER_ID}\\\"
      }\"
    --silent
"

createMR=`curl -X POST "${GITLAB_API_URL}/${CI_PROJECT_ID}/merge_requests" \
  --header "PRIVATE-TOKEN:${GITLAB_PRIVATE_TOKEN}" \
  --header "Content-Type: application/json" \
  --data "{
      \"id\": ${CI_PROJECT_ID},
      \"source_branch\": \"${CI_COMMIT_REF_NAME}\",
      \"target_branch\": \"${TARGET_BRANCH}\",
      \"title\": \"jenkins auto merge requests\",
      \"assignee_id\":\"${GITLAB_USER_ID}\"
    }" \
  --silent`

echo "$createMR
"

createMR_iid=$(echo $createMR | cut -d ':' -f 3 | cut -d ',' -f 1)

if [[ $createMR_iid != *[0-9] ]]; then
  exit 1
fi