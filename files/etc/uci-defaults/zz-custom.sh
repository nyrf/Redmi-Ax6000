#!/bin/sh

#edit feeds
sed -i 's/downloads.openwrt.org/mirrors.ustc.edu.cn\/openwrt/g' /etc/opkg/distfeeds.conf
sed -i "/openwrt_kenzo/d" /etc/opkg/distfeeds.conf
sed -i "/openwrt_mosdns/d" /etc/opkg/distfeeds.conf
sed -i "/openwrt_small/d" /etc/opkg/distfeeds.conf
#echo "mt7915e wed_enable=Y" >> /etc/modules.d/mt7915e

[ "$(uci -q get system.@system[0].init)" != "" ] &&  exit 0
#set lan ip
uci set network.lan.ipaddr='192.168.10.1'
uci commit network

uci set system.@system[0].zonename='Asia/Shanghai'
uci set system.@system[0].timezone='CST-8'
uci set system.@system[0].cronloglevel='8'
uci set system.@system[0].conloglevel='7'
uci set system.@system[0].init='initiated'
uci commit system

#set luci default language
uci set luci.main.lang='zh_cn'
uci commit luci

#enable wlan
uci set wireless.@wifi-device[0].disabled='0'
uci set wireless.@wifi-iface[0].disabled='0'
uci set wireless.@wifi-device[1].disabled='0'
uci set wireless.@wifi-iface[1].disabled='0'
uci set wireless.@wifi-device[0].country='CN'
uci set wireless.@wifi-device[0].channel='auto'
uci set wireless.@wifi-iface[0].encryption='psk2+ccmp'
uci set wireless.@wifi-iface[0].key='12345678'
uci set wireless.@wifi-iface[0].ieee80211r='1'
uci set wireless.@wifi-iface[0].mobility_domain='1111'
uci set wireless.@wifi-iface[0].reassociation_deadline='20000'
uci set wireless.@wifi-iface[0].ft_over_ds='0'
uci set wireless.@wifi-iface[0].ft_psk_generate_local='1'
uci set wireless.@wifi-iface[0].ssid='Openwrt'
uci set wireless.@wifi-device[1].country='CN'
uci set wireless.@wifi-device[1].channel='auto'
uci set wireless.@wifi-device[1].htmode='HE160'
uci set wireless.@wifi-iface[1].encryption='psk2+ccmp'
uci set wireless.@wifi-iface[1].key='12345678'
uci set wireless.@wifi-iface[1].ieee80211r='1'
uci set wireless.@wifi-iface[1].mobility_domain='1111'
uci set wireless.@wifi-iface[1].reassociation_deadline='20000'
uci set wireless.@wifi-iface[1].ft_over_ds='0'
uci set wireless.@wifi-iface[1].ft_psk_generate_local='1'
uci set wireless.@wifi-iface[1].ssid='Openwrt5G'
uci commit wireless

#enable flow offloading
uci set firewall.@defaults[0].flow_offloading='1'
uci set firewall.@defaults[0].flow_offloading_hw='1'
uci commit firewall


echo "/www/luci-static/argon/background/" >> /etc/sysupgrade.conf
exit 0