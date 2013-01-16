lib = 'gifme'
lib_file = File.expand_path("../lib/#{lib}.rb", __FILE__)
File.read(lib_file) =~ /\bVERSION\s*=\s*["'](.+?)["']/
version = $1

Gem::Specification.new do |spec|
  spec.name        = lib
  spec.version     = version

  spec.summary     = "Fucking animations. You need them."
  spec.description = "A command-line way to generate really fucking cool gifs."

  spec.authors     = ["Zach Holman"]
  spec.email       = 'hello@zachholman.com'
  spec.homepage    = 'https://github.com/holman/gifme'
  spec.license     = 'MIT'

  spec.add_development_dependency 'ronn'

  spec.files = %w(Gemfile Rakefile)
  spec.files << "#{lib}.gemspec"
  spec.files += Dir.glob("man/*")
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("spec/**/*.rb")

  dev_null    = File.exist?('/dev/null') ? '/dev/null' : 'NUL'
  git_files   = `git ls-files -z 2>#{dev_null}`
  spec.files &= git_files.split("\0") if $?.success?

  spec.executables << 'gifme'
end
