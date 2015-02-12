FROM base

MAINTAINER tcnksm "https://github.com/kimzvik"

# Install packages for building ruby
RUN apt-get update
RUN apt-get install -y --force-yes build-essential wget git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

RUN wget -P /root/src ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
RUN cd /root/src; tar xvf ruby-2.0.0-p247.tar.gz
RUN cd /root/src/ruby-2.0.0-p247; ./configure; make install

RUN gem update --system
RUN gem install bundler

RUN git clone https://github.com/kimzvik/RubySinatra
RUN cd /root/sinatra; bundle install

EXPOSE 4567
CMD ["/usr/local/bin/foreman","start","-d","/root/sinatra"]



