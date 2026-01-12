# Golden Os Image

In Azure, a Golden OS Image (often just called a golden image) is a pre-configured, standardized virtual machine (VM) image that an organization creates and uses as the baseline for deploying multiple VMs.

## Problem Statement : 

- As organizations grow, manually setting up OS on each server or VM is slow and cause to errors.

- There is a need to create a custom golden OS image.

- The golden image should include the organization’s best practices.

- It should have pre-configured settings and required software.

- Using the golden image ensures consistent and secure deployments every time.



### Objectives :


- Automate creation of a custom OS image for cloud and on-premises use.

- Include essential tools, security, network settings, and performance optimizations.

- Ensure consistent deployments with all configuration files and dependencies.

- Make the golden image easy to update with  patches or software updates.

## Requirements

### 1.  Create a custom OS image: 
Pre-configured with required software and environment-specific settings using Packer and Ansible.

### 2. Automate image creation: 
Build and deploy images across Azure, AWS, or GCP using Packer.

### 3. Ensure security: 
Apply automated patching, hardening, firewall rules, and user permissions through Ansible playbooks.

### 4.Optimize performance: 
Pre-tune the OS for better resource utilization and meet organizational performance standards using Ansible.

### 5. Simplify scaling:
 Deploy images easily across multiple environments without manual configuration using Ansible automation.

### 6. CI/CD Integration: 
Automate image building and updates using GitHub Actions or Azure DevOps Pipelines.

## What is Packer?

- Packer is an open-source tool by HashiCorp for automating the creation of machine images.

- It allows you to define your image configuration as code so that you can create consistent and repeatable images for multiple platforms.

- With Packer, you can build images Cloud providers AWS, Azure, Google Cloud

### Key Benefits of Packer

- Consistency: Every image is built the same way across environments.

- Automation: No manual VM setup; images are fully automated.

- Multi-cloud support: Build one configuration, deploy to AWS, Azure, GCP, VMware, etc.

- Versioning: Easily maintain and update images with new patches or software.

- Integrates with CI/CD: Packer can be part of a DevOps pipeline for automated image updates.

## Packer Components
- Template
  - A JSON or HCL file that defines the image configuration.

   - Includes builders, provisioners, and post-processors.

   - Acts like a blueprint for your image.

- Builders

    - Responsible for creating the machine image on a specific platform.

    -   Examples:

    -   amazon-ebs → AWS AMI

    - azure-arm → Azure Managed Image

- Provisioners

    ```Configure the image after the OS is installed.```

    Examples:

    - shell → run shell scripts

    -  ansible → run Ansible playbooks

# Ansible Roles

### OS Bootstrapping

``` 
Booting is the process of starting up a computer or virtual machine and loading the operating system into memory so it can run.
```

Task 1: Install base utilities

Task 2: Install chrony for time sync

Task 3: Enable and start chrony service

Task 4 : Gather service facts

Task 5 : Disable unused services

Task 6 : Verify package installation

 ### System_Configuration

 ```
 Configures the system hostname and timezone, secures SSH with a login banner, manages users and passwordless sudo access, sets a global shell environment, applies required services, and verifies idempotent execution.
 ```

 Task 1: Set system hostname

 Task 2: Set timezone

 Task 3: Create SSH banner file

 Task 4: Ensure SSH daemon uses banner

 Task 5: Restart SSH service to apply banner

 Task 6: Ensure users exist

 Task 7: Ensure sudoers for user without password

 Task 8: Configure default shell environment for all users

 Task 9 : Check idempotency

### SSH_UserSecurity

``` 
SSH (Secure Shell) is the main way to remotely access Linux VMs in Azure. Securing SSH is critical to prevent unauthorized access.
```

Task 1 : Prevent direct root login for security

Task 2 : Disable password login; only SSH keys allowed

Task 3 : Disconnect idle SSH sessions automatically

Task 4 : Log all sudo commands for auditing

Task 5 : Check current SSH config for applied changes

Task 6 : Confirm root login is disabled; fail if not

### Firewall_OS_Hardening

```
This playbook section focuses on VM security hardening, which ensures that the system is protected against unauthorized access, vulnerabilities, and misconfigurations.
```
Task 1 : Firewall (UFW / iptables)

Task 2 : Sysctl Security Settings

Task 3 : Automatic Security Updates

Task 4 : CIS Baseline Validation

### System Performance Tuning
```
System performance tuning involves optimizing hardware and software configurations to enhance efficiency, responsiveness, and overall performance of computer systems.
```
Task 1 : Configure file descriptor limits

Task 2 : Tune kernel parameters

Task 3 : Optimize boot time

Task 4 : Validate system resource usage


###  Future Scope 
1. lint in pipeline
2. Security Scanning
3. Store image

#