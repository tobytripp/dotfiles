# -*- coding: utf-8 -*-
# frozen_string_literal: true
require "pathname"

namespace :encryption do
  namespace :keys do
    CLEAN.include "tmp/.keypass"
    CURVES = {
      "ES256" => "secp256k1",
      "ES384" => "secp384r1",
      "ES512" => "secp521r1"
    }
    ES512_CURVE = CURVES["ES512"]

    desc "Create public/private ECDSA keys (ES512) for token signatures"
    task :ec, [:private_key, :public_key, :path] do |t, args|
      args.with_defaults(
        path:       "tmp",
        private_key: ENV.fetch( "PRIVATE_KEY", "private.pem" ),
        public_key:  ENV.fetch( "PUBLIC_KEY",  "public.pem" ))

      cd args[:path] do
        private_key = Pathname.new( args[:private_key] )
        public_key  = Pathname.new( args[:public_key] )

        sh <<~SH
        openssl ecparam -name #{ES512_CURVE} -out ecparams.pem
        openssl ecparam -in ecparams.pem -genkey -noout -out #{private_key}
        openssl ec -in #{private_key} -pubout -out #{public_key}
        SH
      end
    end

    desc "Generate public/private RSA keys for data encryption"
    task :rsa, [:private_key, :public_key, :password] => :env do |t, args|
      args.with_defaults(
        private_key: ENV.fetch( "PRIVATE_KEY", "tmp/private.pem" ),
        public_key:  ENV.fetch( "PUBLIC_KEY",  "tmp/public.pem" ),
        password:    ENV.fetch( "KEY_PASS",     SecureRandom.base64( 128 ) ))

      passfile = Pathname.new "tmp/.keypass"
      touch passfile
      chmod 0600, passfile
      File.write( passfile, args[:password] )

      private_key = Pathname.new( args[:private_key] )
      public_key  = Pathname.new( args[:public_key] )

      sh <<~SH
      openssl genrsa \
              -des3 \
              -out #{private_key} \
      -passout file:#{passfile} \
      2048
      SH

      sh <<~SH
      openssl rsa \
              -in #{private_key} \
      -out #{public_key} \
      -passin file:#{passfile} \
      -outform PEM \
               -pubout
      SH
    end
  end
end
