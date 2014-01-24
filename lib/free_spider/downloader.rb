# 下载器的主要职责是抓取网页并将网页内容返还给蜘蛛(Spiders)
# 例子(找到rubychina中精华帖的链接)：
# a = FreeSpider::Downloader.new("http://ruby-china.org/topics/excellent", ".infos .title a", "href")
# a.crawl
require 'open-uri'
require 'nokogiri'

module FreeSpider
  class Downloader
    
  end
end