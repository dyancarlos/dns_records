module DnsRecords
  class FormatParams
    attr_reader :params

    def initialize(params)
      @params = params
    end
    
    def included
      split_params params[:included]
    end
    
    def excluded
      split_params params[:excluded]
    end
    
    private
    
    def split_params(param)
      Array param&.split(',')&.map(&:strip)
    end
  end
end