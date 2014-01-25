# 程序入口
# require 'free_spider'
# spider = FreeSpider::Begin.new
# spider.plan do
#   site 'http://ruby-china.org'
# end
# spider.crawl

require 'open-uri'
require 'nokogiri'
# require 'logger'

module FreeSpider
  class Begin

    def initialize
      # 找到的链接
      @todo = []
      # 已经访问过的链接
      @visited = []
    end

    # 程序制定函数，用户选择需要抓取的网页内容
    def plan(&block)
      if block_given?
        instance_eval(&block)
      else
        puts "no plan"
      end
    end

    # 查找网页中的链接
    def find_link(path)
      crawl if path == nil
      html = open(path).read
      # 访问过的链接放入数组
      @visited << path
      doc = Nokogiri::HTML(html)
      doc.css("a").map do |href|
        href = href.attributes["href"].value
        href = @site + href unless href.include?("#{@site}")
        @todo << href
      end
      # 去除重复链接
      @todo.uniq
      puts "#{@visited}"
      crawl
    end

    # 程序开始函数
    def crawl
      path = nil
      loop do
        # 选取找到的链接中的一个链接
        path = @todo.shift
        break if path.nil?
        # 如果是访问过的链接就重新选取
        break unless @visited.include?(path)
        # 去掉外部链接
        # 去掉特殊链接
      end
      if path.nil?
        puts "结束"
        return
      end
      find_link(path)
    end

    # 需要爬取的网站首页
    def site(url)
      if url.empty?
        puts "URL is blank"
      else
        @site = url
        @todo << @site
      end
    end

  end
end