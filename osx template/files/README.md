
## Build and Run ##

- `rake build`
- `rake run`

Run `rake -T` to display a list of supported tasks.

## Deploying to the App Store ##

To deploy to the App Store, you should use `rake clean
archive:distribution`, with a valid distribution certificate.

In your `Rakefile`, set the following values:

```ruby
# This is only an example, you certificate name will be different.
app.development do
  app.codesign_certificate = "Mac Developer: xxxxx"
end

app.release do
  app.codesign_certificate = "3rd Party Mac Developer Application: xxxxx"
end

app.codesign_for_development = true
app.codesign_for_release = true
```

The use of [motion-provisioning](https://github.com/HipByte/motion-provisioning) is also recommended.

## Icons ##

Apple supports the use of both `.icns` and Asset Catalogs for defining icons.

### ICNS ###

Place your icon under `./resources/`, and add the following line to the `Rakefile`:

```
  app.icon = "YourIconName" # CFBundleIconFile
```

### Asset Catalogs ###

You will find the default project icon under `./resources/Assets.xcassets`. To create your own, 
a graphics application such as [Gimp](https://www.gimp.org) can be used, and you can use the following method to generate all the icon sizes (once you've created and specified the `1024x1024.png`).

Save this script to `./gen-icons.sh` and run it:

```sh
set -x

brew install imagemagick

pushd resources/Assets.xcassets/AppIcon.appiconset/

for size in 512 256 128 32 16
do
  cp "1024x1024.png" "Icon_${size}x${size}.png"
  mogrify -resize "$((size))x$((size))" "Icon_${size}x${size}.png"

  cp "1024x1024.png" "Icon_${size}x${size}@2x.png"
  mogrify -resize "$((size*2))x$((size*2))" "Icon_${size}x${size}@2x.png"
done

popd
```

Add the following line to the `Rakefile`:

```
  app.icon = 'AppIcon' # CFBundleIconFile
```

For more information about Asset Catalogs, refer to Apple's [Asset Catalog Format Reference](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/).


## Contributing ##

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
