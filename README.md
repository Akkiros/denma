# 덴마 슬랙봇

### 설치

```ruby
gem install httparty
gem install nokogiri
```

두개의 젬을 사용하고 있으니 설치해준다.


그리고 crontab 에 추가해준다.

```sh
*/5 * * * * /usr/bin/ruby /Users/Akkiros/Documents/denma/denma.rb >> /Users/Akkiros/Documents/denma/cron.log
```

처럼 해당 파일이 있는 경로와 log 를 남길 경로를 수정해서 적어준다.

RVM 을 사용할경우 cron 을 실행할 때 gem 을 못찾는 오류가 발생한다면 다음 명령어를 실행해준다.  
`rvm cron setup`
