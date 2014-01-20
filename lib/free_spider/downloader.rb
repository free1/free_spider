# 下载器的主要职责是抓取网页并将网页内容返还给蜘蛛( Spiders)
require 'open-uri'

module FreeSpider
  class Downloader

    URL = "http://ruby-china.org/"

    def fetcher
      html = open(URL).read
      doc = Nokogiri::HTML(html)
      # doc.css()
    end
  end
end