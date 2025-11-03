#!/bin/sh

CYAN="\033[0;36m"
WHITE="\033[1;37m"
DGRAY="\033[1;30m"
NC="\033[0m"

echo -e "${CYAN}Setting up VNC Server...${NC}"

read -p "Enter your server port: " VNC_PORT

# Restar 5900 al puerto
VNC_PORT=$(( VNC_PORT - 5900 ))

echo -e "${WHITE}Updating package list...${NC}"
apt update
echo -e "${DGRAY}Installing LXDE and TigerVNC server...${NC}"
apt install -y lxde tigervnc-server

RUN_SH="/run.sh"
cp $RUN_SH $RUN_SH.bak

echo -e "#!/bin/sh" > $RUN_SH
echo "rm -rf /tmp/.X*-lock" >> $RUN_SH
echo "vncserver :$VNC_PORT -xstartup /usr/bin/startlxde -nolisten tcp" >> $RUN_SH

chmod +x $RUN_SH

echo -e "${CYAN}VNC Server setup complete!${NC}"
