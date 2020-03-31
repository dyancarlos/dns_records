module DnsRecords
	class Create
		attr_reader :params

		def initialize(params)
			@params = params
		end

		def call
			Dns.create(ip: ip, hostnames: hostnames)
		end

		private

		def ip
			params[:ip]
		end

		def hostnames
			params[:hostnames_attributes].map { |hostname| hostname[:hostname] }
		end
	end
end