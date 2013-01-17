# Rebuilding gifme

![Kramer Turkey](http://cl.ly/image/0o0O121n3V08/turkey.gif)

Start with this one-liner and a bunch of images to create a gif using
imagemagick:

```bash
$ convert -delay 1 -loop 0 -layers OptimizeTransparency ~/Desktop/turkey/* out.gif
```

Wrap it with a flexible CLI and distribute it as a RubyGem:

```bash
$ gifme --reverse --delay=1 --output=turkey.gif ~/Desktop/turkey*
```

## Credits

  - This is a rebuild of
    [Zach Holman's gifme gem](https://github.com/holman/gifme).
  - Avdi's [Ruby Tapas episodes 4 and 5](http://rubytapas.com) show some tricks
    used when refactoring.

## Slides

This may not be useful to anyone, but these are the notes I used when talking
about each commit in the repo.

### `start`

```bash
$ convert -delay 1 -loop 0 -layers OptimizeTransparency ~/Desktop/turkey/* out.gif
```

### `git co fac3d50`

copy one-liner into a file and make it +x

```bash
$ cat one-liner
$ ls -al one-liner
```

### `git co cf62128`

copy into rb file

``` ruby
$ irb
system "ruby -e 'puts 1'"
system "ruby", "-e", "puts 1"
```
```bash
$ ruby gifme.rb
```

### `git co 570e202`

remove ext, add shebang

```bash
$ ls -al gifme
$ ./gifme
```

### `git co 3a35364`

Accept files as arguments

```bash
$ ./gifme 1.png 2.png 3.png
$ ./gifme *.png
$ ./gifme ~/Desktop/turkey/turkery-0{1..9}.png
```

### `git co b3513af`

Accept delay and output arguments

```bash
$ ./gifme --delay=20 --output=other.gif ~/Desktop/turkey/turkery-0{1..9}.png
```

### `git co 231aa34`

Add reverse switch

```bash
$ ./gifme --reverse ~/Desktop/turkey/turkery-0{1..9}.png
```

### `git co 5de3c60`

Simple error handing

```bash
$ ./gifme
$ ./gifme --delay=FAIL ~/Desktop/turkey/turkery-0{1..9}.png
```

### `git co a6c764b`

Capture and present error from ImageMagick

```bash
$ ./gifme FAIL.png
```

### `git co 984d13e`

Refactor options using OptionParser. Use bareword literals for `delay`,
`reverse`, and `output`.

```bash
$ ./gifme --help
```

### `git co 8f21f62`

Trapping signals

```bash
$ ./gifme ~/Desktop/turkey/turkery-0{1..9}.png
```

### `git co fce0ef2`

Package into a gem

```bash
$ vim gifme.gemspec
$ vim Gemfile
```

Bundler, --standalone, --path, and --binstubs. Putting ./exec and ./script in
your $PATH (with warning).

```bash
$ cat script/package
```

Look to Faraday for great examples and best practices

  - https://github.com/lostisland/faraday/blob/master/faraday.gemspec
  - https://github.com/lostisland/faraday/blob/master/Rakefile
  - https://github.com/lostisland/faraday/blob/master/script/package

### `git co 669edcd`

Standand out vs error, piping, exit status

```bash
$ gifme ~/Desktop/turkey/turkery-099.png && echo SUCCESS
Something went horribly wrong. :(
SUCCESS

$ gifme ~/Desktop/turkey/turkery-0{1..9}.png | cloudapp
! "Success! Your handsome gif is living at /Users/Larry/out.gif." isn't a file
  that exists or a valid URL.

$ gifme ~/Desktop/turkey/turkery-099.png | cloudapp
! "Something went horribly wrong. :(" isn't a file that exists or a valid URL.
```

### `git co b29d5fd`

```bash
$ gifme ~/Desktop/turkey/turkery-0{1..9}.png | cloudapp
$ gifme ~/Desktop/turkey/turkery-099.png | cloudapp
$ gifme ~/Desktop/turkey/turkery-0{1..9}.png 1> out 2> err
```

### `git co 1b4d4c6`

Accepting files on standard in

```bash
$ ls ~/Desktop/turkey/turkery-0{1..9}.png
$ ls ~/Desktop/turkey/turkery-0{1..9}.png | gifme
No images to gif!

$ git show 1b4d4c6
```

### `git co fc9245b`

Write a man page for great justice!

```bash
$ vim man/gifme.1.ronn
$ cat script/gronn
```
