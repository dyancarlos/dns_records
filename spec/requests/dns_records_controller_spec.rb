# frozen_string_literal: true
require "rails_helper"

RSpec.describe DnsRecordsController, type: :request do
  describe 'POST /dns_records' do
    let(:params) do
      {
        dns_records: {
          ip: '1.1.1.1',
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
      it 'create the record' do
        expect { subject }.to change { Dns.count }.by(1)
      end

      it 'respond in the correct format' do
        subject
        expect(response.body).to eq({ id: Dns.last.id }.to_json)
      end

      it 'create the record with correct data' do
        subject
        expect(Dns.last.ip).to eq '1.1.1.1'
        expect(Dns.last.hostnames).to match_array(['lorem.com'])
      end
    end
  end
end