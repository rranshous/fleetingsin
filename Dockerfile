FROM paintedfox/ruby
MAINTAINER Robby Ranshous <rranshous@gmail.com>

RUN apt-get install -y curl

RUN gem install sinatra foreman thin --no-ri --no-rdoc
ADD . /opt/app
EXPOSE 5000

CMD /opt/app/boot.sh
