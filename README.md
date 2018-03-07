# IdcardOperation

身份证查询校验, 根据身份证返回所有包含的信息

## 大陆地区
- 是否通过校验
- 性别
- 出生地所在省份
- 具体出生地
- 出生日期

## 台湾地区
- 是否通过校验
- 性别
- 出生地

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'idcard_operation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install idcard_operation

## Usage

```
require 'idcard_operation'

2.4.2 :008 > info = IdcardOperation.analysis("330411198702198263")  # 身份证是模拟的
 => #<IdcardInfo:0x00007fae6818df08 @idcard="330411198702198263", @valid=true, @birthday=#<Date: 1987-02-19 ((2446846j,0s,0n),+0s,2299161j)>, @gender="女", @location_raw="浙江省嘉兴市郊区", @main_location="浙江省">

2.4.2 :009 > info.to_h
 => {:idcard=>"330411198702198263", :valid=>true, :birthday=>#<Date: 1987-02-19 ((2446846j,0s,0n),+0s,2299161j)>, :gender=>"女", :location_raw=>"浙江省嘉兴市郊区", :main_location=>"浙江省"}

2.4.2 :010 > info = IdcardOperation.analysis("S174475135")
 => #<RocIdcardInfo:0x00007fae68177348 @idcard="S174475135", @gender="男", @location="高雄县">

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/idcard_operation. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the IdcardOperation project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/idcard_operation/blob/master/CODE_OF_CONDUCT.md).
