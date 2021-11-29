# This is just a helper file to clear all of the images in the 'images'
# folder and all of the files in the 'output' folder. Basically, it's a
# hard reset.
do.call(file.remove, list(list.files("content/image-randomize/images", full.names = TRUE)))
do.call(file.remove, list(list.files("content/image-randomize/output", full.names = TRUE)))
