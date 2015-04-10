# 下载器的主要职责是抓取网页并将网页内容返还给蜘蛛(Spiders)

require 'active_record'
require 'mysql2'

module FreeSpider
  module Downloader
  	ActiveRecord::Base.logger = Logger.new(STDERR)

		# 链接数据库
		puts "----database_connection-----"
  	ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      host: 'localhost',
      database: 'chuangkejiazu',
      username: 'root',
      password: '123'
    )

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

  	end

  end
end