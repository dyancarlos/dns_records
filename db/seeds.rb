records = [['1.1.1.1', ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com']],
					 ['2.2.2.2', ['ipsum.com']],
					 ['3.3.3.3', ['ipsum.com', 'dolor.com', 'amet.com']],
					 ['4.4.4.4', ['ipsum.com', 'dolor.com', 'sit.com', 'amet.com']],
					 ['5.5.5.5', ['dolor.com', 'sit.com']]]

records.each do |record|
	Dns.create(ip: record[0], hostnames: record[1])
end