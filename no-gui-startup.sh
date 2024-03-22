#!/bin/bash
# MrHuangKong 3/18/2024
# This script installs a gui controller file that turns off the gui at startup and places the user in a tty console
# I created this script for Ubuntu 20.04 / Debian like distro's, I wanted to run my home servers in headless mode,
# but I also wanted the convenience of having a GUI occassionally. Hence, why I added aliases to allow the user to 
# turn the GUI back on, or to turn it back off after boot. You are free to take this, modify it as you see fit per
# the GNU's GPL-3.0 license. Cheers!

# Display installation starting
echo "---------------------------------------------------Installation---------------------------------------------------"
echo "No-GUI Service Installation Started..."
echo " "

# Define the startup script content
cat <<'EOF' > /tmp/no-gui.sh
#!/bin/bash

# Check for empty argument (default)
if [ -z "$1" ]; then
        # Default argument, Stop GUI Service and Start TTY2 Terminal
        sleep 3
        sudo chvt 2
        sudo service lightdm stop
        echo "GUI service stopped.."
        exit 1
# Check what argument user sent
else
        case $1 in
                start)
                        # Start gui
                        sudo service lightdm start
                        echo "GUI service started.."
                        ;;
                stop)
                        # Stop GUI Service and Start TTY2 Terminal
                        sleep 3
                        sudo chvt 2
                        sudo service lightdm stop
                        echo "GUI service stopped.."
                        ;;
                help)
                        # Tells user what options there are
                        # echo "Usage: $0 {start|stop}" # Replace this with 'gui' since we aliased it
                        echo "Usage: gui {start|stop}"
                        ;;
                *)
                        # Anything else, tell user usage
                        # echo "Usage: $0 {start|stop}"
                        echo "Usage: gui {start|stop}"
                        exit 1
                        ;;
        esac
fi
EOF
echo "Startup script created"

# Move the startup script to /usr/local/bin/
sudo mv /tmp/no-gui.sh /usr/local/bin/
sudo chmod 744 /usr/local/bin/no-gui.sh
echo "Startup script moved"

# Create the systemd service unit file
cat <<EOF > /tmp/no-gui.service
[Unit]
Description=No-GUI On Startup
After=network.service

[Service]
ExecStart=/usr/local/bin/no-gui.sh

[Install]
WantedBy=default.target
EOF
echo "Startup service created"

# Move the service unit file to /etc/systemd/system/
sudo mv /tmp/no-gui.service /etc/systemd/system/
sudo chmod 664 /etc/systemd/system/no-gui.service
echo "Startup service moved"

# Enable and start the systemd service
sudo systemctl daemon-reload
sudo systemctl enable no-gui.service
# sudo systemctl start no-gui.service
echo "Daemon reloaded"
echo "Service enabled"

# Create an alias to allow us to start and stop the lightdm service
alias="alias gui='sudo bash /usr/local/bin/no-gui.sh'"
comment="# Add a simple way to 'start' or 'stop' the lightdm service"
echo " " >> /home/$SUDO_USER/.bashrc
echo $comment >> /home/$SUDO_USER/.bashrc
echo $alias >> /home/$SUDO_USER/.bashrc
# Make alias available immediately
source /home/$SUDO_USER/.bashrc
echo "'gui' alias added, use 'start' or 'stop'"

# Display completion
echo "Startup script installation: Complete"
echo "Systemd service enabled: Complete"
echo "'no-gui' alias: Complete"
echo "Use 'gui start' or 'gui stop' to turn on/off"
echo "Installation finished..."
echo "No-GUI Service will start upon next reboot"
echo "-----------------------------------------------------Finished-----------------------------------------------------"
echo " "
