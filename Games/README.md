# How to Install Games

## Build from Source

1. Copy the contents of '/src/OUGamePack/*' to your 'UT2004_HOME/OUGamePack/*'.
2. Edit 'UT2004_HOME/System/UT2004.ini' to include the following:
```
[Editor.EditorEngine]
EditPackages=OUGamePack
```
3. Remove the 'OUGamePack.u' and 'OUGamePack.ucl' files from 'UT2004_HOME/System/*' (if they exist)
4. Run `ucc make`

## Precompiled

Copy the contents of '/pub/OUGamePack/*' to your 'UT2004_HOME/System/UT2004/*'.
