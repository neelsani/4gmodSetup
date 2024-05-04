
#nmcli connection delete <uuid>

cd 
sleep 5
usbreset 1e0e:9001
#start 4g
while ! qmicli -d /dev/cdc-wdm0 --dms-set-operating-mode='online'; do echo trying again 1; done
outCmd=$(while ! qmicli -d /dev/cdc-wdm0 -w; do echo trying again2; done)
ip link set $outCmd down
echo 'Y' | tee /sys/class/net/$outCmd/qmi/raw_ip
ip link set $outCmd up
while ! qmicli -p -d /dev/cdc-wdm0 --device-open-net='net-raw-ip|net-no-qos-header' --wds-start-network="apn='zmp.com.attz',ip-type=4" --client-no-release-cid; do echo trying 3; done
#qmicli -p -d /dev/cdc-wdm0 --device-open-net='net-raw-ip|net-no-qos-header' --wds-start-network="apn='data641003',ip-type=4" --client-no-release-cid
sleep 5

udhcpc -i wwan0
echo connection madesupposedly

#openvpn --config /home/ivue/oracle.ovpn &
#screen -dmS OpenVPN openvpn --config /home/ivue/oracle.ovpn
#screen -dmS OpenVPN openvpn --config /home/ivue/ivue.ovpn


##mavproxy stuff
#cd /home/ivue/
#sleep 5
#usbreset 3162:0053
#sleep 5

#screen -dmS MavproxyIvue ./mavIvue.sh
export LOCALAPPDATA="LOCALAPPDATA"
echo firster
screen -dmS MavProxyIvue bash -c "mavproxy.py --out udpin:10.10.10.10:8765"  
echo laster
