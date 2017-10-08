$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)

require 'Unix/Ps_ef'
require 'test/unit'
require 'pp'




class TestUnixPsEf < Test::Unit::TestCase



	def test_ps_ef_1

		ps_ef = Ps_ef.new(DATA.read)

		assert_equal(ps_ef.have_more_children(4), [1527])
		
	end
end
__END__
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 Aug19 ?        00:06:53 /usr/lib/systemd/systemd --switched-root --system --deserialize 23
root         2     0  0 Aug19 ?        00:00:01 [kthreadd]
root         4     2  0 Aug19 ?        00:00:00 [kworker/0:0H]
root         6     2  0 Aug19 ?        00:00:00 [mm_percpu_wq]
root         7     2  0 Aug19 ?        00:00:01 [ksoftirqd/0]
root         8     2  0 Aug19 ?        00:09:18 [rcu_sched]
root         9     2  0 Aug19 ?        00:00:00 [rcu_bh]
root        10     2  0 Aug19 ?        00:07:40 [rcuos/0]
root        11     2  0 Aug19 ?        00:00:00 [rcuob/0]
root        12     2  0 Aug19 ?        00:00:00 [migration/0]
root        13     2  0 Aug19 ?        00:00:06 [watchdog/0]
root        14     2  0 Aug19 ?        00:00:00 [cpuhp/0]
root        15     2  0 Aug19 ?        00:00:00 [cpuhp/1]
root        16     2  0 Aug19 ?        00:00:06 [watchdog/1]
root        17     2  0 Aug19 ?        00:00:00 [migration/1]
root        18     2  0 Aug19 ?        00:00:13 [ksoftirqd/1]
root        20     2  0 Aug19 ?        00:00:00 [kworker/1:0H]
root        21     2  0 Aug19 ?        00:03:33 [rcuos/1]
root        22     2  0 Aug19 ?        00:00:00 [rcuob/1]
root        23     2  0 Aug19 ?        00:00:00 [kdevtmpfs]
root        24     2  0 Aug19 ?        00:00:00 [netns]
root        27     2  0 Aug19 ?        00:00:00 [oom_reaper]
root        28     2  0 Aug19 ?        00:00:00 [writeback]
root        29     2  0 Aug19 ?        00:00:00 [kcompactd0]
root        30     2  0 Aug19 ?        00:00:00 [ksmd]
root        31     2  0 Aug19 ?        00:00:00 [khugepaged]
root        32     2  0 Aug19 ?        00:00:00 [crypto]
root        33     2  0 Aug19 ?        00:00:00 [kintegrityd]
root        34     2  0 Aug19 ?        00:00:00 [bioset]
root        35     2  0 Aug19 ?        00:00:00 [kblockd]
root        36     2  0 Aug19 ?        00:00:00 [ata_sff]
root        37     2  0 Aug19 ?        00:00:00 [md]
root        38     2  0 Aug19 ?        00:00:00 [devfreq_wq]
root        39     2  0 Aug19 ?        00:00:00 [watchdogd]
root        41     2  0 Aug19 ?        00:00:05 [kauditd]
root        42     2  0 Aug19 ?        00:01:33 [kswapd0]
root        43     2  0 Aug19 ?        00:00:00 [bioset]
root        90     2  0 Aug19 ?        00:00:00 [kthrotld]
root        91     2  0 Aug19 ?        00:00:00 [acpi_thermal_pm]
root        92     2  0 Aug19 ?        00:00:00 [scsi_eh_0]
root        93     2  0 Aug19 ?        00:00:00 [scsi_tmf_0]
root        94     2  0 Aug19 ?        00:00:00 [scsi_eh_1]
root        95     2  0 Aug19 ?        00:00:00 [scsi_tmf_1]
root        96     2  0 Aug19 ?        00:00:00 [scsi_eh_2]
root        97     2  0 Aug19 ?        00:00:00 [scsi_tmf_2]
root       101     2  0 Aug19 ?        00:00:00 [dm_bufio_cache]
root       102     2  0 Aug19 ?        00:00:00 [ipv6_addrconf]
root       121     2  0 Aug19 ?        00:00:00 [bioset]
root       334     2  0 Aug19 ?        00:03:04 [kworker/1:1H]
root       354     2  0 Aug19 ?        00:00:00 [ttm_swap]
root       474     2  0 Aug19 ?        00:00:00 [kdmflush]
root       475     2  0 Aug19 ?        00:00:00 [bioset]
root       485     2  0 Aug19 ?        00:00:00 [kdmflush]
root       486     2  0 Aug19 ?        00:00:00 [bioset]
root       499     2  0 Aug19 ?        00:00:02 [kworker/0:1H]
root       513     2  0 Aug19 ?        00:02:44 [jbd2/dm-0-8]
root       514     2  0 Aug19 ?        00:00:00 [ext4-rsv-conver]
root       604     1  0 Aug19 ?        00:22:05 /usr/lib/systemd/systemd-journald
root       631     2  0 Aug19 ?        00:00:00 [rpciod]
root       632     2  0 Aug19 ?        00:00:00 [xprtiod]
root       650     1  0 Aug19 ?        00:00:12 /usr/lib/systemd/systemd-udevd
root       682     2  0 Aug19 ?        00:00:00 [cfg80211]
root       691     2  0 Aug19 ?        00:01:27 [irq/32-iwlwifi]
root       733     2  0 Aug19 ?        00:00:00 [kdmflush]
root       734     2  0 Aug19 ?        00:00:00 [bioset]
root       740     2  0 Aug19 ?        00:00:00 [kdmflush]
root       741     2  0 Aug19 ?        00:00:00 [bioset]
root       745     2  0 Aug19 ?        00:00:00 [kdmflush]
root       749     2  0 Aug19 ?        00:00:00 [kdmflush]
root       750     2  0 Aug19 ?        00:00:00 [bioset]
root       753     2  0 Aug19 ?        00:00:00 [kdmflush]
root       754     2  0 Aug19 ?        00:00:00 [bioset]
root       759     2  0 Aug19 ?        00:00:00 [kdmflush]
root       760     2  0 Aug19 ?        00:00:00 [bioset]
root       775     2  0 Aug19 ?        00:00:00 [kdmflush]
root       777     2  0 Aug19 ?        00:00:00 [bioset]
root       779     2  0 Aug19 ?        00:00:00 [kdmflush]
root       780     2  0 Aug19 ?        00:00:00 [bioset]
root       782     2  0 Aug19 ?        00:00:00 [kdmflush]
root       783     2  0 Aug19 ?        00:00:00 [bioset]
root       786     2  0 Aug19 ?        00:00:00 [kdmflush]
root       791     2  0 Aug19 ?        00:00:00 [bioset]
root       794     2  0 Aug19 ?        00:00:00 [kdmflush]
root       797     2  0 Aug19 ?        00:00:00 [bioset]
root       800     2  0 Aug19 ?        00:00:00 [kdmflush]
root       803     2  0 Aug19 ?        00:00:00 [bioset]
root       875     2  0 Aug19 ?        00:00:00 [bioset]
root       878     2  0 Aug19 ?        00:00:00 [xfsalloc]
root       880     2  0 Aug19 ?        00:00:00 [xfs_mru_cache]
root       882     2  0 Aug19 ?        00:00:00 [xfs-buf/dm-5]
root       883     2  0 Aug19 ?        00:00:00 [xfs-buf/dm-13]
root       884     2  0 Aug19 ?        00:00:00 [xfs-data/dm-5]
root       885     2  0 Aug19 ?        00:00:00 [xfs-buf/dm-4]
root       886     2  0 Aug19 ?        00:00:00 [xfs-conv/dm-5]
root       887     2  0 Aug19 ?        00:00:00 [xfs-cil/dm-5]
root       888     2  0 Aug19 ?        00:00:00 [xfs-data/dm-4]
root       889     2  0 Aug19 ?        00:00:00 [xfs-reclaim/dm-]
root       890     2  0 Aug19 ?        00:00:00 [xfs-conv/dm-4]
root       891     2  0 Aug19 ?        00:00:00 [xfs-log/dm-5]
root       892     2  0 Aug19 ?        00:00:00 [xfs-cil/dm-4]
root       893     2  0 Aug19 ?        00:00:00 [xfs-eofblocks/d]
root       894     2  0 Aug19 ?        00:00:00 [xfs-reclaim/dm-]
root       895     2  0 Aug19 ?        00:00:00 [xfs-log/dm-4]
root       896     2  0 Aug19 ?        00:00:00 [xfs-eofblocks/d]
root       897     2  0 Aug19 ?        00:00:00 [xfs-data/dm-13]
root       898     2  0 Aug19 ?        00:00:00 [xfs-conv/dm-13]
root       899     2  0 Aug19 ?        00:00:00 [xfs-cil/dm-13]
root       900     2  0 Aug19 ?        00:00:00 [xfs-reclaim/dm-]
root       901     2  0 Aug19 ?        00:00:00 [xfs-log/dm-13]
root       902     2  0 Aug19 ?        00:00:00 [xfs-eofblocks/d]
root       906     2  0 Aug19 ?        00:00:00 [jbd2/dm-2-8]
root       907     2  0 Aug19 ?        00:00:00 [ext4-rsv-conver]
root       908     2  0 Aug19 ?        00:00:00 [xfs-buf/dm-6]
root       909     2  0 Aug19 ?        00:00:00 [xfs-buf/dm-7]
root       910     2  0 Aug19 ?        00:00:00 [xfs-data/dm-6]
root       911     2  0 Aug19 ?        00:00:00 [xfs-data/dm-7]
root       912     2  0 Aug19 ?        00:00:00 [xfs-conv/dm-7]
root       913     2  0 Aug19 ?        00:00:00 [xfs-cil/dm-7]
root       914     2  0 Aug19 ?        00:00:00 [xfs-reclaim/dm-]
root       915     2  0 Aug19 ?        00:00:00 [xfs-log/dm-7]
root       916     2  0 Aug19 ?        00:00:00 [xfs-eofblocks/d]
root       917     2  0 Aug19 ?        00:00:00 [xfs-conv/dm-6]
root       919     2  0 Aug19 ?        00:00:00 [xfs-cil/dm-6]
root       920     2  0 Aug19 ?        00:00:00 [xfs-reclaim/dm-]
root       921     2  0 Aug19 ?        00:00:00 [xfs-log/dm-6]
root       922     2  0 Aug19 ?        00:00:00 [xfs-eofblocks/d]
root       924     2  0 Aug19 ?        00:01:31 [xfsaild/dm-4]
root       925     2  0 Aug19 ?        00:00:00 [xfsaild/dm-7]
root       926     2  0 Aug19 ?        00:00:00 [xfsaild/dm-13]
root       927     2  0 Aug19 ?        00:00:19 [xfsaild/dm-5]
root       928     2  0 Aug19 ?        00:00:00 [xfsaild/dm-6]
root       931     2  0 Aug19 ?        00:00:00 [jbd2/sda3-8]
root       932     2  0 Aug19 ?        00:00:00 [ext4-rsv-conver]
root       971     1  0 Aug19 ?        00:00:12 /sbin/auditd
root       973   971  0 Aug19 ?        00:00:12 /sbin/audispd
root       977   973  0 Aug19 ?        00:00:07 /usr/sbin/sedispatch
root       997     1  0 Aug19 ?        00:00:32 /usr/libexec/accounts-daemon
avahi     1002     1  0 Aug19 ?        00:00:43 avahi-daemon: running [server2.local]
dbus      1005     1  0 Aug19 ?        00:14:53 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
chrony    1015     1  0 Aug19 ?        00:00:08 /usr/sbin/chronyd
avahi     1018  1002  0 Aug19 ?        00:00:00 avahi-daemon: chroot helper
root      1021     1  0 Aug19 ?        00:00:02 /usr/sbin/gssproxy -D
root      1029     1  0 Aug19 ?        00:00:02 /usr/bin/python3 -Es /usr/sbin/firewalld --nofork --nopid
root      1030     1  0 Aug19 ?        00:00:00 /usr/sbin/alsactl -s -n 19 -c -E ALSA_CONFIG_PATH=/etc/alsa/alsactl.conf --initfile=/lib/alsa/init/00main rdaemon
root      1031     1  0 Aug19 ?        00:19:07 /usr/libexec/udisks2/udisksd --no-debug
rtkit     1032     1  0 Aug19 ?        00:00:34 /usr/libexec/rtkit-daemon
root      1033     1  0 Aug19 ?        00:04:02 /usr/lib/systemd/systemd-logind
root      1034     1  0 Aug19 ?        00:00:07 /usr/sbin/ModemManager
root      1036     1  0 Aug19 ?        00:00:06 /usr/sbin/abrtd -d -s
polkitd   1054     1  0 Aug19 ?        00:00:49 /usr/lib/polkit-1/polkitd --no-debug
root      1070     1  0 Aug19 ?        00:00:04 /usr/bin/abrt-dump-journal-xorg -fxtD
root      1072     1  0 Aug19 ?        00:00:05 /usr/bin/abrt-dump-journal-oops -fxtD
root      1083     1  0 Aug19 ?        00:10:42 /usr/sbin/NetworkManager --no-daemon
root      1154     1  0 Aug19 ?        00:00:50 /usr/sbin/iscsid
root      1155     1  0 Aug19 ?        00:00:00 /usr/sbin/iscsid
root      1190     1  0 Aug19 ?        00:00:00 /usr/sbin/sshd
root      1197     2  0 Aug19 ?        00:00:00 [iscsi_eh]
root      1204     2  0 Aug19 ?        00:00:00 [target_completi]
root      1205     2  0 Aug19 ?        00:00:00 [tmr-rd_mcp]
root      1206     2  0 Aug19 ?        00:00:00 [xcopy_wq]
btsync    1207     1 10 Aug19 ?        3-11:14:31 /usr/bin/btsync --config /etc/btsync/config.json
root      1244     2  0 Aug19 ?        00:00:00 [bioset]
root      1245     2  0 Aug19 ?        00:00:00 [tmr-iblock]
root      1253     2  0 Aug19 ?        00:00:00 [bioset]
root      1254     2  0 Aug19 ?        00:00:00 [tmr-iblock]
root      1255     2  0 Aug19 ?        00:00:00 [bioset]
root      1256     2  0 Aug19 ?        00:00:00 [tmr-iblock]
root      1257     2  0 Aug19 ?        00:00:00 [iscsi_np]
root      1258     2  0 Aug19 ?        00:00:00 [iscsi_np]
named     1334     1  0 Aug19 ?        00:08:20 /usr/sbin/named -u named
root      1339     2  0 Aug19 ?        00:00:00 [kworker/u5:0]
root      1340     2  0 Aug19 ?        00:00:01 [kworker/u5:1]
root      1342     1  0 Aug19 ?        00:03:02 /usr/sbin/wpa_supplicant -c /etc/wpa_supplicant/wpa_supplicant.conf -u -s
bacula    1345     1  0 Aug19 ?        00:00:07 /usr/sbin/bacula-sd -f -c /etc/bacula/bacula-sd.conf -u bacula -g tape
root      1346     1  0 Aug19 ?        00:00:04 /usr/sbin/bacula-fd -f -c /etc/bacula/bacula-fd.conf -u root -g root
bacula    1347     1  0 Aug19 ?        00:14:01 /usr/sbin/bacula-dir -f -c /etc/bacula/bacula-dir.conf -u bacula -g bacula
mysql     1365     1  0 Aug19 ?        03:20:33 /usr/libexec/mysqld --daemonize --basedir=/usr --pid-file=/var/run/mysqld/mysqld.pid
root      1404     2  0 Sep07 ?        00:00:00 [bioset]
root      1527     1  0 Aug19 ?        00:03:04 /usr/sbin/httpd -DFOREGROUND
root      1528     1  0 Aug19 ?        00:00:00 /usr/sbin/libvirtd
root      1537     1  0 Aug19 ?        00:00:17 /usr/sbin/crond -n
root      1538     1  0 Aug19 ?        00:00:00 /usr/sbin/atd -f
root      1539     1  0 Aug19 ?        00:00:00 /usr/sbin/gdm
root      1753     1  0 Aug19 ?        00:00:08 /usr/libexec/upowerd
nobody    1789     1  0 Aug19 ?        00:00:00 /sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default.conf --leasefile-ro --dhcp-script=/usr/libexec/libvirt_leases
root      1790  1789  0 Aug19 ?        00:00:00 /sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default.conf --leasefile-ro --dhcp-script=/usr/libexec/libvirt_leases
root      1883  1539  0 Aug19 ?        00:00:00 gdm-session-worker [pam/gdm-launch-environment]
gdm       1927     1  0 Aug19 ?        00:00:04 /usr/lib/systemd/systemd --user
gdm       1970  1927  0 Aug19 ?        00:00:00 (sd-pam)
gdm       1975  1883  0 Aug19 tty1     00:00:00 /usr/libexec/gdm-x-session gnome-session --autostart /usr/share/gdm/greeter/autostart
gdm       1977  1975  0 Aug19 tty1     00:00:08 /usr/libexec/Xorg vt1 -displayfd 3 -auth /run/user/42/gdm/Xauthority -background none -noreset -keeptty -verbose 3
dhcpd     1983     1  0 Aug19 ?        00:00:12 /usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcpd --no-pid
gdm       1992  1975  0 Aug19 tty1     00:00:24 /usr/libexec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart
gdm       1996  1927  0 Aug19 ?        00:00:00 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
gdm       2000  1927  0 Aug19 ?        00:00:00 /usr/libexec/at-spi-bus-launcher
gdm       2005  2000  0 Aug19 ?        00:00:00 /bin/dbus-daemon --config-file=/usr/share/defaults/at-spi2/accessibility.conf --nofork --print-address 3
gdm       2009  1927  0 Aug19 ?        00:00:00 /usr/libexec/at-spi2-registryd --use-gnome-session
gdm       2027     1  0 Aug19 ?        00:00:00 /usr/bin/pulseaudio --start --log-target=syslog
gdm       2055  1992  0 Aug19 tty1     00:00:12 /usr/libexec/gnome-settings-daemon
colord    2066     1  0 Aug19 ?        00:00:00 /usr/libexec/colord
ziutus    2133     1  0 Aug19 ?        00:00:00 /usr/lib/systemd/systemd --user
ziutus    2135  2133  0 Aug19 ?        00:00:00 (sd-pam)
root      5946     2  0 Sep19 ?        00:00:03 [kworker/u4:2]
rpc       6500     1  0 Sep09 ?        00:00:01 /usr/sbin/rpcbind -w -f
root      7414     2  0 Sep19 ?        00:00:01 [kworker/u4:0]
root      9956     2  0 18:35 ?        00:00:00 [kworker/1:2]
root      9967  1190  0 18:42 ?        00:00:00 sshd: ziutus [priv]
ziutus    9971  9967  0 18:42 ?        00:00:00 sshd: ziutus@pts/1
ziutus    9972  9971  0 18:42 pts/1    00:00:00 -bash
root     10057  1190  0 18:49 ?        00:00:00 sshd: ziutus [priv]
ziutus   10061 10057  0 18:49 ?        00:00:00 sshd: ziutus@notty
ziutus   10062 10061  0 18:49 ?        00:00:00 /usr/libexec/openssh/sftp-server
root     10090  1190  0 18:50 ?        00:00:00 sshd: ziutus [priv]
ziutus   10094 10090  0 18:50 ?        00:00:00 sshd: ziutus@notty
ziutus   10095 10094  0 18:50 ?        00:00:00 /usr/libexec/openssh/sftp-server
ziutus   10206  9972  0 19:25 pts/1    00:00:00 /usr/bin/mc -P /var/tmp/mc-ziutus/mc.pwd.9972
ziutus   10208 10206  0 19:25 pts/2    00:00:00 bash -rcfile .bashrc
root     10369     2  0 19:41 ?        00:00:00 [kworker/0:1]
root     10409     2  0 19:50 ?        00:00:00 [kworker/1:1]
root     10414     2  0 19:52 ?        00:00:00 [kworker/0:3]
root     10452     2  0 20:00 ?        00:00:00 [kworker/1:0]
root     10464     2  0 20:03 ?        00:00:00 [kworker/0:0]
ziutus   10466 10208  0 20:03 pts/2    00:00:00 ps -ef
ziutus   10706 32311  0 Aug20 ?        00:00:07 spring app    | blog | started 752 hours ago | development mode
ziutus   10778     1  0 Aug27 ?        00:00:00 ssh-agent
ziutus   10822     1  0 Aug27 ?        00:00:00 ssh-agent -s
root     30380     2  0 Sep06 ?        00:00:28 [kworker/u4:1]
apache   30690  1527  0 Sep17 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache   30691  1527  0 Sep17 ?        00:00:56 /usr/sbin/httpd -DFOREGROUND
apache   30692  1527  0 Sep17 ?        00:01:08 /usr/sbin/httpd -DFOREGROUND
apache   30693  1527  0 Sep17 ?        00:01:07 /usr/sbin/httpd -DFOREGROUND
apache   30694  1527  0 Sep17 ?        00:01:08 /usr/sbin/httpd -DFOREGROUND
apache   30695  1527  0 Sep17 ?        00:01:08 /usr/sbin/httpd -DFOREGROUND
root     32271     1  0 Aug19 ?        00:01:22 /usr/libexec/packagekitd
ziutus   32311     1  0 Aug19 ?        00:00:01 spring server | blog | started 769 hours ago