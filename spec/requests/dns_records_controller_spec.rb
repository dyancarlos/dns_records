# frozen_string_literal: true
require "rails_helper"

RSpec.describe DnsRecordsController, type: :request do
	describe 'POST /dns_records' do
		let(:params) do
			{
				dns_records: {
					id: '1.1.1.1',
					hostnames_attributes: [
						{
							hostname: 'lorem.com'
						}
					]
				}
			}
		end

		subject { post dns_records_path, params: params }

		context 'when new dns record' do
			it 'save the record' do
				subject
			end
		end
	end
end