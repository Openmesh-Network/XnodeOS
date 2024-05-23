{ config, lib, pkgs, ... }:

with lib;

let 
  eachOpenmeshCore = config.services.openmesh-core; # eachCore handles the case where you are running a mainnet and testnet core on the same Xnode

  coreOpts = { config, lib, name, ... }: {

    options = {

      enable = lib.mkEnableOption "Openmesh Core Node";

      # Add more options

      package = mkPackageOption pkgs [ "openmesh-core" ] { };
    };
  };
in
{
  ###### interface
  options = {
    services.openmesh-core = mkOption {
      type = types.attrsOf (types.submodule coreOpts);
      default = {};
      description = "Specification of one or more openmesh core instances.";
    };
  };

  ###### implementation
  config = mkIf (eachOpenmeshCore != {}) {

    environment.systemPackages = flatten (mapAttrsToList (coreName: cfg: [
      cfg.package
    ]) eachOpenmeshCore); # Remove or complete the implementation by abstracting underlying configs such as the genesis.json and config.toml

    systemd.services = mapAttrs' (coreName: cfg: let 
      dataDir = "/var/lib/xnode/${coreName}";
    in (
      nameValuePair "core-${coreName}" (mkIf cfg.enable {
        description = "Openmesh core node";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];

        serviceConfig = {

        }
      })
    ))
  }
}