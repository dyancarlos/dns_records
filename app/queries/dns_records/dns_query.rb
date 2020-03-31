module DnsRecords
  class DnsQuery
    attr_reader :params

    def initialize(params)
      @params = params
    end
    
    def filter
      result = Dns.all
      result = result.where("hostnames @> ARRAY[?]::varchar[]", included) if included?
      result = result.where.not("hostnames @> ARRAY[?]::varchar[]", excluded) if excluded?
      result
    end

    def related_hostnames
      (included - excluded).each_with_object([]) do |hostname, array|
        array << {
          hostname: hostname,
          count: related_hostnames_count(hostname)
        }
      end
    end

    private

    def related_hostnames_count(hostname)
      Dns.where("'#{hostname}' = ANY (hostnames)").count
    end

    # extract to another class to format the object
    #
    def included?
      params[:included].present?
    end

    def excluded?
      params[:excluded].present?
    end

    def included
      params[:included].split(',').map(&:strip)
    end

    def excluded
      params[:excluded].split(',').map(&:strip)
    end
  end
end