{
  myLib,
  pkgs,
  config,
  inputs,
  ...
}: let
  opts = myLib.filesIn ./options;
in {
  imports =
    []
    ++ opts;

  config = {
    # if i can actually figure out how to do this stupid bullshit itll be great but whatever
    # helpers = import ./helper {inherit pkgs;};
  };
}
