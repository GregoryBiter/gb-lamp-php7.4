#!/usr/bin/env python3
import os
import sys
import subprocess
import shutil

def start():
    """Start the services using docker compose."""
    print("Starting services...")
    subprocess.run(["docker", "compose", "up", "-d"])

def stop():
    """Stop the services using docker compose."""
    print("Stopping services...")
    subprocess.run(["docker", "compose", "down"])

def stop_all():
    """Stop all running docker containers."""
    print("Stopping all containers...")
    containers = subprocess.check_output(["docker", "ps", "-q"]).decode('utf-8').strip()
    if containers:
        container_list = containers.split('\n')
        subprocess.run(["docker", "stop"] + container_list)

def status():
    """Check the status of services."""
    print("Checking status of services...")
    subprocess.run(["docker", "compose", "ps"])

def restart():
    """Restart the services."""
    print("Restarting services...")
    stop()
    start()

def add_domain(domain):
    """Add a new domain configuration."""
    if not domain:
        print("Domain name is required")
        return 1
        
    source_conf = ".dockerfile/hosts/exemple.site.conf"
    target_conf = f".dockerfile/hosts/{domain}.conf"
    
    # Copy the example configuration
    shutil.copy2(source_conf, target_conf)
    
    # Replace domain name in the configuration
    with open(target_conf, 'r') as file:
        content = file.read()
    
    content = content.replace("exemple.site", domain)
    
    with open(target_conf, 'w') as file:
        file.write(content)
    
    # Create domain directory and add index.html
    domain_dir = f"./www/{domain}"
    os.makedirs(domain_dir, exist_ok=True)
    
    with open(f"{domain_dir}/index.html", 'w') as file:
        file.write(f"<html><body><h1>Welcome to {domain}</h1></body></html>")
    
    print(f"Domain {domain} added")
    return 0

def remove_domain(domain):
    """Remove an existing domain configuration."""
    if not domain:
        print("Domain name is required")
        return 1
    
    # Remove domain configuration file
    conf_file = f".dockerfile/hosts/{domain}.conf"
    if os.path.exists(conf_file):
        os.remove(conf_file)
    
    # Remove domain directory
    domain_dir = f"./www/{domain}"
    if os.path.exists(domain_dir):
        shutil.rmtree(domain_dir)
    
    print(f"Domain {domain} removed")
    return 0

def show_help():
    """Display help information."""
    script_name = os.path.basename(sys.argv[0])
    print(f"Usage: {script_name} {{start|stop|stop_all|status|restart|add_domain|remove_domain|help}}")
    print("Commands:")
    print("  start                  Start the services")
    print("  stop                   Stop the services")
    print("  stop_all               Stop all running containers")
    print("  status                 Check the status of the services")
    print("  restart                Restart the services")
    print("  add_domain <domain>    Add a new domain")
    print("  remove_domain <domain> Remove an existing domain")
    print("  help                   Display this help message")

def main():
    if len(sys.argv) < 2:
        show_help()
        return 1
    
    command = sys.argv[1]
    
    if command == "start":
        start()
    elif command == "stop":
        stop()
    elif command == "stop_all":
        stop_all()
    elif command == "status":
        status()
    elif command == "restart":
        restart()
    elif command == "add_domain" and len(sys.argv) > 2:
        return add_domain(sys.argv[2])
    elif command == "remove_domain" and len(sys.argv) > 2:
        return remove_domain(sys.argv[2])
    elif command == "help":
        show_help()
    else:
        print(f"Неизвестная команда: {command}")
        show_help()
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
