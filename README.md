<div id="top"></div>

<!-- PROJECT SHIELDS -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links-->
<div align="center">

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![Wiki][wiki-shield]][wiki-url]

</div>

<!-- PROJECT LOGO -->
<br />
<!-- UPDATE -->
<div align="center">
  <a href="https://github.com/metakgp/metaploy">
    <img width="140" alt="image" src="https://user-images.githubusercontent.com/86282911/206632284-cb260f57-c612-4ab5-b92b-2172c341ab23.png">
  </a>

  <h3 align="center">MetaPloy</h3>

  <p align="center">
    <i>Taking over the world one deployment at a time.</i>
    <br />
    <a href="https://github.com/metakgp/metaploy/issues">Report Bug</a>
    ·
    <a href="https://github.com/metakgp/metaploy/issues">Request Feature</a>
  </p>
</div>


<!-- TABLE OF CONTENTS -->
<details>
<summary>Table of Contents</summary>

- [About](#about-the-project)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
- [Debugging on server](#debugging-on-server)
- [Maintainer(s)](#maintainers)
- [Contact](#contact)
- [Additional documentation](#additional-documentation)

</details>

<!-- ABOUT THE PROJECT -->
## About
MetaPloy is just a containerized [nginx](https://nginx.org) reverse proxy that acts as the main web server (ingress server) for all metakgp projects. It exposes a Docker network named `metaploy-network` and a volume named `metaploy-nginx-config-volume`. The volume is mounted at `/etc/nginx/sites-enabled/` and reads `.metaploy.conf` files that contain the nginx configurations for each of the individual projects.

Each project hosted on the server is containerized and connected to the `metaploy-network`, and its nginx configuration file is copied to the `metaploy-nginx-config-volume` volume. MetaPloy watches for changes in the volume and reloads the configuration if any changes are made (e.g., a new project is loaded or unloaded).

These config files are included inside the top-level [http directive](http://nginx.org/en/docs/http/ngx_http_core_module.html#http) and should contain only the [server directives](http://nginx.org/en/docs/http/ngx_http_core_module.html#server). See the [usage](#usage) section for examples.

<p align="right">(<a href="#top">back to top</a>)</p>

## Getting Started
### Prerequisites
Docker and docker compose are the only required dependencies. You can either install [Docker Desktop](https://docs.docker.com/get-docker/) or the [Docker Engine](https://docs.docker.com/engine/install/). For minimal installations and server use cases, Docker Engine is recommended.

<p align="right">(<a href="#top">back to top</a>)</p>

### Installation
1. Clone this repository.
2. Copy the contents of the `.env.template` file into the `.env` file. Create the file if it doesn't exist.
3. Set the `SERVER_PORT` variable to the desired port. This is the port at which the server will be accessible on the system.
4. Run `docker compose up` to start MetaPloy.

<p align="right">(<a href="#top">back to top</a>)</p>

### Usage
MetaPloy uses docker [networks](https://docs.docker.com/engine/network/) and [volumes](https://docs.docker.com/engine/storage/volumes/) for its core functionality. See [docker-compose.yml](./docker-compose.yml) for the definitions. There are two main networks and one volume:
- The `metaploy-network` which is used for connecting projects to the ingress server. Anything on this network can be exposed to the external world via the ingress server.
- The `nginx-config-volume` which contains the nginx [configuration files](https://nginx.org/en/docs/beginners_guide.html#conf_structure) for each project and is mounted at `/etc/nginx/sites-enabled`.
- The `metaploy-private-network` which is not exposed to the ingress server. It is used for internal communication between different projects connected to metaploy. Eg: For a database to be accessed by multiple projects.

MetaPloy listens to changes in the config directory using [watch_reload.sh](./nginx/watch_reload.sh). If any file is changed, a new one is added, or removed (such as during the starting or stopping of a project), the nginx configuration is reloaded using `nginx -s reload`. All configuration files inside the configuration directory are directly included under the `http` directive of the ingress server. See the last lines of [nginx.conf](./nginx/nginx.conf).

To connect a project to a running MetaPloy instance, the following is required:
1. Add the metaploy networks and volumes in the project's docker compose file (or connect to the network in any other way).
2. Create a `[project].metaploy.conf` file that adds directives to connect to the server and sets the [server directives](http://nginx.org/en/docs/http/ngx_http_core_module.html#server) including the `server_name` to set the domain. See [example](./example/metaploy/project.metaploy.conf).
3. Copy the config file to the config volume when the project starts. This can be done by running a postinstall [script](./example/metaploy/postinstall.sh) as the entrypoint of the container.

See the [example](./example/). Also see existing projects using metaploy:
1. [IQPS Backend](https://github.com/metakgp/iqps-go/tree/main/backend) - Uses the standard template described here. Also uses the private network to connect to a database and file server.
2. [Metakgp Wiki](https://github.com/metakgp/metakgp-wiki/tree/master/nginx) - A non-standard legacy example with an nginx proxy of its own that uses [fastcgi](https://en.wikipedia.org/wiki/FastCGI).
3. [Odin's Vault](https://github.com/metakgp/odins-vault): A static file server that exposes a volume internally and a file server externally.
4. [Database of Babel](https://github.com/metakgp/dob): A Postgres database that only uses the private network and does not expose anything outside.

## Debugging on server

Sometimes we have to debug things out in production environment. To make this process streamlined there is an auto reload script running as a background service which checks for any changes made to nginx configurations (`/etc/nginx/nginx.conf` and `/etc/nginx/sites-enabled/*`) and reloads nginx automatically. Check out the script [here](./nginx/watch_reload.sh). In case you need to debug the script itself you can check-out the logs in the docker container located at `/nginx_auto_reload_service.log`.

## Maintainer(s)
- [Harsh Khandeparkar](https://github.com/harshkhandeparkar)
- [Arpit Bhardwaj](https://github.com/proffapt)

<p align="right">(<a href="#top">back to top</a>)</p>

## Contact
<p>
📫 Metakgp -
<a href="https://bit.ly/metakgp-slack">
  <img align="center" alt="Metakgp's slack invite" width="22px" src="https://raw.githubusercontent.com/edent/SuperTinyIcons/master/images/svg/slack.svg" />
</a>
<a href="mailto:metakgp@gmail.com">
  <img align="center" alt="Metakgp's email " width="22px" src="https://raw.githubusercontent.com/edent/SuperTinyIcons/master/images/svg/gmail.svg" />
</a>
<a href="https://www.facebook.com/metakgp">
  <img align="center" alt="metakgp's Facebook" width="22px" src="https://raw.githubusercontent.com/edent/SuperTinyIcons/master/images/svg/facebook.svg" />
</a>
<a href="https://www.linkedin.com/company/metakgp-org/">
  <img align="center" alt="metakgp's LinkedIn" width="22px" src="https://raw.githubusercontent.com/edent/SuperTinyIcons/master/images/svg/linkedin.svg" />
</a>
<a href="https://twitter.com/metakgp">
  <img align="center" alt="metakgp's Twitter " width="22px" src="https://raw.githubusercontent.com/edent/SuperTinyIcons/master/images/svg/twitter.svg" />
</a>
<a href="https://www.instagram.com/metakgp_/">
  <img align="center" alt="metakgp's Instagram" width="22px" src="https://raw.githubusercontent.com/edent/SuperTinyIcons/master/images/svg/instagram.svg" />
</a>
</p>

<p align="right">(<a href="#top">back to top</a>)</p>

## Additional documentation
  - [License](/LICENSE)
  - [Code of Conduct](/.github/CODE_OF_CONDUCT.md)
  - [Security Policy](/.github/SECURITY.md)
  - [Contribution Guidelines](/.github/CONTRIBUTING.md)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->

[contributors-shield]: https://img.shields.io/github/contributors/metakgp/metaploy.svg?style=for-the-badge
[contributors-url]: https://github.com/metakgp/metaploy/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/metakgp/metaploy.svg?style=for-the-badge
[forks-url]: https://github.com/metakgp/metaploy/network/members
[stars-shield]: https://img.shields.io/github/stars/metakgp/metaploy.svg?style=for-the-badge
[stars-url]: https://github.com/metakgp/metaploy/stargazers
[issues-shield]: https://img.shields.io/github/issues/metakgp/metaploy.svg?style=for-the-badge
[issues-url]: https://github.com/metakgp/metaploy/issues
[license-shield]: https://img.shields.io/github/license/metakgp/metaploy.svg?style=for-the-badge
[license-url]: https://github.com/metakgp/metaploy/blob/master/LICENSE
[wiki-shield]: https://custom-icon-badges.demolab.com/badge/metakgp_wiki-grey?logo=metakgp_logo&logoColor=white&style=for-the-badge
[wiki-url]: https://wiki.metakgp.org
