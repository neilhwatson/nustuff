# Title

Write stuff for your team here about what this stuff does, why, and how to use it.

See https://docs.chef.io/inspec/profiles/ for details of how all this works

    inspect check .  # To check your code and profile
    inspect exec .  -t aws://  # To run your tests
    inspect exec .  -t aws:// --reporter yaml  # give more verbose output

    inspect vendor . # To get dependencies (not required)
