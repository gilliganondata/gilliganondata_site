# Nested functions. Final sequence is:
# 1. Cycle through the list of albums (get_album_images) to get the list of images
# 2. Cycle through the list of images within each album to be the image details

# Function to get the image details extracted
get_image_details <- function(img){
  df <- tibble(Title = img$Title,
               Caption = img$Caption,
               Keywords = img$Keywords,
               Latitude = img$Latitude,
               Longitude = img$Longitude,
               FileName  = img$FileName,
               UploadKey = img$UploadKey,
               Date = img$Date,
               DateTimeUploaded = img$DateTimeUploaded,
               DateTimeOriginal = img$DateTimeOriginal,
               Format = img$Format,
               OriginalHeight = img$OriginalHeight,
               OriginalWidth = img$OriginalWidth,
               OriginalSize = img$OriginalSize,
               LastUpdated = img$LastUpdated,
               ImageKey = img$ImageKey,
               LargestImgUri = img$Uris$LargestImage$Uri,
               Uri = img$Uri,
               WebUri = img$WebUri)
}

# Function to get image details for all images in an album
get_album_images <- function(album_key){
  
  # Get a list of the images from an album
  album_images <- GET(url ="http://www.smugmug.com",
                      query = list(APIKey = sm_key),
                      path = sprintf("/api/v2/album/%s!images", album_key),
                      accept_json()) %>% 
    content()
  
  # List of the images
  images_list <- album_images$Response$AlbumImage
  
  img_df <- map_dfr(images_list, get_image_details)
  
}

all_images <- map_dfr(albums_list, get_album_images)
