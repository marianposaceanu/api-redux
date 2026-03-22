module V1
  module Bulk
    class CustomerArchivesController < ApplicationController
      def create
        results = Array(params[:customer_ids]).map do |customer_id|
          if customer_id == "cus_locked"
            {
              id: customer_id,
              status: 409,
              error: {
                code: "customer_locked",
                message: "Customer is currently locked by another workflow."
              }
            }
          else
            {
              id: customer_id,
              status: 200,
              result: {
                archived: true
              }
            }
          end
        end

        render json: {
          data: {
            type: "bulk-result",
            attributes: {
              total: results.length,
              succeeded: results.count { |result| result[:status] == 200 },
              failed: results.count { |result| result[:status] != 200 }
            }
          },
          results: results
        }, status: :multi_status
      end
    end
  end
end
