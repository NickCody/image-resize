# How I Converted Shit

## Install ImageMagick

On Mac:

    brew install imagemagick

On Linux/WSL:

    sudo apt install imagemagick

## resize.sh bash script

First, we replaced spaces in filenames
 
```bash
for file in *; do 
    if [ -f "$file" ]; then
        mv "$file" `echo "$file" | tr ' ' '_'` 2> /dev/null
    fi
done

```

Then we resize all images to precisely 16:9:

- Script to re-orient and resize to 4k exactly
- EVERY image is 3840x2160, give or take a few pixels. This means images come into Premiere unscaled.
- Square -> Landscape
- Portrait -> Landscape
- Non-16:9 Landscape to 16:9

## Adobe Premiere

- Ken Burns effect, 107% -> 100%, works on every image with no odd pans away from subject.
    - Create preset
    - Linear at keyframes
- Change clip length to match ken Burns Preset
    - Timeline settings change Still image duration to 8s (turns out to be 7;29?), 
- Apply default transition (crossfade)
- Apply ken burns, preset
