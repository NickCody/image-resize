# Image Aspect-Ratio Normalizer for Slideshows

This is a little bit of shell magic to process a directory of images and normalize them with black borders so every image becomes exactly 4k resolution at the exact same aspect ratio. It's useful for importing images into premier and avoiding Premier auto-zooming your images. When premiere auto-zooms your images, its harder to apply slideshow presenst like a ken-burns effect since the zoom needs to be dynamic. A static zoom will work if you use images processed by code in this repo.

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
- In the end, EVERY image is 3840x2160, give or take a few pixels. This means images come into Premiere unscaled.
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
