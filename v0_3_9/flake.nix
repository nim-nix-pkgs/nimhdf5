{
  description = ''Bindings for the HDF5 data format C library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimhdf5-v0_3_9.flake = false;
  inputs.src-nimhdf5-v0_3_9.ref   = "refs/tags/v0.3.9";
  inputs.src-nimhdf5-v0_3_9.owner = "Vindaar";
  inputs.src-nimhdf5-v0_3_9.repo  = "nimhdf5";
  inputs.src-nimhdf5-v0_3_9.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimhdf5-v0_3_9"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimhdf5-v0_3_9";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}