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

* HUGE credit towards vimjoyer, whose videos encouraged me to start on my nix journey, and whose personal config I used for the base of this one.
    * I have copied particular files of their config. I have included the original licence of the repository in the file LICENCE-vimjoyer.  
    * I have also included a small copyright notice at the top of files I have copied significantly (I don't need to do this, I just wanted to attribute properly)  
    * https://github.com/vimjoyer/nixconf