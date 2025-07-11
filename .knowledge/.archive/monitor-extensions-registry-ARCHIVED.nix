# ARCHIVED: Monitor Extension Registry (Replaced with Option Merging)
# Date: 2025-07-11
# Reason: Replaced with more idiomatic NixOS option merging pattern
#
# This file implemented a manual registry for monitor extensions, but was replaced
# with the standard NixOS pattern of letting the module system automatically merge
# option definitions from multiple modules.

{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.modules._monitorExtensions = mkOption {
    type = types.listOf types.deferredModule;
    default = [ ];
    internal = true;
    description = ''
      Monitor type extensions for DE-specific options.

      This is an internal option used by extension modules
      to register additional monitor options.

      DEPRECATED: No longer needed with option merging approach.
    '';
  };
}
