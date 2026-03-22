module V1
  module Jwt
    class ClaimsController < ApplicationController
      def show
        render json: {
          iss: "https://auth.example.test",
          sub: "usr_10",
          aud: "https://api.example.test",
          scope: "orders:read orders:write",
          iat: 1_774_156_800,
          exp: 1_774_160_400
        }
      end
    end
  end
end
