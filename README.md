# elasticsearch

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with elasticsearch](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with elasticsearch](#beginning-with-elasticsearch)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This is a very simple module that was built to solve a specific customer problem!
A good percentage of the code was adapted from the approved puppet [elasticsearch
module.](https://github.com/elastic/puppet-elasticsearch/)  As requirements
change I will add to the functionality.

The reason this module was created is because the approved [elasticsearch
module](https://github.com/elastic/puppet-elasticsearch/) installed elasticsearch
on the machine directly.  I needed some of the functionality, but not all.
My understanding of the approved elasticsearch module is that when you use it,
it installs elasticsearch.

What this module does is sort of "un puppet-like", but it is written in a way
where it is idempotent.

## Setup

### Setup Requirements **OPTIONAL**

There is not setup required to use this module, simply add the following to your Puppetfile

```
mod 'scottpecnik/elasticsearch',
  :git => 'git@bitbucket.org:panviva/elasticsearch.git'
```

### Beginning with elasticsearch

```
file { 'C:/temp/template_1.json':
  ensure  => present,
  content => 'puppet:///modules/elasticsearch/template_1.json',
}

elasticsearch_template { 'template_1':
  ensure     => present,
  servername => 'localhost',
  port       => '9201',
  ssl        => false,
  content    => 'C:/temp/template_1.json',
  require    => File['C:/temp/template_1.json']
}
```

## Usage

For the elasticsearch_template there are five parameters.  These parameters
build a REST URI.  The name of the resource is used as the resource identifier.

## Reference

This module is written primarily in pure Ruby because of it's requirement of
making HTTP REST calls.

## Limitations

Only it's limited functionality!

## Development

Feel free to fork, open issues, whatever you like.
