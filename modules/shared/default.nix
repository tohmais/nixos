{
  myLib,
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
  };
}
