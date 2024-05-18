# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create Users
users = User.create([
  { email: "john.doe@example.com", password_digest: "password", first_name: "John", last_name: "Doe", username: "johndoe", postal_code: "12345", address: "123 Main St", phone: "555-1234" },
  { email: "jane.smith@example.com", password_digest: "password", first_name: "Jane", last_name: "Smith", username: "janesmith", postal_code: "67890", address: "456 Elm St", phone: "555-5678" }
])

# Create Articles
articles = Article.create([
  { title: "First Article", body: "This is the body of the first article.", user: users.first },
  { title: "Second Article", body: "This is the body of the second article.", user: users.last }
])

# Create Comments
comments = Comment.create([
  { body: "Great article!", user: users.first, article: articles.first },
  { body: "Very informative.", user: users.last, article: articles.last }
])

# Create Tags
tags = Tag.create([
  { name: "Technology" },
  { name: "Education" }
])

# Create Taggings
Tagging.create([
  { article: articles.first, tag: tags.first },
  { article: articles.last, tag: tags.last }
])
