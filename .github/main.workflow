workflow "build test" {
  on = "push"
  resolves = [
    "ls dist",
    "gulp install",
    "install dependencies",
  ]
}

action "preinstall" {
  uses = "docker://node:8"
  runs = "sh"
  args = "preinstall.sh"
}

action "install dependencies" {
  uses = "docker://node:8"
  needs = ["preinstall"]
  runs = "npm"
  args = "install"
}

action "gulp install" {
  uses = "docker://node:8"
  needs = ["install dependencies"]
  runs = "npx"
  args = "gulp install"
}

action "gulp build" {
  uses = "docker://node:8"
  needs = ["gulp install"]
  runs = "npx"
  args = "gulp build"
}

action "ls dist" {
  uses = "docker://node:8"
  needs = ["gulp build"]
  runs = "ls"
  args = "-la dist/"
}
