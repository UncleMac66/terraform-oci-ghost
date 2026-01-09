# OCI Ghost Blog Terraform Stack (No Load Balancer)

This repository contains a fully modular Terraform configuration for deploying a high-performance [Ghost](https://ghost.org/) blogging platform on Oracle Cloud Infrastructure (OCI). The stack automatically provisions:

- A Virtual Cloud Network (VCN) with public and private subnets
- A compute instance (E6, 8 OCPUs, 128GB RAM) running Docker + Ghost and directly accessible via public IP
- All required security lists and networking
- Modular, reusable resources for easy extension

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) v1.3.0+
- OCI account with permissions and API keys configured in `~/.oci/config` (`[DEFAULT]` profile)
- SSH keypair to access the VM

_Note:_  
This stack reads all network and credential information from `~/.oci/config` automatically; you do **not** need to set any OCI credential variables in Terraform. Just ensure your DEFAULT profile is complete and active.

## Cloud Resources

- **VCN**: Public and private subnets, internet gateway/NAT gateway, routing, security lists (opens SSH + Ghost port 2368 to the world)
- **Compute Instance**: `VM.Standard.E6.Flex` (8 OCPUs, 128GB RAM)
- **Docker**: Automatically installed; Ghost launches on boot via cloud-init
- **Caddy**: Automatically set up https/ssl termination and coordination with Let's Encrypt

## Quick Start

1. **Clone this repo** and `cd` into it.

2. **Configure variables:**  
   Copy `terraform.tfvars.example` to `terraform.tfvars` and fill it out with values specific to your Oracle Cloud setup.
   - Required: `compartment_ocid`, `availability_domain`, `instance_display_name`, `source_id`, `ssh_public_key`
   - Optional: network CIDRs, `hostname_label`, `user_data_path`
   - See `variables.tf` and the example for more.

   Add your gmail address and gmail app password to `cloud-init/docker-compose.yml`
   ```
   mail__options__auth__user: <your-gmail-address>
   mail__options__auth__pass: <gmail-app-password>
   ```
   Hint: Search for 'app password' in your google account settings to set one up

   You can use another mail provider, it's easier, and cheaper to just use a gmail account but it's up to you and your use case. One is required by ghost in order to create your ghost developer account and to be able to use the ghost blog

3. **Initialize Terraform:**
   ```
   terraform init
   ```

4. **Plan & Deploy:**
   ```
   terraform apply
   ```

5. **Access Ghost Blog:**  
   Find the Ghost instance's public IP in Terraform output:
   ```
   ghost_public_ip = <INSTANCE_PUBLIC_IP>
   ```
   Open `https://<INSTANCE_PUBLIC_IP>` in your browser.

6. **(Optional) SSH Into the Instance:**
   ```
   ssh ubuntu@<INSTANCE_PUBLIC_IP>
   ```

## Customization

- Adjust compute shape (CPUs/RAM) or subnet CIDRs in `variables.tf`
- Plug custom Docker/Ghost settings into `cloud-init/ghost-init.sh`
- Add persistent block storage as desired (not included by default)

## File Structure

- `main.tf`, `provider.tf`, `variables.tf`, `outputs.tf`, `versions.tf`: Root Terraform configuration
- `modules/vcn`: VCN module (networking)
- `modules/compute`: Compute instance module (Ghost on Docker)
- `cloud-init/ghost-init.sh`: Boot scripts for Docker + Ghost setup

## Troubleshooting

- Ensure your specified region/AD supports `VM.Standard.E6.Flex` (8 OCPUs/128GB RAM)
- Security list restricts: Only SSH (22/tcp) and http/https (80,443/tcp) exposed to the world

## Next Steps (Extra Credit)

 **Configure a custom URL**  
   Change the caddy config and docker-compose.yml to include your custom url (That you already own and have control over) and reconfig (below). 

   ```
   sudo systemctl restart caddy.service
   docker compose up -d 
   ```

   Then edit the A or CNAME record in the DNS setting of your url provider with the ip address of the ghost instance

## License

MIT — use and adapt freely