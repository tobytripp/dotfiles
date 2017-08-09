desc "Load environment files into ENV"
dtask :env do
  require "bundler"
  Bundler.setup :default, ENV.fetch( "RACK_ENV", :development )
  Bundler.require
  require "dotenv"
  Dotenv.load(
    ".env.#{ENV.fetch( "RACK_ENV", :development )}",
    ".env" )
end
