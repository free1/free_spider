# 下载器的主要职责是抓取网页并将网页内容返还给蜘蛛(Spiders)

require 'active_record'
require 'mysql2'

module FreeSpider
  module Downloader
  	ActiveRecord::Base.logger = Logger.new(STDERR)

    # 数据库配置文件
    # spec = Gem::Specification.find_by_name("database")
    # gem_root = spec.gem_dir
    p "============"
    p $LOAD_PATH
    environment = ENV['RACK_ENV'] || 'development'
    dbconfig = YAML.load(File.read("#{$LOAD_PATH.first}/config/database.yml"))

		# 链接数据库
		puts "----database_connection-----"
  	ActiveRecord::Base.establish_connection(dbconfig[environment])

  	# 创建表结构
  	puts "----table_create-----"
    ActiveRecord::Schema.define do
		  unless ActiveRecord::Base.connection.tables.include? 'news_teachings'
		    create_table :news_teachings do |table|
		      table.column :title,     :string
		      table.column :content,   :text
		    end
		  end
		end

  	class NewsTeaching < ActiveRecord::Base
  		validates_presence_of :title, :content
  	end

  end
end