workflow "Push to Master" {
  on:
    push:
      branches:
        - master
  resolves ["Create Jira Issue"]
}

action "Jira Login" {
  uses = "atlassian/gajira-login@v1.0.0"
  secrets = ["JIRA_API_TOKEN", "JIRA_BASE_URL", "JIRA_USER_EMAIL"]
}

action "Create Jira Issue" {
  uses = "atlassian/gajira-create@v1.0.0"
  needs = ["Jira Login"]
  args = "--project=GA --issuetype=Task --summary=\"{{ event.issue.title }}\" --description=$'{{ event.issue.body }}\\n\\n_Created from GitHub Action_'"
}