{
  myLib,
  config,
  inputs,
  ...
}: let
  opts = myLib.filesIn ./options;
in {
  imports =
    [./helper]
    ++ opts;

  config = {
  };
}
