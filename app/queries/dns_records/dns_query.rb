module DnsRecords
  class DnsQuery
    attr_reader :params

    def initialize(params)
      @params = params
    end
    
    def filter
    end
  end
end