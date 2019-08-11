# workflow
workflow "Push" {
  on = "push"
  resolves = ["auto release"]
}

# actions
action "npm install" {
  uses = "docker://thonatos/github-actions-nodejs"
  args = "npm install -g npminstall && npminstall"
}

# target
action "auto release" {
  uses = "docker://thonatos/github-actions-nodejs"
  needs = ["filter master"]
  args = "npm run semantic-release"
  secrets = ["GITHUB_TOKEN", "NPM_TOKEN"]
}

# filter
action "filter master" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  secrets = ["GITHUB_TOKEN"]
  args = "branch master"
}
