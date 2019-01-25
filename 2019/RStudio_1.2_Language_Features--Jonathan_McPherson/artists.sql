-- !preview conn=con

SELECT * FROM "albums", "artists"
WHERE albums.ArtistId = artists.ArtistId
