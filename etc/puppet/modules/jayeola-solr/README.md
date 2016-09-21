# jayeola-solr

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with solr](#setup)
    * [What solr affects](#what-solr-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with solr](#beginning-with-solr)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Install solr version x on Ubuntu 14 hosts.

## Module Description

This module installs Apache Solr version X on Ubuntu host. Pulls in java, tomcat6. Point browser to http://hostname:8080/solr after calling this module.


## Setup

### What solr affects

* Solr is installed in /opt/.

* Configs are in /blah/foo. Sensible defaults used.

* Listens on port 8080.

* This module includes the solr **tarball**. Big payload.


### Beginning with jayeola-solr

`puppet module install jayeola-solr` or `git clone git://yada`

## Usage

class|Component|Description
---|---
jayeola-solr|init|self contained puppet module.
jayeola-solr|config|sets up package.
jayeola-solr|install|installs package.
jayeola-solr|service|manage tomcat6 service.



Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

left blank intentionally.

## Limitations

- [x] Tested on Ubuntu 14.04

- [x] broken symlink - but "it works"!!


## Development

Contribute where necessary. Raise issues, fix bugs, contribute.

## Release Notes/Contributors/Etc
* Mr. Ron will fill this in later.

* Version bumping ...
