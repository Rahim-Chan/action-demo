action "Build" {
  uses = "actions/npm@master"
  args = "install"
}

# Filter for master branch
workflow "npm publish master" {
  resolves = ["GitHub Action for npm under master branch"]
  on = "push"
}

action "GitHub Action for npm under master branch" {
  needs = ["Master"]
  uses = "actions/npm@master"
  args = "publish --access public"
  secrets = ["NPM_AUTH_TOKEN"]
}

action "Master" {
  needs = "Build"
  uses = "actions/bin/filter@master"
  args = "branch master"
}

# Filter for dev branch
workflow "npm publish develop" {
  resolves = ["GitHub Action for npm under develop branch"]
  on = "push"
}

action "GitHub Action for npm under develop branch" {
  needs = ["Develop"]
  uses = "actions/npm@master"
  args = "publish --access public"
  secrets = ["NPM_AUTH_TOKEN"]
}

action "Develop" {
  needs = "Build"
  uses = "actions/bin/filter@master"
  args = "branch develop"
}
