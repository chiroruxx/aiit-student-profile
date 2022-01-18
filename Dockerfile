# syntax=docker/dockerfile:1
FROM ruby:2.7

ARG lockfile="Gemfile.lock"

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update -qq && apt-get install -y vim nodejs yarn postgresql-client

RUN mkdir /profile_app
WORKDIR /profile_app
COPY Gemfile /profile_app/Gemfile
COPY $lockfile /profile_app/Gemfile.lock
RUN bundle install
COPY . /profile_app
COPY $lockfile /profile_app/Gemfile.lock

RUN yarn install --check-files
RUN bundle exec rails webpacker:compile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
