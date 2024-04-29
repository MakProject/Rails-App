#Set base image
FROM ruby:3.1.2-alpine

#Update source and install required packages
RUN apk --update --no-cache add tzdata libpq-dev nodejs npm build-base

#Set work directory
WORKDIR /app

#Copy rest of the application code to work dir
COPY . .

#Install bundler package manager for ruby 
RUN gem install bundler

#Install ruby dependencies
RUN bundle install

#Install node dependencies
RUN npm install

#Create and migrate app database to postgresql and setup server in port 3000
CMD sh -c "rails db:create && rails db:migrate && rails s -b 0.0.0.0 -p 3000"
