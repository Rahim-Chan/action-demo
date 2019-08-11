workflow "npm publish" {
  resolves = ["GitHub Action for npm"]
  on = "push"
}

action "Build" {
  uses = "actions/npm@master"
  args = "install"
}

action "GitHub Action for npm" {
  needs = ["Master", "Develop"]
  uses = "actions/npm@master"
  args = "publish --access public"
  secrets = ["NPM_AUTH_TOKEN"]
}

# Filter for master branch
action "Master" {
  needs = "Build"
  uses = "actions/bin/filter@master"
  args = "branch master"
}

# Filter for dev branch
action "Develop" {
  needs = "Build"
  uses = "actions/bin/filter@master"
  args = "branch develop"
}

action "npm dev tag" {
  needs = "Master"
  uses = "actions/npm@master"
  args = "publish --access public"
  secrets = ["NPM_AUTH_TOKEN"]
}
