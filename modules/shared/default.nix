{
  myLib,
  config,
  inputs,
  ...
}: let
  helpers = myLib.filesIn ./helper;
  opts = myLib.filesIn ./options;
in {
  imports =
    []
    ++ helpers
    ++ opts;

  config = {
  };
}
