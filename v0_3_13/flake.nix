{
  description = ''Bindings for the HDF5 data format C library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimhdf5-v0_3_13.flake = false;
  inputs.src-nimhdf5-v0_3_13.ref   = "refs/tags/v0.3.13";
  inputs.src-nimhdf5-v0_3_13.owner = "Vindaar";
  inputs.src-nimhdf5-v0_3_13.repo  = "nimhdf5";
  inputs.src-nimhdf5-v0_3_13.type  = "github";
  
  inputs."github-vindaar-seqmath".owner = "nim-nix-pkgs";
  inputs."github-vindaar-seqmath".ref   = "master";
  inputs."github-vindaar-seqmath".repo  = "github-vindaar-seqmath";
  inputs."github-vindaar-seqmath".dir   = "v0_1_15";
  inputs."github-vindaar-seqmath".type  = "github";
  inputs."github-vindaar-seqmath".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github-vindaar-seqmath".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimhdf5-v0_3_13"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimhdf5-v0_3_13";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}