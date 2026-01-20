# IPTV
Scripts to create personal IPTV file from Brazil [FAST](https://en.wikipedia.org/wiki/Free_ad-supported_streaming_television) Platforms.

## Contents
- [Playlist](#playlist)
- [Resources](#resources)
- [Download](#download-repository) 
- [Commands](#commands)
- [Super Command](#super-command)
- [Extra Commands](#extra-commands)
- [Radios Stations Link](#radios-stations)

### Playlist
- https://lls-ws.github.io/iptv/LLS_TV_br.m3u

### Resources
- https://github.com/evoactivity/PlutoIPTV
- https://github.com/helenfernanda/gratis
- https://www.apsattv.com/streams.html

### Download Repository
```sh
git clone https://github.com/lls-ws/iptv.git && cd iptv
```

### Commands
  - [Options](#options) 
  - [Download](#download-playlist)
  - [Favorites](#edit-favorites-channels)
  - [Create](#create-favorites-playlist)

#### Options
> [!NOTE]
>  Replace the platform name with one of this options:
>  - movieark
>  - meutedio
>  - samsung
>  - redeitv
>  - pluto
>  - soul
>  - tcl
>  - lg

> [!TIP]
> Examples:
> - bash iptv.sh **`samsung`** download
> - bash iptv.sh **`pluto`** download

> [!IMPORTANT]
> Change the platform options for all commands below.

#### Download Playlist
```sh
bash iptv.sh movieark download
```
#### Edit Favorites Channels
```sh
bash iptv.sh movieark favorites
```
#### Create Favorites Playlist
```sh
bash iptv.sh movieark create
```

### Super Command
Run after doing all commands above for all platform options.<br>
This is join all platform playlists in one.
```sh
bash iptv.sh lls create
```

### Extra Commands
  - [Show](#show-favorites-files)
  - [Check](#check-new-channels)
  - [Clean](#clean-favorites-channels)

#### Show Favorites Files
```sh
bash iptv.sh movieark show
```
#### Check New Channels
```sh
bash iptv.sh movieark check
```
#### Clean Favorites Channels
```sh
bash iptv.sh movieark clean
```

#### Radios Stations
- 89FM: https://www.radios.com.br/play/playlist/31289/listen-radio.m3u
- UturnRadio: https://www.uturnradio.com/media/classic_rock.m3u
