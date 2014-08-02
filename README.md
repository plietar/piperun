# Piperun

Piperun allows you to process your application's assets in using pipelines seamlessly.
It is more lightweight than the Rails pipeline, but more appropriate than task runners like Grunt.

It takes assets from a source directory, applies a number a filters to transform them,
and puts the result in a destination directory.

Temporary files are automagically managed by Piperun so you do not have to bother about them.

## Installation

Add this line to your application's Gemfile:

    gem 'piperun'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install piperun

## Usage

Create a `Pipefile.rb` file at the root of your project, in which are defined one or more pipelines :

    pipeline 'scripts', 'public/js' do
      match '*.js'
      yui_js
    end

    # Slightly more complex example
    pipeline 'styles', 'public/css' do
      parallel do # execute two pipelines on the same source files
        run do # take sass and scss files and compile them into css
          match '*.sass', '*.scss'
          sass # sass and scss filters are identical
        end

        run do # take only css files
          match '*.css'
        end
      end

      # We now have only css files, either copied from source or compiled from sass

      yui_css # minify the stylesheets
    end

Now run `piperun` in your root directory, and your files will be available in `public/js` and `public/css` !

### Filters

The following filters are supported :
- Copy
- Match
- Parallel
- Tar
- Gz
- Sass / Scss
- Browserify
- YUI JS and CSS compressors

Feel free to make a PR to add some. Check out examples in `lib/piperun/filters/` to see how.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
