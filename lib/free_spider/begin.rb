# 程序入口
require 'open-uri'
require 'nokogiri'
require 'logger'

module FreeSpider
  class Begin

    def initialize
      # 找到的链接
      @todo = []
      # 已经访问过的链接
      @visited = []
      @logger = Logger.new(STDOUT)
    end

    # 程序制定函数
    def plan(recipe = nil, &block)
      if block_given?
        instance_eval(&block)
        @recipe = block
      elsif recipe.is_a?(Proc)
        instance_eval(&recipe)
        @recipe = recipe
      elsif recipe.is_a?(String)
        instance_eval(recipe)
        @recipe = recipe
      else
        self
      end
    end

    def run(path)
      crawl if path == nil
      html = open(path).read
      doc = Nokogiri::HTML(html)
      # 选取页面链接
      all_href = []
      doc.css("a").map do |href|
        href = href.attributes["href"].value
        href = @site + href unless href.include?("#{@site}")
        all_href << href
      end
      # 去除重复链接
      @todo = all_href.uniq
      # 访问过的链接放入数组
      @visited << path
      puts "#{@todo}"
      crawl
    end

    def crawl
      path = nil
      loop do
        path = @todo.shift
        break if path.nil?
        break unless @visited.include?(path)
      end
      if path.nil?
        puts "结束"
      end
      run(path)
    end

    # 需要爬取的网站首页
    def site=(url)
      if url.empty?
        logger.info "URL is blank"
      else
        @site = url
      end
    end

  end
end