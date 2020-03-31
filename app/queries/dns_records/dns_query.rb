module DnsRecords
  class DnsQuery
    attr_reader :params

    def initialize(params)
      @params = FormatParams.new(params)
    end
    
    def filter
      result = Dns.all
      result = filter_by_included_hostnames(result, params.included) if params.included.present?
      result = filter_by_excluded_hostnames(result, params.excluded) if params.excluded.present?
      result
    end

    def related_hostnames
      params.included.map do |hostname|
        {
          hostname: hostname,
          count: related_hostnames_count(hostname)
        }
      end
    end

    private

    def filter_by_included_hostnames(result, hostnames)
      result.where("hostnames @> ARRAY[?]::varchar[]", hostnames)
    end

    def filter_by_excluded_hostnames(result, hostnames)
      result.where.not("hostnames @> ARRAY[?]::varchar[]", hostnames)
    end

    def related_hostnames_count(hostname)
      Dns.where("'#{hostname}' = ANY (hostnames)").count
    end
  end
end