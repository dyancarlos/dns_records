# frozen_string_literal: true
require "rails_helper"

RSpec.describe DnsRecordsController, type: :request do
  describe 'GET /dns_records' do
    before :each do
      Dns.create!(id: 1, ip: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com'])
      Dns.create!(id: 2, ip: '2.2.2.2', hostnames: ['ipsum.com'])
      Dns.create!(id: 3, ip: '3.3.3.3', hostnames: ['ipsum.com', 'dolor.com', 'amet.com'])
      Dns.create!(id: 4, ip: '4.4.4.4', hostnames: ['ipsum.com', 'dolor.com', 'sit.com', 'amet.com'])
      Dns.create!(id: 5, ip: '5.5.5.5', hostnames: ['dolor.com', 'sit.com'])
    end

    subject { get dns_records_path, params: params }

    context 'with required params' do
      let(:params) { { page: 1 } }
      let(:success_response) do
        {
          total_records: 5,
          records: [
            {
              id: 1,
              ip_address: '1.1.1.1'
            },
            {
              id: 2,
              ip_address: '2.2.2.2'
            },
            {
              id: 3,
              ip_address: '3.3.3.3'
            },
            {
              id: 4,
              ip_address: '4.4.4.4'
            },
            {
              id: 5,
              ip_address: '5.5.5.5'
            }
          ],
          related_hostnames: []
        }.to_json
      end

      it 'respond all the records in the correct format' do
        subject
        expect(response.body).to eq success_response
      end
    end

    context 'without required params' do
      let(:params) { {} }

      it 'respond with error message' do
        subject
        expect(response.body).to eq({ error: 'Page parameter is required.' }.to_json)
      end
    end

    context 'with optional params' do
      context 'with included param' do
        let(:params) { { page: 1, included: 'lorem.com, ipsum.com' } }
        let(:success_response) do
          {
            total_records: 1,
            records: [
              {
                id: 1,
                ip_address: '1.1.1.1'
              }
            ],
            related_hostnames: [
              {
                hostname: 'lorem.com',
                count: 1
              },
              {
                hostname: 'ipsum.com',
                count: 4
              }
            ]
          }.to_json
        end

        it 'respond in the correct format' do
          subject
          expect(response.body).to eq success_response
        end
      end

      context 'with excluded param' do
        let(:params) { { page: 1, included: 'lorem.com, ipsum.com', excluded: 'ipsum.com' } }
        let(:success_response) do
          {
            total_records: 0,
            records: [],
            related_hostnames: [
              {
                hostname: 'lorem.com',
                count: 1
              },
              {
                hostname: 'ipsum.com',
                count: 4
              }
            ]
          }.to_json
        end

        it 'respond in the correct format' do
          subject
          expect(response.body).to eq success_response
        end
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