# tbm_interruption_tracker

[![Depfu](https://badges.depfu.com/badges/05b4447db14decadef97c09f48d5bf8d/overview.svg)](https://depfu.com/github/sylvainmetayer/tbm_interruption_tracker) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) ![GitHub release](https://img.shields.io/github/release/sylvainmetayer/tbm_interruption_tracker.svg)

Twitter Bot that track service interruption of TBM Tramway.

## Installation

```bash
$ bundler install
$ cp .env.sample .env
$ vim .env # Fill data or set environnments variable

```

## Usage

```
./twitterBot.rb [twitter_account] [pattern]
```

Example : `./twitterBot.rb TBM_TramB "interrompu"`

## Cron example 

```
0 18 * * * /home/user/tbm_interruption_tracker/twitterBot.rb TBM_TramB "interrompu" 
```
