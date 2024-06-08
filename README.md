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
- [Debugging on server](#debugging-on-server)
- [Maintainer(s)](#maintainers)
- [Contact](#contact)
- [Additional documentation](#additional-documentation)

</details>

<!-- ABOUT THE PROJECT -->
## About
MetaPloy is just a containerized [Nginx](https://nginx.org) reverse proxy that acts as the main webserver. It exposes a docker network named `metaploy-network` and a volume named `metaploy-nginx-config-volume`. The volume is mounted at `/etc/nginx/sites-enabled/`

Each projected hosted on the server should be containerized and connected to the `metaploy-network`. Each project has its own Nginx configuration file which should be copied to the `metaploy-nginx-config-volume` volume.

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
