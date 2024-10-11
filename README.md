# Ubuntu No-GUI Startup Service

## Overview
This repository provides an installation script for **Ubuntu 20.04** (and other compatible Debian-based distributions) that automatically creates a system service to disable the GUI at startup. It also includes a convenient script to easily re-enable the GUI when needed.

## Features
- **Automatic No-GUI Startup:** Configures the system to start without a graphical user interface (GUI) for improved performance or server use.
- **Convenient GUI Re-enable Script:** Provides a simple script to bring the GUI back when needed.
- **Compatible with Debian-based OS:** Works with Ubuntu 20.04 and other Debian flavors.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/MrHuangKong/ubuntu-no-gui-startup-service.git
   cd ubuntu-no-gui-startup-service
2. Install the Script:
   ```bash
   sudo ./no-gui-startup.sh
3. Script Alias Commands:
   - Start GUI
     ```bash
     sudo gui start
   - Stop GUI
     ```bash
     sudo gui stop
   - Get Available Commands:
     ```bash
     sudo gui help
