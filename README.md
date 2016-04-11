# homebrew-neomutt [![Build Status](https://travis-ci.org/neomutt/homebrew-neomutt.svg?branch=master)](https://travis-ci.org/neomutt/homebrew-neomutt)

[Homebrew][brew] formula for [NeoMutt][neomutt].

## Usage

To install the [latest release][neomutt-releases]:

```shell
$ brew install neomutt/homebrew-neomutt/neomutt
```

To upgrade a previously-installed version:

```shell
$ brew update
$ brew upgrade neomutt
```

If want to install a developer version of NeoMutt, based on the 
latest GitHub revision, use:

```shell
$ brew tap neomutt/homebrew-neomutt
$ brew install --HEAD neomutt
```

To upgrade the developer version:

```shell
$ brew update
$ brew reinstall --HEAD neomutt
```

## Filing an Issue

If you run into problems during the installation, make sure to follow the
[Troubleshooting](#troubleshooting) section below before filing an issue.  If
you still have problems:

* Please search the [issue tracker][neomutt-brew-issues] to see if your 
  problem has been discussed before.
* Please make sure to include the link to the result of your
  `brew gist-logs neomutt` command.
* It's also helpful to capture the output of a verbose version of the install
  command you used.  To do this, add the `-v` option to the command line and try
  again.  For example, `brew install neomutt/homebrew-neomutt/neomutt` would become `brew
  install -v neomutt/homebrew-neomutt/neomutt`.  Paste the result of this into your issue,
  and make sure to wrap it with a text fence so it renders correctly:

      ```text
      # output goes here
      ```

Problems with NeoMutt itself, found after the installation, should be reported 
to the [NeoMutt][neomutt-issues] issues page.

## Troubleshooting

Most Homebrew installs finish without a problem, but sometimes things can go wrong. You can 
try the following guides, in order, to see if one of them fixes the problem:

1. [Homebrew troubleshooting][brew-trouble];
2. [Checking for common Homebrew issues][brew-common]; and
3. [Re-tapping a Homebrew formula][brew-retap] (replace instances of `neovim` 
   with `neomutt`).

[brew]: http://brew.sh
[brew-common]: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Troubleshooting.md#check-for-common-issues
[brew-trouble]: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Troubleshooting.md
[brew-retap]: https://github.com/neovim/homebrew-neovim#troubleshooting
[neomutt]: http://www.neomutt.org
[neomutt-releases]: https://github.com/neomutt/neomutt/releases
[neomutt-issues]: https://github.com/neomutt/neomutt/issues
[neomutt-brew-issues]: https://github.com/neomutt/homebrew-neomutt/issues
