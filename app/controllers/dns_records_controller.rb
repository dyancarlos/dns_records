# frozen_string_literal: true

class DnsRecordsController < ApplicationController
	def create
	end

	private

	def dns_records_params
		params.require(:dns_records)
			.permit(:id, hostnames_attributes: [:hostname])
	end
end