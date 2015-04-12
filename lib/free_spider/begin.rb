# encoding = utf-8

# 生成gem
# gem build free_spider.gemspec
# 安装gem
# gem install free_spider
# 提交gem
# gem push free_spider-0.0.1.gem

# 程序入口
# require 'free_spider'
# spider = FreeSpider::Begin.new
# spider.plan do
#   site 'http://www.dfrobot.com.cn/'
# end
# spider.crawl

# 调试
# pry -Ilib -rfree_spider
# irb -Ilib -rfree_spider

# coending = utf-8
require 'open-uri'
require 'nokogiri'
# require 'active_record'
# require 'mysql2'
# require 'logger'

module FreeSpider
  class Begin

    def initialize
      # 找到的链接
      @todo = []
      # 已经访问过的链接
      @visited = []
      @news_teaching_content = {}
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
      puts "--------find_link--------"
      begin
        crawl if path == nil
        html = open(path).read
        # html = open('http://www.dfrobot.com.cn/').read
        # 访问过的链接放入数组
        @visited << path
        # p "================"
        # p @visited
        # p path
        doc = Nokogiri::HTML(html)
        # 抓取链接加入爬取队列
        doc.css("a").map do |href|
          # 选取内容
          # title = href.attributes["title"]
          # title_content = href.attributes["title"].value unless title.nil?
          # 处理链接
          href = href.attributes["href"].value unless href.attributes["href"].nil?
          # 去除重复链接
          href = @site + href unless href.include?("#{@site}")

          # 加入爬取队列
          @todo << href
        end

        # 抓取主要内容
        doc.css(".entry-content p").each do |entry_content|
          ss
          content = entry_content.children.to_html unless entry_content.nil?
          p "--------content--------"
          p content
          # 放入将存入的内容
          # news_teaching_content = {title: title, content: "ss"}
          # @news_teaching_content.merge! news_teaching_content
        end


        # 去除重复链接
        # @todo.uniq
        # 打印信息, 写入文件or数据库
        # puts "#{@visited}"
        # p @titles.uniq.compact
        write_results_to_database
        # write_results_to_file('title_out')
        crawl
      rescue OpenURI::HTTPError
        puts "404"
        crawl
      rescue RuntimeError
        puts "redirection forbidden"
        crawl
      rescue URI::InvalidURIError
        puts "bad URI"
        crawl
      ensure

      end
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
        # 输出抓取内容
        # post_title
        return
      end
      find_link(path)
    end

    # 需要爬取的网站首页
    def site(url)
      puts "--------Ready---------"
      if url.empty?
        puts "URL is blank"
      else
        @site = url
        @todo << @site
      end
    end

    # 写入mysql
    def write_results_to_database
      news_teaching = FreeSpider::Downloader::NewsTeaching.new(@news_teaching_content)
      if news_teaching.save
        puts "--------save success!--------"
      else
        puts "--------save error!--------"
      end
    end

    # def post_title
    #   @titles.uniq.compact
    # end

    # 写入文件
    def write_results_to_file(file_name)
      if File.exist?(file_name) || File.new(file_name, "w")
        File.open(file_name, "w") do |f|
          f.write(@titles.uniq.compact)
        end
      end
    end

  end
end