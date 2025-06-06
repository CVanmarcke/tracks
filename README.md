# Tracks: a GTD™ compatible web application built with Ruby on Rails

This is a fork of the [Tracks](https://github.com/TracksApp/tracks), customized to use SQLite and deployed with docker.
Installation is very easy: clone this repo, and start the container with `docker compose up -d`. The default port is 3000 but can be modified in `docker-compose.yml`.
The sqlite database is created in the `database` folder, but this mount location can also be changed in `docker-compose.yml`.

## About

* Project homepage: http://www.getontracks.org/
* Manual: http://www.getontracks.org/manual/
* Source at GitHub: https://github.com/TracksApp/tracks
* Hosted services: https://github.com/TracksApp/tracks/wiki/Hosted-Tracks
* Bug reports and feature requests: https://github.com/TracksApp/tracks/issues
* Mailing list: http://groups.google.com/group/TracksApp
* License: See COPYING

Full instructions for both new installations and upgrades from older installations
of Tracks can be found in the [wiki](https://github.com/TracksApp/tracks/wiki/Installation).

As always, make sure that you take sensible precautions and back up all your data frequently,
taking particular care when you are upgrading.

Enjoy being productive!

## Contributors and consulting

* Original developer: bsag (http://www.rousette.org.uk/)
* Principal maintainer: [Jyri-Petteri ”ZeiP” Paloposki](https://github.com/ZeiP)
  (sponsored by [Ardcoras oy](https://www.ardcoras.fi/), also available for paid consulting)
  * If you want to support the maintainer's work, subscribe to the
    [hosted version](https://www.taskitin.fi/).
* Contributors: https://github.com/TracksApp/tracks/wiki/Contributors

If you are thinking about contributing towards the development of Tracks,
please read /CONTRIBUTING.md for general information. Also you can find
some information on development, testing and contributing on the wiki.
