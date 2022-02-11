# How I Converted Shit

(bruh) Wrote script to detect dupes

## Replaced spaces in filenames
 
```bash
for file in *; do 
    if [ -f "$file" ]; then
        mv "$file" `echo "$file" | tr ' ' '_'` 2> /dev/null
    fi
done

```

## Convert to Landscape

Script to re-orient and resize to 4k exactly, EVERY image is 3840x2160, give or take a few pixels. This means images come into Premiere unscaled.

Ken Burns effect, 107% -> 100%, works on every image with no odd pans away from subject.

change clip length, TImeline settings to 8s (turns out to be 7;29?), create preset (linear at keyframes)
apply default transition (crossfade)
apply ken burns, preset