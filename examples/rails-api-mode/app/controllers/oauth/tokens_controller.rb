module Oauth
  class TokensController < ApplicationController
    def create
      case params[:grant_type]
      when "client_credentials"
        render json: {
          access_token: "at_123",
          token_type: request.headers["DPoP"].present? ? "DPoP" : "Bearer",
          expires_in: 300,
          scope: params[:scope] || "orders:read"
        }
      when "password"
        render json: {
          access_token: "at_ropc_123",
          token_type: "Bearer",
          expires_in: 3600,
          refresh_token: "rt_ropc_123",
          scope: params[:scope] || "profile orders:read"
        }
      when "urn:ietf:params:oauth:grant-type:token-exchange"
        render json: {
          access_token: "at_reports_123",
          token_type: "Bearer",
          expires_in: 120,
          scope: params[:scope] || "reports:read"
        }
      else
        render json: {
          error: {
            code: "unsupported_grant_type",
            message: "The grant_type is not supported by this example."
          }
        }, status: :bad_request
      end
    end
  end
end
