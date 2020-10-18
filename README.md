# Book Explorer

A Ruby on Rails application that shows the content of a CSV file containing a list of books. CSV's are stored on Amazon's S3, and the application is currently being hosted here.
  - https://timersbookexplorer.herokuapp.com

# Requirements

- [RVM](http://rvm.io/)
- [Ruby 2.7.1](https://www.ruby-lang.org/en/news/2019/04/17/ruby-2-6-3-released/)
- [Git](https://git-scm.com/)

# Usage

The application can be tested locally. After downloading the repository, run bundle install. Then run rake db:create db:migrate. After that, run rails server and the application will begin running on localhost:3000.

# Run Rspec tests & rubocop
- `$ bundle exec rspec` to run the test suite
- `$ bundle exec rubocop` to run rubocop against code


# Features
- Registration: register yourself by supplying a username, email and password. Logging in can be done using either username/email and password.
- File Upload: upload a valid CSV file, which will be stored on Amazon's S3. An external service will be notified of this successful posting.
- Content management: by viewing all your previously uploaded CSV files


# Further Breakdown of features
The uploaded file can only be of the file format ".csv". It must also contain these specific headers: "Book Title", "Book Author", "Date published", "ISBN", "publishers name". Any more/less will lead to the file not being uploaded.

The ISBN must itself be valid. If the ISBN fails to be valid, the CSV will be rejected. Once the file has been validated, the CSV is then uploaded into Amazon's S3. There is also a notifcation being sent to an external service. This will perform a POST request to the following API endpoint:
- https://enbrtwpe490a7.x.pipedream.net
It will also include the S3 URL of the uploaded file. 

After the upload, the user will be shown the CSV the have uploaded. The will then be able to view other previously uploaded CSV's by navigating to MyUploads

# Additional notes

- This was the first time I've used S3, so there was a lot of reading involved. The official documentation came in really handy in understanding how storing to S3 works.
- I used the Devise gem for the registration of new users and then handling them. This gem is well known in the community.
- I used isbn gem to validate the ISBN number being passed. My first inclination was to use isbndb, however a paid subscription is needed. The gem I ended up using should suffice for the task however, as it checks if the ISBN valid.
- For my frontend, I settled with Bootstrap. The project should not need the use of JS frameworks, however can be implemented in the future if I want more features.

# Further actionpoints (that would need clarification):
* Allow users to delete/edit already posted CSV's
