# encoding: utf-8
require 'httparty'
require 'nokogiri'

class Denma
	@@DENMA_URL = 'http://m.comic.naver.com/webtoon/list.nhn?titleId=119874'	
	@@SLACK_URL = '{{YOUR_SLACK_WEBHOOK_URL}}'
	@@NAVER_WEBTOON_URL = 'http://comic.naver.com'

	def run
		title = get_last_title.gsub(/\s+/, "")
		url = get_last_url
		log_title = get_log_title.gsub(/\s+/, "")

		if title != log_title
			set_log_title(title)
			result = send_to_slack(url)
			puts result
		end
	end

	def get_last_title
		get_denma_data.css("ul.toon_lst > li")[0].css('span.toon_name > strong > span').text
	end

	def get_last_url
		@@NAVER_WEBTOON_URL + get_denma_data.css("ul.toon_lst > li")[0].css('a').attribute('href').to_s
	end

	def get_denma_data
		Nokogiri::HTML(HTTParty.get(@@DENMA_URL).body)
	end

	def get_log_title
		begin
			f = File.open('./denma.txt', 'r:utf-8')
			f.readline
		rescue 
			return ''
		end
	end

	def set_log_title(title)
		f = File.open('./denma.txt', 'w:utf-8')
		f.write(title)
		f.close
	end

	def send_to_slack(url)
		data = generate_message(url)
		payload = { 'payload' => data.to_json }

		HTTParty.post(@@SLACK_URL, body: payload)
	end

	def generate_message(url)
		data = {
			'username' => '덴경대',
			'text' => "<#{url}|덴경대집합!>"
		}

		data
	end
end

denma = Denma.new
denma.run
