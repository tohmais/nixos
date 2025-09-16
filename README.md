# NixOS Configuration

Notes for non-reproducible parts of system:
* Install ES-DE AppImage. NixOS core settings should already be placed in the correct spot.  
* Set up rescrobbled + sptlrx cookies/api keys
* Copy the following to ~/.config/spotify/Users/**username**/prefs:
    ```
    connect.dial_devices="[]"
    audio.allow_downgrade=false
    audio.sync_bitrate_enumeration=4
    audio.play_bitrate_non_metered_migrated=true
    audio.play_bitrate_non_metered_enumeration=4
    audio.play_bitrate_enumeration=4
    ```

### Credits

* HUGE credit towards vimjoyer, whose videos encouraged me to start on my nix journey, and whose personal config I based previous versions of this config on.
* HUGE credit towards atagen, whose amazing work on [their personal config](https://git.atagen.co/atagen/nix) includes work I have copied. A notice is included on all such files.
   
