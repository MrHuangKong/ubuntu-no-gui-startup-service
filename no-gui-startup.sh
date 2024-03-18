#!/bin/bash

# Display installation starting
echo "-----------------Installation-----------------"
echo "No-GUI Service Installation Started..."
echo " "

# Define the startup script content
cat <<EOF > /tmp/no-gui.sh
#!/bin/sh
# Stop GUI Service and Start TTY2 Terminal
sleep 5
sudo chvt 2
sudo service lightdm stop
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

# Display completion
echo "Startup script installation: Complete"
echo "Systemd service enabled: Complete"
echo "Installation finished..."
echo "No-GUI Service will start upon next reboot"
echo "-------------------Finished-------------------"
echo " "
