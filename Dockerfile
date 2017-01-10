FROM rails:4.2.5
MAINTAINER BioSistemika <info@biosistemika.com>

# additional dependecies
RUN apt-get update -qq && \
  apt-get install -y \
  default-jre-headless \
  unison \
  sudo graphviz --no-install-recommends \
  sudo libfile-mimeinfo-perl && \
  rm -rf /var/lib/apt/lists/*

# heroku tools
RUN wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# install gems
COPY Gemfile* /tmp/
COPY quill-rails /tmp/quill-rails
WORKDIR /tmp
RUN bundle install
RUN rm -rf quill-rails

# create app directory
ENV APP_HOME /usr/src/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
RUN mkdir quill-rails
RUN ln -s $(readlink -f quill-rails) /tmp

# container user
RUN groupadd scinote
RUN useradd -ms /bin/bash -g scinote scinote
USER scinote

CMD rails s -b 0.0.0.0
