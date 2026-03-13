{ config, pkgs, ... }: {
  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wg-quick.interfaces = {
    wg0 = {
      # Use 'address' instead of 'ips' for wg-quick
      address = [ "10.100.0.2/24" ];
      listenPort = 51820;

      privateKeyFile = "${config.users.users.ranger.home}/wireguard-keys/private";

      peers = [
        {
          publicKey = "Ad6HapBOd+2yCE6wSTfIC436VXrUZkhpmVaWtjEuwkQ=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "[2a0d:5600:24:48::10]:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
