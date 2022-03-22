{
  description = ''Bindings for the HDF5 data format C library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimhdf5-v0_3_8.flake = false;
  inputs.src-nimhdf5-v0_3_8.owner = "Vindaar";
  inputs.src-nimhdf5-v0_3_8.ref   = "v0_3_8";
  inputs.src-nimhdf5-v0_3_8.repo  = "nimhdf5";
  inputs.src-nimhdf5-v0_3_8.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimhdf5-v0_3_8"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nimhdf5-v0_3_8";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}