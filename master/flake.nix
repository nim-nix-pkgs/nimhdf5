{
  description = ''Bindings for the HDF5 data format C library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimhdf5-master.flake = false;
  inputs.src-nimhdf5-master.ref   = "refs/heads/master";
  inputs.src-nimhdf5-master.owner = "Vindaar";
  inputs.src-nimhdf5-master.repo  = "nimhdf5";
  inputs.src-nimhdf5-master.type  = "github";
  
  inputs."github.com/vindaar/seqmath".owner = "nim-nix-pkgs";
  inputs."github.com/vindaar/seqmath".ref   = "master";
  inputs."github.com/vindaar/seqmath".repo  = "github.com/vindaar/seqmath";
  inputs."github.com/vindaar/seqmath".dir   = "";
  inputs."github.com/vindaar/seqmath".type  = "github";
  inputs."github.com/vindaar/seqmath".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/vindaar/seqmath".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimhdf5-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimhdf5-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}