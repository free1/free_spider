# 蜘蛛是有Scrapy用户自己定义用来解析网页并抓取制定URL返回的内容的类，每个蜘蛛都能处理一个域名或一组域名。
# 用来定义特定网站的抓取和解析规则。

module FreeSpider
  class Parser

    def initialize(url, css, attributes)
      @url = url
      @css = css
      @attributes = attributes
    end

    def fetcher
      html = open(@url).read
      doc = Nokogiri::HTML(html)
      # 找到网页中需要的内容
      doc.css("#{@css}").map do |href|
        href.attributes["#{@attributes}"].value
      end
    end

  end
end
