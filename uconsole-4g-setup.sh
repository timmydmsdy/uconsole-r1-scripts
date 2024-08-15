
# enable 4g card - from enable_4g.sh
if test -f /tmp/4g.txt; then
    echo "Card already enabled"
fi 

if ! test -f /tmp/4g.txt; then
    echo "Power On 4G"
    sudo gpio mode 34 out
    sudo gpio write 34 1

    sudo gpio mode 33 out
    sudo gpio write 33 1

    sleep 5
    sudo gpio write 33 0

    sleep 10
    echo "Power on 4g done"
    touch /tmp/4g.txt
fi

# test to make sure that the card is available and has a SIM installed


# test to make sure that mmcli is able to see the card, if not, restart ModemManager
f mmcli -L | grep SIMCOM_SIM7600G-H
then
    echo "Card Found!"
else
    echo "Card not found, restarting Modem Manager"
    sudo systemctl restart ModemManager
    sleep 10
    # check to make sure that ModemManager restarts successfully needs to be cleaned up
    if systemctl status ModemManager | grep running
        echo "ModemManager Successfully restarted!"
    else
        echo "restart of service failed, script exiting"
        exit 1
    fi
fi 

# hacky way to check for the card after ModemManager was restarted
if mmcli -L | grep SIMCOM_SIM7600G-H
then
    echo "Card Found!"
else
    echo "Card not found, please retry script"
    exit 1


# test to make sure that the modem is at ttyusb2
if mmcli -m any | grep "primary port" | grep ttyUSB
then
    echo "ttyUSB2 found!"
else
    echo "ttyUSB2 not found!"
fi 
# bring up 4g net connection MUST BE NAMED 4gnet



#todo
# allow for the creation of the 4gnet
# allow for the networkname to be a variable
# allow for storing of multiple configs
# create setup/connect option screen