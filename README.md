# swift-image_cache

Using this code, you can add a mini cache to your app.

In the FilesCache class, you'll see three levels for an image URL (String). First I verify in NSCache (memory), second I verify in disk and if I have not a data, I'll get it from the server.

So, copy and paste this code to load, cached in memory and save in disk an image from URL :)

```
  let imageURL = "https://e00-marca.uecdn.es/assets/multimedia/imagenes/2017/04/24/14930199061053.jpg"
  FilesCache.shared.serviceProtocol = ImageService()
  FilesCache.shared.getImage(imageUrl: imageURL, completion: { image in
      DispatchQueue.main.async {
          self.imageView.image = image
      }
  })
```
