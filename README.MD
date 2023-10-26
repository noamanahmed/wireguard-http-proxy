#Docker WireGuard and TinyHTTP Proxy
This Docker project sets up a combination of WireGuard VPN and a TinyHTTP Proxy server, allowing you to access and securely tunnel web traffic through a VPN connection.

##Prerequisites
Before you get started, make sure you have the following installed on your system:

Docker: Install Docker (https://docs.docker.com/get-docker/)
Docker Compose (usually bundled with Docker Desktop for Mac and Windows): Install Docker Compose (https://docs.docker.com/compose/install/)

##Getting Started

Clone this repository to your local machine:
git clone https://github.com/noaman/wireguard-http-proxy.git
Navigate to the project directory:

bash
Copy code
cd wireguard-http-proxy
Create or Copy a WireGuard configuration file (example iwg0.conf) in the conf.d/wireguard directory. You can generate this file according to your specific requirements.

You can also edit the tinyproxy.conf file in the conf.d/tinyproxy/tinyproxy.conf directory to configure the TinyHTTP Proxy settings as needed.

Build and start the Docker containers:

Copy code
docker-compose up -d
Usage
Your WireGuard VPN and TinyHTTP Proxy should now be up and running. You can configure your client device to connect to the WireGuard VPN to route your web traffic through the TinyHTTP Proxy.

To connect to the WireGuard VPN, use a WireGuard client of your choice and import the wg0.conf file you created earlier.

To configure your web browser to use the TinyHTTP Proxy, set the proxy settings to the IP address of the WireGuard interface and the port specified in the tinyproxy.conf file.

Customization
You can customize the WireGuard and TinyHTTP Proxy configurations to suit your specific needs by editing the wireguard/wg0.conf and tinyproxy/tinyproxy.conf files respectively.

Troubleshooting
If you encounter any issues or have questions, please check the Issues section of this repository to see if your problem has already been addressed. If not, feel free to open a new issue.

License
This project is licensed under the MIT License. See the LICENSE file for details.