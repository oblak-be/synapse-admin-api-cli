# Synapse Admin API CLI

This is a CLI tool written in **Bash** to interact with the Synapse Admin API.

## Installation

The installation of this tool is pretty straigthforward. Just clone this repository and run the installation script.

```bash
git clone https://github.com/oblak-be/synapse-admin-api-cli.git
cd synapse-admin-api-cli/
./install.sh
```

## Access Token

Instructions to figure out your access token with Element (the flagship Matrix client).

1. Log in with and admin account

2. Open **Settings** > **Help & About**

3. Below **Advanced** you can view/copy the Access Token.

## Configuration

Create a file named `/etc/synapse-admin/cli.conf` and add:

```bash
SYNAPSE_HOMESERVER="matrix.homeserver.example"
SYNAPSE_ADMIN_USER="@admin:homeserver.example"
SYNAPSE_ACCESS_TOKEN="<admin access token>"
```

## Usage

Run `synapse-admin` to view the inline help
