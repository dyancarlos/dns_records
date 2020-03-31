# frozen_string_literal: true

class DnsRecordsController < ApplicationController
  def index
    dns = DnsRecords::DnsQuery.new(params).filter
  end

  def create
    dns = DnsRecords::Create.new(dns_records_params).call

    if dns
      render json: { id: dns.id }
    else
      render status: :internal_server_error
    end
  end

  private

  def dns_records_params
    params.require(:dns_records)
      .permit(:ip, hostnames_attributes: [:hostname])
  end
end