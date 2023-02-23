# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test sq https://github.com/4thel00z/asdf-sq.git "sq --help"
```

Tests are automatically run in GitHub Actions on push and PR.
