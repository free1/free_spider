# FreeSpider

A simple spider

## Installation

Add this line to your application's Gemfile:

    gem 'free_spider'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install free_spider

## Usage

```
require 'free_spider'
spider = FreeSpider::Begin.new
spider.plan do
  site 'http://www.example.com/'
end
spider.crawl
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Feature

* 爬取时去除除网站外的外部链接，去除一些特殊链接，如：搜索链接
* 网站链接过多可以使用队列
* 多线程并发增加爬取速度
