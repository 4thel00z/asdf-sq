<div align="center">

# asdf-sq ![Build](https://github.com/4thel00z/asdf-sq/workflows/Build/badge.svg) ![Lint](https://github.com/4thel00z/asdf-sq/workflows/Lint/badge.svg)

[sq](https://sq.io/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Issues](#issues)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add sq
# or
asdf plugin add sq https://github.com/4thel00z/asdf-sq.git
```

sq:

```shell
# Show all installable versions
asdf list-all sq

# Install specific version
asdf install sq latest

# Set a version globally (on your ~/.tool-versions file)
asdf global sq latest

# Now sq commands are available
sq --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to install & manage versions.

# Issues

Issues related to sq should be reported at its [Github repository](https://github.com/neilotoole/sq/issues). Issues
related with the installation of q using asdf should be reported [here](https://github.com/4thel00z/asdf-sq/issues).

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/4thel00z/asdf-sq/graphs/contributors)!

# License

See [COPYING](COPYING) © [ransomware](https://github.com/4thel00z/)
