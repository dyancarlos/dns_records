# frozen_string_literal: true

class DnsRecordsController < ApplicationController
  def index
    if params[:page]
      render json: DnsSerializer.new(DnsRecords::DnsQuery.new(params)).as_json
    else
      render json: { error: 'Page parameter is required.' }
    end
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