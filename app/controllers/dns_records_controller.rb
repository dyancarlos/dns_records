# frozen_string_literal: true

class DnsRecordsController < ApplicationController
  def index
    dns_records = DnsRecords::DnsQuery.new(params)

    render json: DnsSerializer.new(dns_records).as_json
  end

  def create
    dns_record = DnsRecords::Create.new(dns_records_params).call

    if dns_record
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