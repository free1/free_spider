# 下载器的主要职责是抓取网页并将网页内容返还给蜘蛛(Spiders)

module FreeSpider
  module Downloader
  	ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      host: 'localhost',
      database: 'chuangkejiazu',
      username: 'root',
      password: '123'
    )

  	class NewsTeaching < ActiveRecord::Base

  	end

  end
end