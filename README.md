# tbm_interruption_tracker
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
