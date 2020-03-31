class DnsSerializer
  attr_reader :collection, :related_hostnames

  def initialize(collection)
    @collection = collection.filter
    @related_hostnames = collection.related_hostnames
  end

  def as_json
    {
      total_records: collection.count,
      records: records,
      related_hostnames: related_hostnames
    }
  end

  private

  def records
    collection.map do |dns|
      {
        id: dns.id, 
        ip_address: dns.ip
      }
    end
  end
end