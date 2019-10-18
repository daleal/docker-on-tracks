# Docker on Tracks

A container solution with `apache2` and `php7.3` that just works with [PHP on Tracks](https://github.com/daleal/php-on-tracks). The app must be inside a folder named `app` placed in the same directory than the `Dockerfile`.

## Usage

To use the container solution, just `build` and `up`!

```bash
git clone https://github.com/daleal/docker-on-tracks.git
cd docker-on-tracks

mkdir app  # Fill the directory with your app

docker-compose build
docker-compose up
```
