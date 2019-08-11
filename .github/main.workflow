# workflow
workflow "Push" {
  on = "push"
  resolves = ["auto release"]
}

# actions
action "npm install" {
  uses = "docker://node"
  args = "npm install -g npminstall && npminstall"
}

# target
action "auto release" {
  uses = "docker://node"
  needs = ["filter master"]
  args = "npm run semantic-release"
  secrets = [
    "GITHUB_TOKEN",
    "NPM_AUTH_TOKEN",
  ]
}

# filter
action "filter master" {
  uses = "actions/bin/filter@master"
  secrets = ["GITHUB_TOKEN"]
  args = "branch master"
}
