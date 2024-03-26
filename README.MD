# Docker WireGuard and TinyHTTP Proxy
This Docker project sets up a combination of WireGuard VPN and a TinyHTTP Proxy server, allowing you to access and securely tunnel web traffic through a VPN connection.

## Prerequisites
Before you get started, make sure you have the following installed on your system:

Docker: Install Docker (https://docs.docker.com/get-docker/)

Docker Compose (usually bundled with Docker Desktop for Mac and Windows): Install Docker Compose (https://docs.docker.com/compose/install/)


## Getting Started

Clone this repository to your local machine:

```sh
git clone https://github.com/noamanahmed/wireguard-http-proxy.git
```

Navigate to the project directory:

```sh
cd wireguard-http-proxy
```

Provide atleast one wg0.conf 
```sh
cp /your/system/path/to/wg0.conf conf.d/wireguard/wg_confs
```

Build and start the Docker containers:
```sh
docker-compose up -d
```

You will be able to connect to HTTP Proxy using 127.0.0.1:8888. 

Usage
Your WireGuard VPN and TinyHTTP Proxy should now be up and running. You can configure your client device to connect to the WireGuard VPN using an HTTP Proxy running on 127.0.0.1:8888.

## Basic Authentication
To enable basic HTTP authentication for the proxy, uncomment `PROXY_BASIC_USERNAME` and `PROXY_BASIC_PASSWD`, and set their values accordingly.

## Customization
You can customize the WireGuard and TinyHTTP Proxy configurations to suit your specific needs by editing the wireguard/wg0.conf and tinyproxy/tinyproxy.conf files respectively.

## Troubleshooting
If you encounter any issues or have questions, please check the Issues section of this repository to see if your problem has already been addressed. If not, feel free to open a new issue.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
