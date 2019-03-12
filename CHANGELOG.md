# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased

## [1.5.1] - 2019-03-13
### Changed
- Migrate CircleCI build from v1.0 to v2.0 (#15)

### Package Updates
- civis 1.9.0 -> 1.9.4
- civisml-extensions 0.1.8 -> 0.1.10
- numpy 1.13.3 -> 1.14.3 (fixes an error with the tensorflow binary)


## [1.5.0] - 2018-04-26
### Added
- Added htop and tmux to Linux environment (#14)

### Package Updates
- civis 1.8.1 -> 1.9.0
- civisml-extensions 0.1.6 -> 0.1.8
- muffnn 2.0.0 -> 2.1.0

- awscli 1.11.75 (pip) -> 1.15.4 (conda)
- botocore 1.5.38 -> 1.10.4
- boto3 1.5.11 -> 1.7.4
- dask 0.15.4 (pip) -> 0.17.2 (conda)
- tensorflow 1.4.1 -> 1.7.0
- matplotlib 2.1.0 -> 2.2.2
- notebook 5.2.2 -> 5.4.1
- scipy 1.0.0 -> 1.0.1

## [1.4.0] - 2018-01-25
### New packages
- bqplot 0.10.2
- feather-format 0.4.0

### Package Updates
- civis 1.7.1 -> 1.8.0
- civisml-extensions 0.1.5 -> 0.1.6
- muffnn 1.2.0 -> 2.0.0
- cloudpickle 0.5.1 -> 0.5.2
- dask 0.15.4 -> 0.16.1
- ftputil 3.3.1 -> 3.4
- tensorflow 1.4.0 -> 1.4.1
- boto3 1.4.5 -> 1.5.11
- cython 0.26 -> 0.27.3
- openblas 0.2.19 -> 0.2.20
- pandas 0.21.0 -> 0.22.0
- pyarrow 0.7.1 -> 0.8.0
- scipy 0.19.1 -> 1.0.0
- ipywidgets 7.0.0 -> 7.1.0
- notebook 5.2.0 -> 5.2.2

### Fixed
- Enabled widgetsnbextension so that ipywidgets works.

## [1.3.2] - 2018-01-16

### Changed
- civis-jupyter-notebook v0.4.1 -> v0.4.2

## [1.3.1] - 2018-01-03

### Changed
- civis-jupyter-notebook v0.4.0 -> v0.4.1

## [1.3.0] - 2017-12-20

### Changed
- civis-jupyter-notebook v0.3.1 -> v0.4.0

### Added
- Installed nano, vim and emacs

## [1.2.0] - 2017-12-13

### Changed
- civis-jupyter-notebook v0.2.4 -> v0.3.0

## [1.1.1] - 2017-11-28

### Fixed
- Increase ``civis-jupyter-notebook`` version from v0.2.2 to v0.2.4 to get bugfix with relaxed dependency requirements (#4).

## [1.1.0] - 2017-11-27

### Changed
- Moved conda to version 4.3.30

### New packages
- civisml-extensions 0.1.5
- dask 0.15.4
- s3fs 0.1.2

### Package Updates
- civis 1.6.2 -> 1.7.1
- boto3 1.4.4 -> 1.4.5
- matplotlib 2.0.2 -> 2.1.0
- numpy 1.13.1 -> 1.13.3
- pandas 0.20.3 -> 0.21.0
- pyarrow 0.5.0 -> 0.7.1
- scikit-learn 0.19.0 -> 0.19.1
- cloudpickle 0.3.1 -> 0.5.1
- muffnn 1.1.2 -> 1.2.0
- pubnub 4.0.12 -> 4.0.13
- tensorflow 1.2.1 -> 1.4.0

## [1.0.1] - 2017-09-18

## Changed
- civis-jupyter-notebook v0.2.0 -> v0.2.2 (#2)
- Use a full version number for civis-jupyter-notebook (#2).

## [1.0.0] - 2017-09-13

- Initial commit
