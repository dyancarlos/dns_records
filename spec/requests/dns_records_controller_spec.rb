# frozen_string_literal: true
require "rails_helper"

RSpec.describe DnsRecordsController, type: :request do
  describe 'GET /dns_records' do
    before do
      Dns.create!(ip: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com'])
      Dns.create!(ip: '2.2.2.2', hostnames: ['ipsum.com'])
      Dns.create!(ip: '3.3.3.3', hostnames: ['ipsum.com', 'dolor.com', 'amet.com'])
      Dns.create!(ip: '4.4.4.4', hostnames: ['ipsum.com', 'dolor.com', 'sit.com', 'amet.com'])
      Dns.create!(ip: '5.5.5.5', hostnames: ['dolor.com', 'sit.com'])
    end

    subject { get dns_records_path, params: params }

    context 'with required params' do
      let(:params) { { page: 1 } }

      it 'respond in the correct format' do
        # ...
      end
    end

    context 'with optional params' do
      let(:params) { { page: 1, included: '', excluded: '' } }

      it 'respond in the correct format' do
        # ...
      end
    end
  end

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